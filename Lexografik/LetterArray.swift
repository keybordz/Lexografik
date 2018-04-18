//
//  LetterArray.swift
//  Lexografik
//
//  Created by Jay Wright on 9/17/15.
//  Copyright (c) 2015 Keybordz. All rights reserved.
//

import Foundation

enum SyllableState: Int {
    case articulateStart = 0
    case articulateVowel
    case articulateStop
}

enum NextLetterBias: Int {
    case expectAny = 0
    case expectVowel
    case expectConsonant
    case expectSubset
    case expectSequence
}

class LetterArray: Equatable {
    var letters: [Letter]
    var sylState: SyllableState = .articulateStart
    var nextBias: NextLetterBias = .expectAny
    var expecting: [Letter] = []
    var exactMatches: [String] = []
    var filterStops: Bool = true
    var phonemes: PhoneticElementArray = PhoneticElementArray()
    
    init() {
        self.letters = []
    }
    
    init(initLetters: [Letter]) {
        self.letters = initLetters
    }
    
    init(initString: String) {
        letters = []
        for ch in initString {
            letters.append(Letter(rawValue: "\(ch)")!)
        }
    }
    
    func hasNoLetters() -> Bool {
        return letters.isEmpty
    }
    
    func numLetters() -> Int {
        return letters.count
    }
    
    func firstLetter() -> Letter? {
        if hasNoLetters() {
            return nil
        }
        else {
            return letters[0]
        }
    }
    
    func lastLetter() -> Letter? {
        if hasNoLetters() {
            return nil
        }
        else {
            return letters[numLetters() - 1]
        }
    }
    
    func nextToLastLetter() -> Letter? {
        if numLetters() < 2 {
            return nil
        }
        else {
            return letters[numLetters() - 2]
        }
    }
    
    func secondToLastLetter() -> Letter? {
        if numLetters() < 3 {
            return nil
        }
        else {
            return letters[numLetters() - 3]
        }
    }

    func letterAtPosition(_ index: Int) -> Letter? {
        if hasNoLetters() || index > numLetters() - 1 {
            return nil
        }
        else {
            return letters[index]
        }
    }
    
    subscript(index: Int) -> Letter {
        return letters[index]
    }
    
    func findLetter(_ key: Letter) -> Int? {
        return letters.index(of: key)
    }
    
    func findLetter(_ key: Letter, startIndex: Int) -> Int? {
        if let partialLetters = partial(startIndex) {
            return partialLetters.letters.index(of: key)
        }
        else {
            return nil
        }
    }
    
    func appendLetters(_ toAppend: [Letter]) {
        letters += toAppend
    }
    
    func combine(_ left: LetterArray, right: LetterArray) -> LetterArray {
        let newArray = LetterArray(initLetters: left.letters)
        
        newArray.appendLetters(right.letters)
        return newArray
    }
    
    func partial(_ fromIndex: Int, toIndex: Int) -> LetterArray? {
        if hasNoLetters() {
            return nil
        }
        else {
            let newLetters = LetterArray()
            
            for x in fromIndex..<toIndex {
                newLetters.letters.append(letters[x])
            }
            
            return newLetters
        }
    }
    
    func partial(_ fromIndex: Int) -> LetterArray? {
        if hasNoLetters() {
            return nil
        }
        else {
            let newLetters = LetterArray()
            
            for x in fromIndex..<letters.count {
                newLetters.letters.append(letters[x])
            }
            
            return newLetters
        }
    }
    
    func printLetters() {
        for ch in self.letters {
            print(ch.rawValue, terminator: "")
        }
    }
    
    func stringFromLetters() -> String {
        var wordString: String = ""
        
        for ch in self.letters {
            wordString += ch.rawValue
        }
        
        return wordString
    }
    
    func sortLetters() {
        letters.sort {$0.rawValue < $1.rawValue}
    }
    
    func swapLetters(_ fromIndex: Int, toIndex: Int) -> Bool {
        if fromIndex < 0 || toIndex < 0 || fromIndex >= letters.count || toIndex >= letters.count {
            return false;
        }
        
        if fromIndex != toIndex {
            let placeHolder = letters[fromIndex]
            letters[fromIndex] = letters[toIndex]
            letters[toIndex] = placeHolder
        }
        
        return true;
    }
    
    func testLetters(_ sequence: [Letter], testWord: String) -> Bool {
        var index = 0
        var strIndex = testWord.startIndex
        
        for letter in sequence {
            if letter.rawValue != "\(testWord[strIndex])" {
                return false
            }
            index += 1
            strIndex = testWord.index(testWord.startIndex, offsetBy: index)
        }
        return true
    }
    
    // Final B words: SNUB, SNOB, SLOB, BLOB, BLURB, ARAB, BARB, BOOB, BULB, GOOB, GRAB, GARB, CRIB, GLIB
    // --> LOOK AT INITIAL PHONEME!!
    
    func lettersForInitialVowelConsonantPairs(_ first: Letter, second: Letter) -> [Letter] {
        switch first {
        case .A:
            switch second {
            case .B: return [.A, .B, .D, .E, .I, .L, .N, .O, .R, .U, .Y]
            case .C: return [.A, .C, .E, .H, .I, .M, .N, .O, .R, .T, .U]
            case .D: return [.A, .B, .D, .E, .I, .J, .O, .R, .U]
            case .F: return [.A, .E, .F, .I, .L, .O, .R, .U]
            case .G: return [.A, .E, .G, .L, .I, .O, .R, .U]
            case .H: return [.A, .O]
            case .J: return [.A]
            case .K: return [.I]
            case .L: return [.A, .B, .D, .E, .G, .I, .K, .L, .M, .O, .P, .S, .T, .V, .U]
            case .M: return [.A, .B, .E, .H, .I, .M, .O, .P, .U, .Y]
            case .N: return [.A, .C, .D, .G, .E, .I, .K, .N, .O, .S, .T, .U, .Y]
            case .P: return [.A, .E, .H, .I, .L, .N, .O, .P, .R, .S, .T, .U]
            case .Q: return [.U]
            case .R: return [.A, .B, .C, .D, .E, .F, .G, .I, .K, .L, .M, .O, .P, .R, .S, .T, .U]
            case .S: return [.A, .C, .E, .G, .H, .I, .K, .L, .O, .P, .S, .T, .U, .W]
            case .T: return [.A, .E, .H, .I, .O, .R, .T, .U]
            case .V: return [.A, .E, .I, .O]
            case .W: return [.A, .E, .H, .I, .O]
            case .X: return [.E, .I, .L, .O]
            case .Y: return [.E, .O]
            default: return []
            }
        case .E:
            switch second {
            case .B: return [.A, .B, .E, .U]
            case .C: return [.A, .C, .O, .R, .S, .T, .U]
            case .D: return [.A, .D, .E, .G, .I, .O, .U]
            case .F: return [.A, .E, .F, .O, .U]
            case .G: return [.A, .G, .O]
            case .H: return []
            case .J: return [.A, .E]
            case .K: return []
            case .L: return [.A, .B, .C, .D, .E, .F, .G, .K, .L, .M, .O, .P, .S, .T, .U]
            case .M: return [.A, .B, .C, .E, .I, .M, .O, .P, .U]
            case .N: return [.A, .C, .D, .E, .I, .L, .M, .N, .O, .S, .T, .U, .V]
            case .P: return [.A, .E, .H, .I, .O]
            case .Q: return [.U]
            case .R: return [.A, .B, .C, .D, .E, .G, .H, .I, .O, .R, .S, .T]
            case .S: return [.A, .C, .E, .H, .I, .O, .P, .Q, .S, .T]
            case .T: return [.A, .C, .E, .H, .I, .O, .T]
            case .V: return [.A, .E, .I, .O]
            case .W: return [.A, .E]
            case .X: return [.A, .C, .E, .I, .O, .P, .T, .U]
            case .Y: return [.E]
            default: return []
            }
        case .I:
            switch second {
            case .B: return [.E, .I]
            case .C: return [.A, .E, .I, .O, .T, .Y]
            case .D: return [.E, .L, .O]
            case .F: return [.F, .T]
            case .G: return [.L]
            case .H: return []
            case .J: return []
            case .K: return []
            case .L: return [.I, .L]
            case .M: return [.A, .B, .E, .I, .M, .O, .P, .U]
            case .N: return [.A, .C, .D, .E, .F, .G, .I, .J, .K, .L, .N, .O, .P, .S, .T, .V]
            case .P: return []
            case .Q: return []
            case .R: return [.A, .E, .I, .K, .O, .R]
            case .S: return [.H, .L, .S, .T]
            case .T: return [.A, .C, .E, .H, .S, .T]
            case .V: return [.E, .I, .O]
            case .W: return []
            case .X: return []
            case .Y: return []
            default: return []
            }
        case .O:
            switch second {
            case .B: return [.A, .D, .E, .F, .I, .J, .O, .S, .T, .U]
            case .C: return [.A, .C, .E, .I, .O, .R, .T, .U]
            case .D: return [.A, .D, .E, .I, .O, .U]
            case .F: return [.A, .E, .F, .O, .U]
            case .G: return [.R]
            case .H: return [.M]
            case .J: return []
            case .K: return []
            case .L: return [.A, .D, .E, .I, .L]
            case .M: return [.A, .E, .I, .O, .U]
            case .N: return [.A, .E, .I, .L, .O, .U]
            case .P: return [.A, .E, .I, .O, .U]
            case .Q: return [.U]
            case .R: return [.A, .B, .C, .D, .E, .G, .I, .N, .O, .U]
            case .S: return [.A, .E, .I, .O, .S, .T, .U]
            case .T: return [.A, .E, .I, .O, .T, .U]
            case .V: return [.A, .E, .I, .O, .U]
            case .W: return [.E, .L, .N, .O]
            case .X: return [.E, .I, .Y]
            case .Y: return [.A, .E, .I, .O, .U]
            default: return []
            }
        case .U:
            switch second {
            case .B: return []
            case .C: return []
            case .D: return [.D]
            case .F: return []
            case .G: return [.L]
            case .H: return []
            case .J: return []
            case .K: return []
            case .L: return [.C, .N, .T]
            case .M: return [.B]
            case .N: return [.A, .B, .C, .D, .E, .F, .G, .H, .I, .K, .L, .M, .N, .O, .P, .R, .S, .T, .U, .V, .W, .Y, .Z]
            case .P: return [.A, .B, .C, .D, .E, .H, .I, .L, .O, .P, .R, .S, .T, .U]
            case .Q: return []
            case .R: return [.A, .E, .G, .I, .N, .O, .U]
            case .S: return [.A, .E, .H, .I, .U]
            case .T: return [.T]
            case .V: return [.U]
            case .W: return []
            case .X: return []
            case .Y: return []
            default: return []
            }
        default:
            return []
        }
    }
    
    // New, smarter implementation
    func testLexical(_ suffix: Letter, remainingLetters: Int) -> Bool {
        
        let endOfWord = (remainingLetters == 1)
        let last = lastLetter()
        let nextToLast = nextToLastLetter()
        let lexSuffix: LexicalLetter = letterDictionary[suffix]!
        var lastElement: PhoneticElement?
        
        // First letter in the word
        if hasNoLetters() {
            
            if suffix.isVowel() {
                sylState = .articulateVowel
            }
            
            // expecting = lexSuffix.initialFollowers!()
            expecting = lexSuffix.nextLetters(pea:phonemes, nRemaining: remainingLetters)
            if expecting.isEmpty {
                return false
            }
            
            nextBias = .expectSubset
            phonemes.appendElement(lexSuffix)
            return true
        }
            
        else {
            lastElement = phonemes.lastElement()
            
            // Check if there is a predefined set of words for the combined prefix
//            if numLetters() < 3 && exactMatches == [] {
//                let mKey = "\(phonemes.stringRep())\(suffix.rawValue)"
//                if let matches = wordMatchDictionary[mKey] {
//                    exactMatches = matches
//                    nextBias = .expectSequence
//                    phonemes.appendElement(lexSuffix)
//                    return true
//                }
//            }
        }
        
        // Matching exact sequence of letters
        if nextBias == .expectSequence {
            
            var x = 0
            let currentString = "\(phonemes.stringRep())\(suffix.rawValue)"
            for matchString in exactMatches {
                
                if !matchString.contains(currentString) {
                    exactMatches.remove(at: x)
                }
                else {
                    x += 1
                }
            }
            
            if exactMatches.count == 0 {
                return false
            }
                
            else {
                phonemes.appendElement(lexSuffix)
                return true
            }
        }
        
        // Expecting certain letters
        else if nextBias == .expectSubset {
            if expecting.contains(suffix) {
                expecting = []
                nextBias = .expectAny
            }
                
            // make an exception for final S plurals if allowable
            else { // } if !endOfWord || suffix != .S {
                return false
            }
        }
        
        // NEXT LETTER IS A CONSONANT
        if suffix.isConsonant() {
            
            let lexSuffix = letterDictionary[suffix] as? Consonant
            
            // CONSONANT FOLLOWED BY CONSONANT
            if last!.isConsonant() {
                var cKey: String
                var conBlend: ConsonantBlend?
                
                // If this is a final S (but not an SS blend), first make sure the last phoneme can take a final S
                // Then make sure it can end the word as it currently stands
                if endOfWord && suffix == .S && lastElement!.id != "S" {
                    
                    if phonemes.elements.count > 2 {

                        // Have to copy the current phones then remove the last one
                        let phonemesCopy = PhoneticElementArray(pea: phonemes)
                        phonemesCopy.removeLastElement()

                        if lastElement!.verifyEndOfWord!(phonemesCopy) {
                            return lastElement!.verifyPlural!(phonemes)
                        }
                        else {
                            return false
                        }
                    }
                    else {
                        return lastElement!.verifyPlural!(phonemes)
                    }
                }
                
                // Assume all final Y's are ok for now - this speeds execution but is it necessary
                // now with the Y Blends?  Only for final Y's following consonant blends
                else if endOfWord && suffix == .Y {
                    sylState = .articulateVowel
                    phonemes.appendElement(lexSuffix!)
                    return true
                }
                    
                // This is for single consonants that follow an interior Y (treat just like following a vowel)
                else if lastElement!.id == "Y" {
                    
                    if endOfWord {
                        phonemes.appendElement(lexSuffix!)
                        sylState = .articulateStop
                        return true
                    }
                    
                    expecting = lexSuffix!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                    if expecting.isEmpty {
                        return false
                    }
                    sylState = .articulateStop
                    nextBias = .expectSubset
                    phonemes.appendElement(lexSuffix!)
                    return true
                }
                
                // Consonant following vowel-diphthong pair like AH, OW, etc.
                else if lastElement is DiphthongBlend {
                    
                    if endOfWord {
                        sylState = .articulateStop
                        phonemes.appendElement(lexSuffix!)
                        return true
                    }
                    else {
                        expecting = lexSuffix!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                    }
                    
                    if expecting.isEmpty {
                        return false
                    }
                    
                    sylState = .articulateStop
                    nextBias = .expectSubset
                    phonemes.appendElement(lexSuffix!)
                    return true
                }
                
                // Try to match connected consonants to a blend element
                // With Y's, omly match the last letter, not the entire blend
                if suffix == .Y {
                    cKey = "\(last!.rawValue)Y"
                    conBlend = YBlendMap[cKey]
                }
                else {
                    cKey = "\(lastElement!.id)\(suffix.rawValue)"
                    conBlend = consonantBlendMap[cKey]
                }
                
                // All cases where consonants don't blend...hard stops, etc.
                if conBlend == nil {
                    let lexLast = consonantMap[last!]! as Consonant
                    
                    // If it's not a blend at the end of the word, should be a special case like COLUMN
                    if endOfWord {
                        phonemes.appendElement(lexSuffix!)
                        sylState = .articulateStop
                        return true
                    }
                        
                    // Letters blend phonetically but don't form a unit (ex. CST in ECSTASY)
                    else if (lastElement! is Consonant || lastElement! is ConsonantBlend) &&
                           lexLast.blendInto.contains(suffix) &&
                           (sylState != .articulateStart) {
                        phonemes.appendElement(lexSuffix!)
                        sylState = .articulateStart
                        // expecting = lexSuffix!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                        nextBias = .expectVowel
                        return true
                    }
                        
                    // Check if liquid L can follow consonant blend
                    else if suffix == .L && lexLast.liquidBlend {
                        phonemes.appendElement(lexSuffix!)
                        sylState = .articulateStart
//                        expecting = lexSuffix!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
//                        nextBias = .expectSubset
                        nextBias = .expectVowel
                        return true
                    }
                     
                    // Adding the new consonant is ok if filterStops is turned off
                    else if !filterStops {
                        phonemes.appendElement(lexSuffix!)
                        sylState = .articulateStart
                        expecting = lexSuffix!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                        nextBias = .expectSubset
                        return true
                    }
                    
                    // Unlikely that we reach here
                    else {
                        return false
                    }
                }
                
                // Validate blend at the end of the word
                if endOfWord {
                    
                    // remove the first phoneme of the blend to make the test work right
                    phonemes.removeLastElement()
                    
                    if conBlend!.verifyEndOfWord!(phonemes) {
                        phonemes.appendElement(conBlend!)
                        return true
                    }
                    else {
                        return false
                    }
                }
                    
                else {
                    
                    // Have to remove the last phoneme so that instance-level followers for consonant blends will evaluate properly
                    if suffix != .Y {
                        phonemes.removeLastElement()
                    }

                    expecting = conBlend!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                    if expecting.isEmpty {
                        return false
                    }
                    
                    nextBias = .expectSubset
                    
                    // Here the added Y is acting as a vowel
                    if suffix == .Y {
                        phonemes.appendElement(lexSuffix!)
                        sylState = .articulateVowel
                    }
                    else {
                        phonemes.appendElement(conBlend!)
                    }
                    
                    return true
                }
            }
                
            // VOWEL FOLLOWED BY CONSONANT
            else if last!.isVowel() {
                
                // Appending a consonant after an initial vowel
                if numLetters() == 1 && !suffix.isDipthong() {
                    
                    expecting = lettersForInitialVowelConsonantPairs(last!, second: suffix)
                    
                    if !expecting.isEmpty {
                        sylState = .articulateStop
                        nextBias = .expectSubset
                        phonemes.appendElement(lexSuffix!)
                        return true
                    }
                        
                    else {
                        return false
                    }
                }
                    
                // Special case for vowels followed by H, W, and Y
                else if suffix.isDipthong() && lastElement! is Vowel {
                    let dKey = "\(last!.rawValue)\(suffix.rawValue)"
                    let dipBlend = diphthongBlendMap[dKey]
                    
                    if dipBlend == nil {
                        return false
                    }                    
                    
                    if endOfWord {
                        phonemes.removeLastElement()
                        if dipBlend!.verifyEndOfWord!(phonemes) {
                            phonemes.appendElement(dipBlend!)
                            return true
                        }
                        else {
                            return false
                        }
                    }
                    
                    else {
                        expecting = dipBlend!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                    }
                    
                    if expecting.isEmpty {
                        return false
                    }
                    
                    nextBias = .expectSubset
                    phonemes.replaceLastElement(dipBlend!)
                    return true
                }
                    
                else if endOfWord {
                    return lexSuffix!.verifyEndOfWord!(phonemes)
                }
                
                expecting = lexSuffix!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                
                // Reset state values
                sylState = .articulateStop
                nextBias = .expectSubset
                
                phonemes.appendElement(lexSuffix!)
                return true
            }
                
            // Bogus case
            else {
                return false
            }
            
        }
            
        // NEXT LETTER IS A VOWEL
        else if let lexSuffix = letterDictionary[suffix] as? Vowel {
            
            // CONSONANT FOLLOWED BY VOWEL
            if last!.isConsonant() {
                
                if endOfWord {
                    let canEnd = lexSuffix.verifyEndOfWord!(phonemes)
                    
                    if canEnd {
                        phonemes.appendElement(lexSuffix)
                    }
                    
                    return canEnd
                }
                
                else {
                    
                    // Special case for QU
                    if suffix == .U && lastElement!.id.range(of: "Q") != nil {
                        let conBlend = consonantBlendMap["\(lastElement!.id)U"]
                        expecting = conBlend!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                        nextBias = .expectSubset
                        phonemes.replaceLastElement(conBlend!)
                    }
                        
                    else {
                        sylState = .articulateVowel
                        expecting = lexSuffix.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                        nextBias = .expectSubset
                        phonemes.appendElement(lexSuffix)
                    }
                    return true
                }
            }
                
            // VOWEL FOLLOWED BY VOWEL
            else if last!.isVowel() {
                var vKey: String
                var vowelBlend: VowelBlend?
                
                // Filter out vowels following QU
                // --> This code really shouldn't be necessary
                if lastElement!.id == "QU" || lastElement!.id == "SQU" {
                    if suffix == .U {
                        return false
                    }
                    else {
                        nextBias = .expectAny
                        phonemes.appendElement(lexSuffix)
                        return true
                    }
                }
                
                // The last condition is added to correctly handle vowel blends following SQU
                if nextToLast == nil || nextToLast!.isConsonant() || lastElement! is Vowel {
                    vKey = "\(last!.rawValue)\(suffix.rawValue)"
                }
                else {
                    vKey = "\(nextToLast!.rawValue)\(last!.rawValue)\(suffix.rawValue)"
                }
                
                vowelBlend = vowelBlendMap[vKey]
                
                // Didn't find a vowel blend so throw this one out
                if vowelBlend == nil {
                    
                    // Allow words like WOOING or FREEING
                    if !endOfWord && suffix == .I && (lastElement!.id == "EE" || lastElement!.id == "OO") {
                        phonemes.appendElement(lexSuffix)
                        nextBias = .expectSubset
                        expecting = [.N]
                        return true
                    }
                        
                    else {
                        return false
                    }
                }
                
                // Remove the first part of the blend to test correctly
                phonemes.removeLastElement()
                
                if endOfWord {
                    if vowelBlend!.verifyEndOfWord!(phonemes) {
                        phonemes.appendElement(vowelBlend!)
                        return true
                    }
                    else {
                        return false
                    }
                }
                
                else {
                    expecting = vowelBlend!.nextLetters(pea: phonemes, nRemaining: remainingLetters)
                }
                
                if expecting.isEmpty {
                    return false
                }
                
                nextBias = .expectSubset
                phonemes.appendElement(vowelBlend!)
                return true
            }
                
            // Bogus case
            else {
                return false
            }
            
        }
            
        // Don't know how this would ever happen
        else {
            return false
        }
    }
}

func == (rhs: LetterArray, lhs: LetterArray) -> Bool {
    if rhs.letters.count != lhs.letters.count {
        return false
    }
    for l in 0...rhs.letters.count - 1 {
        if rhs.letters[l] != lhs.letters[l] {
            return false
        }
    }
    return true
}
