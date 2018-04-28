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
    
    // New, smarter implementation
    func testLexical(_ suffix: Letter, remainingLetters: Int) -> Bool {
        let nLetters = numLetters()
        let endOfWord = (remainingLetters == 1)
        let last = lastLetter()
        let nextToLast = nextToLastLetter()
        let lexSuffix: LexicalLetter = letterDictionary[suffix]!
        let suffixProtocol = lexSuffix as! PhoneticFollowers
        var lastElement: PhoneticElement?
        
        // First letter in the word
        if hasNoLetters() {

            if suffix.isVowel() {
                sylState = .articulateVowel
            }
            else {
                sylState = .articulateStart
            }
            
            expecting = suffixProtocol.initialFollowers(nRemain: remainingLetters)
            
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
                let lexLast = consonantMap[last!]! as Consonant
                var reBlend: PhoneticElement? = nil
                
                // If this is a final S (but not an SS blend), first make sure the last phoneme can take a final S
                // Then make sure it can end the word as it currently stands
                if endOfWord && suffix == .S && lastElement!.id != "S" {
                    return true
//                    if phonemes.elements.count > 2 {
//
//                        // Have to copy the current phones then remove the last one
//                        let phonemesCopy = PhoneticElementArray(pea: phonemes)
//                        phonemesCopy.removeLastElement()
//
//                        if lastElement!.verifyEndOfWord!(phonemesCopy) {
//                            return lastElement!.verifyPlural!(phonemes)
//                        }
//                        else {
//                            return false
//                        }
//                    }
//                    else {
//                        return lastElement!.verifyPlural!(phonemes)
//                    }
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
                    
                    if remainingLetters == 2 {
                        expecting = suffixProtocol.lastFollowers(pea: phonemes)
                    }
                    else {
                        expecting = suffixProtocol.midFollowers(pea: phonemes, nRemain: remainingLetters)
                    }
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
                    
                    // If following a W-diphthong blend with an R or H, then resplit so that vowel becomes single element
                    if last! == .W && (suffix == .R || suffix == .H) {
                        reBlend = vowelMap[nextToLast!]
                        lastElement = consonantMap[last!]
                    }
                        
                    // Otherwise just add on the new letter separately
                    else {
                        
                        if remainingLetters == 2 {
                            expecting = suffixProtocol.lastFollowers(pea: phonemes)
                        }
                        else {
                            expecting = suffixProtocol.midFollowers(pea: phonemes, nRemain: remainingLetters)
                        }
                        if expecting.isEmpty {
                            return false
                        }
                        
                        sylState = .articulateStop
                        nextBias = .expectSubset
                        phonemes.appendElement(lexSuffix!)
                        return true
                    }
                }
                
                // Treat interior Y's the same way as vowels
                if suffix == .Y {
                    
                    // First Y after initial consonant or consonant blend
                    if phonemes.numElements() == 1 {
                        expecting = suffixProtocol.secondFollowers(pea: phonemes, nRemain: remainingLetters)
                    }
                    
                    // Just before the last letter
                    else if remainingLetters == 2 {
                        expecting = suffixProtocol.lastFollowers(pea: phonemes)
                    }
                        
                    // Somewhere in the middle of the word
                    else {
                        expecting = suffixProtocol.midFollowers(pea: phonemes, nRemain: remainingLetters)
                    }
                    
                    if expecting == [] {
                        return false
                    }
                    sylState = .articulateVowel
                    nextBias = .expectSubset
                    phonemes.appendElement(lexSuffix!)
                    return true
                }
                    
                // Try to match consecutive consonants to a blend element
                else {
                    cKey = "\(lastElement!.id)\(suffix.rawValue)"
                    conBlend = consonantBlendMap[cKey]
                    
                    // failed to find a triple blend, now try just the last two letters
                    if conBlend == nil && lastElement! is ConsonantBlend {
                        let lexBlend = lastElement! as! ConsonantBlend
                        
                        if lexBlend.third == nil {
                            cKey = "\(lexBlend.second!.rawValue)\(suffix.rawValue)"
                            reBlend = consonantMap[nextToLast!]
                        }
                        else {
                            cKey = "\(lexBlend.third!.rawValue)\(suffix.rawValue)"
                            reBlend = consonantBlendMap["\(lexBlend.first)\(lexBlend.second!)"]
                        }
                        conBlend = consonantBlendMap[cKey]
                    }
                }
                
                // All cases where consonants don't blend...hard stops, etc.
                if conBlend == nil {
                    
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
                        
                        // If the next letter is the last one, only approve E and Y to follow liquid blend
                        if remainingLetters == 2 {
                            expecting = [.E, .Y]
                            nextBias = .expectSubset
                        }
                        else {
                            nextBias = .expectVowel
                        }
                        return true
                    }
                     
                    // Adding the new consonant is ok if filterStops is turned off
                    else if !filterStops {
                        phonemes.appendElement(lexSuffix!)
                        sylState = .articulateStart
                        if remainingLetters == 2 {
                            expecting = suffixProtocol.lastFollowers(pea: phonemes)
                        }
                        else {
                            expecting = suffixProtocol.midFollowers(pea: phonemes, nRemain: remainingLetters)
                        }
                        nextBias = .expectSubset
                        return true
                    }
                    
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
                    
                    // Have to remove the last phoneme so that followers for consonant blends will properly generate
                    phonemes.removeLastElement()
                        
                    // If a triple blend has been broken up, then the first part
                    if reBlend != nil {
                        phonemes.appendElement(reBlend!)
                    }
                    
                    // Blend occurs at the start of the word
                    if nLetters == 1 {
                        expecting = conBlend!.initialFollowers(nRemain: remainingLetters)
                    }

                    // Adding the blend after an initial vowel (make sure to ignore Y blends)
                    else if phonemes.numElements() == 1 {
                        expecting = conBlend!.secondFollowers(pea: phonemes, nRemain: remainingLetters)
                    }
                        
                    // Blend immediately precedes the last letter
                    else if remainingLetters == 2 {
                        expecting = conBlend!.lastFollowers(pea: phonemes)
                    }
                        
                    // Somewhere in the middle
                    else {
                        expecting = conBlend!.midFollowers(pea: phonemes, nRemain: remainingLetters)
                    }
                    
                    if expecting.isEmpty {
                        return false
                    }
                    
                    nextBias = .expectSubset
                    phonemes.appendElement(conBlend!)
                    return true
                }
            }
                
            // VOWEL FOLLOWED BY CONSONANT
            else if last!.isVowel() {
                
                // Appending a consonant after an initial vowel
                if nLetters == 1 && !suffix.isDipthong() {
                    
                    expecting = suffixProtocol.secondFollowers(pea: phonemes, nRemain: remainingLetters)
                    
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
                    
                    // Blend occurs at the start of the word
                    if nLetters == 1 {
                        expecting = dipBlend!.initialFollowers(nRemain: remainingLetters)
                    }
                        
                    // Blend immediately precedes the last letter
                    else if remainingLetters == 2 {
                        expecting = dipBlend!.lastFollowers(pea: phonemes)
                    }
                        
                    // Somewhere in the middle
                    else {
                        expecting = dipBlend!.midFollowers(pea: phonemes, nRemain: remainingLetters)
                    }

                    if expecting.isEmpty {
                        return false
                    }
                    
                    // No change in sylState here since the vowel sound is still active with the diphthong
                    nextBias = .expectSubset
                    phonemes.replaceLastElement(dipBlend!)
                    return true
                }
                    
                else if endOfWord {
                    return lexSuffix!.verifyEndOfWord!(phonemes)
                }
                
                if phonemes.numElements() == 1 {
                    expecting = suffixProtocol.secondFollowers(pea: phonemes, nRemain: remainingLetters)
                }
                else if remainingLetters == 2 {
                    expecting = suffixProtocol.lastFollowers(pea: phonemes)
                }
                else {
                    expecting = suffixProtocol.midFollowers(pea: phonemes, nRemain: remainingLetters)
                }
                
                if expecting == [] {
                    return false
                }
                
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

                        if (nLetters == 1 && lastElement is Consonant) ||           // QU
                            (nLetters == 2 && lastElement is ConsonantBlend) {      // SQU
                            expecting = conBlend!.initialFollowers(nRemain: remainingLetters)
                        }
                        else if remainingLetters == 2 {
                            expecting = conBlend!.lastFollowers(pea: phonemes)
                        }
                        else {
                            expecting = conBlend!.midFollowers(pea: phonemes, nRemain: remainingLetters)
                        }
                        if expecting == [] {
                            return false
                        }
                        nextBias = .expectSubset
                        phonemes.replaceLastElement(conBlend!)
                    }
                     
                    // All other cases
                    else {
                        
                        // First vowel added after initial consonant/consonant blend
                        if phonemes.numElements() == 1 {
                            expecting = suffixProtocol.secondFollowers(pea: phonemes, nRemain: remainingLetters)
                            if expecting != [] {
                                sylState = .articulateVowel
                                nextBias = .expectSubset
                                phonemes.appendElement(lexSuffix)
                                return true
                            }
                        }
                            
                        // Just before the last letter
                        if remainingLetters == 2 {
                            expecting = suffixProtocol.lastFollowers(pea: phonemes)
                        }
                        
                        // Somewhere in the middle of the word
                        else {
                            expecting = suffixProtocol.midFollowers(pea: phonemes, nRemain: remainingLetters)
                        }
                        
                        if expecting == [] {
                            return false
                        }
                        sylState = .articulateVowel
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
                
                // Didn't find a blend with this combination of vowels, should only fail for most triple blends
                if vowelBlend == nil {
                    
                    // Certain vowel blends are marked to blend into others, especially for double vowels
                    // which can produce gerunds like SEEING, WOOING, etc. also LUAU
                    if !endOfWord && lastElement! is VowelBlend {
                        let lexLast = lastElement! as! VowelBlend
                        
                        if lexLast.blendInto.contains(suffix) {
                            phonemes.appendElement(lexSuffix)
                            
                            if remainingLetters == 2 {
                                expecting = suffixProtocol.lastFollowers(pea: phonemes)
                            }
                            else {
                                expecting = suffixProtocol.midFollowers(pea: phonemes, nRemain: remainingLetters)
                            }
                            if expecting == [] {
                                return false
                            }
                            nextBias = .expectSubset
                            sylState = .articulateStart
                            return true
                        }
                        else {
                            return false
                        }
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
                
                // Blend occurs at the start of the word
                if nLetters == 1 {
                    expecting = vowelBlend!.initialFollowers(nRemain: remainingLetters)
                }
                                        
                // Adding the blend after an initial cononsant
                else if phonemes.numElements() == 1 {
                    expecting = vowelBlend!.secondFollowers(pea: phonemes, nRemain: remainingLetters)
                }
                    
                // Blend immediately precedes the last letter
                else if remainingLetters == 2 {
                    expecting = vowelBlend!.lastFollowers(pea: phonemes)
                }
                    
                // Somewhere in the middle
                else {
                    expecting = vowelBlend!.midFollowers(pea: phonemes, nRemain: remainingLetters)
                }
                
                if expecting.isEmpty {
                    return false
                }
                
                // Start a new syllable if a glottal stop occurs in the blend
                if vowelBlend!.glottalStop {
                    sylState = .articulateStart
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
