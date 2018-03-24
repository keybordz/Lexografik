//
//  LetterArray.swift
//  Lexografik
//
//  Created by Jay Wright on 9/17/15.
//  Copyright (c) 2015 Keybordz. All rights reserved.
//

import Foundation

enum SyllableState: Int {
    case ArticulateStart = 0
    case ArticulateVowel
    case ArticulateStop
}

enum VowelState: Int {
    case NoVowel = 0
    case SingleVowel
    case RepeatedVowel
    case DoubleVowelBlend
    case TripleVowelBlend
}

enum ConsonantState: Int {
    case NoConsonant = 0
    case SingleConsonant
    case Dipthong
    case RepeatedConsonant
    case DoubleConsonantBlend
    case TripleConsonantBlend
}

enum NextLetterBias: Int {
    case ExpectAny = 0
    case ExpectVowel
    case ExpectConsonant
    case ExpectSubset
    case ExpectSequence
}

class LetterArray: Equatable {
    var letters: [Letter]
    var syllableCount = 0
    var sylState: SyllableState = .ArticulateStart
    var conState: ConsonantState = .NoConsonant
    var vowState: VowelState = .NoVowel
    var nextBias: NextLetterBias = .ExpectAny
    var expecting: [Letter] = []
    var filterStops: Bool = true
    
    init() {
        self.letters = []
    }
    
    init(initLetters: [Letter]) {
        self.letters = initLetters
    }
    
    init(initString: String) {
        letters = []
        for ch in initString.characters {
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

    func letterAtPosition(index: Int) -> Letter? {
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
    
    func findLetter(key: Letter) -> Int? {
        return letters.indexOf(key)
    }
    
    func findLetter(key: Letter, startIndex: Int) -> Int? {
        if let partialLetters = partial(startIndex) {
            return partialLetters.letters.indexOf(key)
        }
        else {
            return nil
        }
    }
    
    func appendLetters(toAppend: [Letter]) {
        letters += toAppend
    }
    
    func combine(left: LetterArray, right: LetterArray) -> LetterArray {
        let newArray = LetterArray(initLetters: left.letters)
        
        newArray.appendLetters(right.letters)
        return newArray
    }
    
    func partial(fromIndex: Int, toIndex: Int) -> LetterArray? {
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
    
    func partial(fromIndex: Int) -> LetterArray? {
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
        letters.sortInPlace {$0.rawValue < $1.rawValue}
    }
    
    func swapLetters(fromIndex: Int, toIndex: Int) -> Bool {
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
    
    func consonantsForVowelBlend(first: Letter, second: Letter, pred: Letter?) -> [Letter] {
        switch first {
        case .A:
            switch second {
            case .A:
                if pred == nil {
                    return [.R]
                }
                else {
                    return []
                }
            case .E:
                if pred == nil {
                    return [.R]
                }
                else {
                    return []
                }
            case .I:
                if pred == nil {
                    return [.D, .L, .M, .R]
                }
                else {
                    return [.D, .F, .L, .M, .N, .R, .S, .T, .V, .Z]
                }
            case .O:
                if pred == nil {
                    return [.R]
                }
                else if pred == .G {
                    return [.L]
                }
                else {
                    return []
                }
            case .U: return [.B, .C, .D, .G, .L, .N, .R, .S, .T, .V, .X]
            default: return []
            }
            
        case .E:
            switch second {
            case .A:
                if pred == nil {
                    return [.C, .R, .S, .T, .V]
                }
                else {
                    return [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .U, .V]
                }
            case .E:
                if pred == nil {
                    return [.R]
                }
                else {
                    return [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z]
                }
            case .I:
                if pred == nil {
                    return [.G, .T]
                }
                else {
                    return [.G, .L, .N, .R, .S, .T, .V]
                }
            case .O: return [.M, .N]
            case .U: return [.C, .R, .T]
            default: return []
            }
            
        case .I:
            switch second {
            case .A:
                if pred == nil {
                    return []
                }
                else {
                    return [.C, .D, .L, .M, .N, .R, .S, .T]
                }
            case .E: return [.C, .D, .L, .M, .N, .R, .S, .T, .V, .W, .Z]
            case .O:
                if pred == nil {
                    return [.N, .T]
                }
                else {
                    return [.M, .N, .R, .S, .T]
                }
            case .U: return [.M, .S]
            default: return []
            }
            
        case .O:
            switch second {
            case .A:
                if pred == nil {
                    return [.F, .K, .R, .S, .T]
                }
                else {
                    return [.C, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T, .V]
                }
            case .E:
                if pred == nil {
                    return []
                }
                else {
                    return [.D, .M, .R, .S, .T]
                }
            case .I:
                if pred == nil {
                    return [.L]
                }
                else {
                    return [.C, .D, .F, .L, .N, .R, .S, .T, .V]
                }
            case .O:
                if pred == nil {
                    return [.Z]
                }
                else {
                    return [.B, .D, .F, .G, .H, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z]
                }
            case .U:
                if pred == nil {
                    return [.N, .R, .S, .T]
                }
                else {
                    return [.B, .C, .D, .F, .G, .L, .N, .P, .Q, .R, .S, .T, .V, .Z]
                }
            default: return []
            }
            
        case .U:
            switch second {
            case .A: return [.B, .C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .V, .Z]
            case .E: return [.D, .L, .N, .R, .S, .T]
            case .I:
                if pred == nil {
                    return []
                }
                else if pred == .Q {
                    return [.B, .C, .D, .F, .G, .L, .N, .P, .R, .S, .T, .X, .Z]
                }
                else {
                    return [.C, .D, .L, .N, .R, .S]
                }
            case .O: return [.R, .S]
            case .U:
                if pred == .C {
                    return [.M]
                }
                else {
                    return []
                }
            default: return []
            }
            
        default: return []
        }
    }
    
    func threeLetterConsonantBlends(first: Letter, second: Letter) -> [Letter] {
        var restrictVowels: Bool = false
        var subset: [Letter] = []
        
        switch first {
        case .B:
            switch second {
            case .Y:
                subset = [.E, .P, .S, .T]
                restrictVowels = true
            default: return []
            }
        case .C:
            switch second {
            case .H: subset = [.R]
            case .S: subset = [.T]
            case .T: subset = []
            case .Y:
                subset = [.A, .P, .S]
                restrictVowels = true
            default: return []
            }
        case .D:
            switch second {
            case .Y:
                subset = [.E, .I, .N, .S]
                restrictVowels = true
            default: return []
            }
        case .G:
            switch second {
            case .H:
                subset = [.T]
                restrictVowels = true
            case .N:
                subset = [.A, .O, .U]
                restrictVowels = true
            case .Y:
                subset = [.N, .R]
                restrictVowels = true
            default: return []
            }
        case .L:
            switch second {
            case .Y:
                subset = [.E, .I]
                restrictVowels = true
            default: return []
            }
        case .M:
            switch second {
            case .Y:
                subset = [.R, .S]
                restrictVowels = true
            default: return[]
            }
        case .N:
            switch second {
            case .C: subset = [.H]
            case .T: subset = [.H]
            default: return []
            }
        case .P:
            switch second {
            case .H: subset = [.R, .A, .E, .I, .O, .U, .Y]
            case .S: subset = [.Y]
            case .Y: subset = [.R, .T]
            default: return []
            }
        case .R:
            switch second {
            case .S: subset = [.T]
            default: return []
            }
        case .S:
            switch second {
            case .C: subset = [.H, .R]
            case .H: subset = [.R]
            case .P: subset = [.L, .R]
            case .Q:
                subset = [.U]
                restrictVowels = true
            case .T: subset = [.R]
            case .Y:
                subset = [.C, .N, .S]
                restrictVowels = true
            default: return []
            }
        case .T:
            switch second {
            case .C: subset = [.H]
            case .H: subset = [.R]
            case .Y:
                subset = [.P]
                restrictVowels = true
            default: return []
            }
        case .V:
            switch second {
            case .Y:
                subset = [.I]
                restrictVowels = true
            default: return []
            }
        default: return []
        }
        
        if !restrictVowels {
            subset.appendContentsOf( [.A, .E, .I, .O, .U, .Y] )
        }
        return subset
    }
    

    func testLetters(sequence: [Letter], testWord: String) -> Bool {
        var index = 0
        var strIndex = testWord.startIndex
        
        for letter in sequence {
            if letter.rawValue != "\(testWord[strIndex])" {
                return false
            }
            index++
            strIndex = testWord.startIndex.advancedBy(index)
        }
        return true
    }
    
    // Final B words: SNUB, SNOB, SLOB, BLOB, BLURB, ARAB, BARB, BOOB, BULB, GOOB, GRAB, GARB, CRIB, GLIB
    // --> LOOK AT INITIAL PHONEME!!
    
    func testEndingVowelExceptions(sequence: [Letter], final: Letter) -> Bool {
        
        let vowelEndingWords = ["LOCI", "FOCI", "YOGI", "DELI", "ANTI", "GNOCCHI", "CORGI", "TOFU", "LIEU", "SUSHI", "SNAFU"]
        var fullSequence = sequence
            
        if sequence.count > 4 {
            return false
        }
        else if final.isConsonant() {
            return false
        }
        
        fullSequence.append(final)
        for word in vowelEndingWords {
            if fullSequence.count == word.characters.count && testLetters(fullSequence, testWord: word) {
                return true
            }
        }
        
        return false
    }
    
    func lettersForInitialVowelConsonantPairs(first: Letter, second: Letter) -> [Letter] {
        switch first {
        case .A:
            switch second {
            case .B: return [.A, .B, .D, .E, .I, .L, .N, .O, .R, .U, .Y]
            case .C: return [.A, .C, .E, .H, .I, .O, .R, .T, .U]
            case .D: return [.A, .B, .D, .E, .I, .J, .O, .R, .U]
            case .F: return [.A, .E, .F, .I, .L, .O, .R, .U]
            case .G: return [.A, .E, .G, .L, .I, .O, .R, .U]
            case .H: return [.A, .O]
            case .J: return []
            case .K: return []
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
            case .D: return [.A, .D, .E, .I, .O, .U]
            case .F: return [.A, .E, .F, .O, .U]
            case .G: return [.A, .G, .O]
            case .H: return []
            case .J: return [.A, .E]
            case .K: return []
            case .L: return [.A, .B, .C, .D, .E, .F, .G, .K, .L, .M, .O, .P, .T, .U]
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
            case .B: return [.A, .E, .I]
            case .C: return [.A, .E, .I, .O, .T, .Y]
            case .D: return [.A, .E, .L, .O]
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
            case .R: return [.A, .E, .I, .O, .R]
            case .S: return [.H, .L, .T]
            case .T: return [.A, .C, .E, .H, .I, .T]
            case .V: return [.E, .I, .O]
            case .W: return []
            case .X: return []
            case .Y: return []
            default: return []
            }
        case .O:
            switch second {
            case .B: return [.A, .D, .E, .F, .I, .J, .O, .R, .S, .T, .U]
            case .C: return [.A, .C, .E, .I, .O, .R, .T, .U]
            case .D: return [.A, .D, .E, .I, .O, .U]
            case .F: return [.A, .E, .F, .O, .U]
            case .G: return []
            case .H: return [.M]
            case .J: return []
            case .K: return []
            case .L: return [.A, .D, .E, .L]
            case .M: return [.A, .E, .I, .O, .U]
            case .N: return [.A, .E, .I, .O, .U]
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
            case .G: return []
            case .H: return []
            case .J: return []
            case .K: return []
            case .L: return [.C, .T]
            case .M: return []
            case .N: return [.A, .B, .C, .D, .E, .F, .G, .H, .I, .K, .L, .M, .N, .O, .P, .R, .S, .T, .U, .V, .W, .Y, .Z]
            case .P: return [.A, .B, .C, .D, .E, .H, .I, .L, .O, .P, .R, .S, .T, .U]
            case .Q: return []
            case .R: return [.A, .E, .G, .I, .N, .O, .U]
            case .S: return [.A, .E, .H, .I, .O, .U]
            case .T: return [.A, .E, .I, .O, .T, .U]
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
    func testLexical(suffix: Letter, endOfWord: Bool) -> Bool {
        
        let filterUncommon: Bool = true
        let last = lastLetter()
        let nextToLast = nextToLastLetter()
        var suffix_approved: Bool = false
        
        // Expecting certain letters
        if nextBias == .ExpectSubset {
            if expecting.contains(suffix) {
                expecting = []
                nextBias = .ExpectAny
                suffix_approved = true
                
                // This shoud be true if it's the third letter of a valid triple consonant blend
                if suffix.isConsonant() && suffix != .Y && conState == .DoubleConsonantBlend {
                    conState = .TripleConsonantBlend
                    return true
                }
                
                // QU resets the vowel state
                else if suffix == .U && last == .Q {
                    if endOfWord {
                        return false
                    }
                    vowState = .NoVowel
                    nextBias = .ExpectVowel
                    return true
                }
            }
                
            // make an exception for final S plurals if allowable
            else if !endOfWord || suffix != .S {
                return false
            }
        }
        
        // NEXT LETTER IS A CONSONANT
        if let lexSuffix = letterDictionary[suffix] as? Consonant {
            
            // First letter of the word
            if hasNoLetters() {
                
                // Eliminate words that start with X
                if suffix == .X {
                    return false
                }
                    
                // Make sure U follows Q
                if suffix == .Q {
                    expecting = [.U]
                    nextBias = .ExpectSubset
                }
                
                conState = .SingleConsonant
                return true
            }
            
            // CONSONANT FOLLOWED BY CONSONANT
            if let lexLast = letterDictionary[last!] as? Consonant {
                
                // All end of word cases here!
                if endOfWord {
                    
                    var pluralOK: Bool = lexLast!.canPluralize
                    
                    
                    if sylState == .ArticulateVowel {
                        
                        // Assume all plurals are ok
                        if suffix == .S {
                            sylState = .ArticulateStop
                            return true
                        }
                        
                        // Can the dipthong blend with the next letter? (mainly W's)
                        if lexLast.blendInto.indexOf(suffix) != nil {
                            sylState = .ArticulateStop
                            return true
                        }
                        else {
                            return false
                        }
                    }
                        
                    // All consecutive consonants at the end of a word
                    else {
                        
                        // Acknowledge an ending Y as a vowel
                        if suffix == .Y {
                            syllableCount++
                            sylState = .ArticulateVowel
                            return true
                        }
                            
                        // Word is all consonants, forget it
                        else if syllableCount == 0 {
                            return false
                        }
                            
                        // Too many consecutive consonants without a vowel
                        else if sylState == .ArticulateStart {
                            return false
                        }
                            
                        // S plurals ok with most consonants
                        // IMPORTANT TO DO THIS BEFORE THE VOWEL BIAS CHECK
                        else if suffix == .S && lexLast.canPlural {
                            
                            // Only certain H blends can plural
                            if last == .H && nextToLast == .S {
                                return false
                            }
                                
                            // No final liquid blends can plural (i.e. T-L-S)
                            else if last == .L && nextToLast!.isConsonant() {
                                return false
                            }
                                
                            else {
                                return true
                            }
                        }
                            
                        // Really expecting a vowel
                        else if nextBias == .ExpectVowel {
                            return false
                        }
                            
                        // Only certain consonant blends can make it
                        else if lexLast.blendFinal.indexOf(suffix) == nil {
                            return false
                        }

                        // This is a valid end-of-word consonant blend
                        else {
                            
                            // **special case** SC suffix only allowed for 4-letter words (DISC)
                            if suffix == .C && last == .S {                                
                                if nextToLast == .I && numLetters() == 3 {
                                    return true
                                }
                                else {
                                    return false
                                }
                            }
                            
                            //** special case for SM **
                            if last == .S && suffix == .M {
                                if (nextToLast == .I || nextToLast == .A) && vowState == .SingleVowel {
                                    return true
                                }
                                else {
                                    return false
                                }
                            }
                            
                            //** special case for GN, only after I or EI
                            if last == .G && suffix == .N {
                                if nextToLast == .I {
                                    let secondToLast = secondToLastLetter()
                                    if vowState == .SingleVowel ||
                                        (vowState == .DoubleVowelBlend && secondToLast == .E) {
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
                            
                            // *special case for LB, only after U
                            if last == .L && suffix == .B {
                                if nextToLast == .U && vowState == .SingleVowel {
                                    return true
                                }
                                else {
                                    return false
                                }
                            }
                            return true
                        }
                    }
                }   // endOfWord section
                
                // Starting a new syllable
                if sylState == .ArticulateStart {
                    
                    // Expected a vowel
                    if nextBias == .ExpectVowel {
                        return false
                    }
                    
                    // If the new consonant blends with the last one, OK
                    if lexLast.blendStart.indexOf(suffix) != nil {
                        
                        expecting = threeLetterConsonantBlends(last!, second: suffix)
                        if expecting.isEmpty {
                            nextBias = .ExpectVowel
                        }
                        else {
                            nextBias = .ExpectSubset
                        }
                        
                        if suffix == .Y {
                            syllableCount++
                            sylState = .ArticulateVowel
                            vowState = .SingleVowel
                        }
                            
                        else {
                            conState = .DoubleConsonantBlend
                        }
                        
                        return true
                    }
                        
                    else {
                        return false
                    }
                }
                    
                // Consonant blends at the end of an INTERIOR syllable
                else if sylState == .ArticulateStop {

                    // Special case for Y
                    if suffix == .Y {
                        syllableCount++
                        sylState = .ArticulateVowel
                        vowState = .SingleVowel
                        return true
                    }
                    
                    // Expected a vowel
                    if nextBias == .ExpectVowel {
                        return false
                    }
                    
                    // Can we blend into the next consonant without creating a stop?
                    if lexLast.blendInto.indexOf(suffix) != nil {
                        expecting = threeLetterConsonantBlends(last!, second: suffix)
                        
                        // Force the next letter to be a vowel, except for potential plurals or L blends
                        if expecting.isEmpty {
                            if !lexSuffix.canPlural && !lexSuffix.liquidBlend {
                                nextBias = .ExpectVowel
                            }
                            else {
                                nextBias = .ExpectAny
                            }
                        }
                        
                        else {
                            nextBias = .ExpectSubset
                        }

                        if suffix == last {
                            conState = .RepeatedConsonant
                        }
                        else {
                            conState = .DoubleConsonantBlend
                        }
                        return true
                    }
                        
                    // Special case for liquid blends
                    else if suffix == .L {
                        
                        // Need to check for OU blend as in COULD, WOULD, etc.
                        if lexLast.liquidBlend && vowState == .SingleVowel {
                            nextBias = .ExpectVowel
                            conState = .DoubleConsonantBlend
                            return true
                        }
                            
                        // special case: nasal stop before liquid, ex. UNLIT
                        else if last == .N && suffix_approved {
                            nextBias = .ExpectVowel
                            conState = .SingleConsonant
                            sylState = .ArticulateStart
                        }
                            
                        else {
                            return false
                        }
                    }
                        
                    // The two consonants don't blend (i.e. the prior one is a stop)
                    else {
                        
                        // check option to filter these
                        if filterStops && !suffix_approved {
                            return false
                        }
                        sylState = .ArticulateStart
                        conState = .SingleConsonant
                        nextBias = .ExpectAny
                        return true
                    }
                }
                    
                // Adding a consonant after a dipthong
                else if sylState == .ArticulateVowel {
                    
                    // Expected a vowel
                    if nextBias == .ExpectVowel {
                        return false
                    }
                    
                    // Letters added after a single interior Y acting as vowel are ok
                    if vowState == .SingleVowel && conState != .Dipthong {
                        sylState = .ArticulateStop
                        conState = .SingleConsonant
                        nextBias = .ExpectAny
                        return true
                    }
                    
                    // No consecutive dipthongs
                    if lexSuffix.dipthong {
                        return false
                    }
                        
                    else if lexLast.blendInto.indexOf(suffix) != nil {
                        sylState = .ArticulateStop
                        nextBias = .ExpectVowel
                        conState = .DoubleConsonantBlend
                        return true
                    }
                        
                    else {
                        return false
                    }
                }
            }
                
            // VOWEL FOLLOWED BY CONSONANT
            else if let lexLast = letterDictionary[last!] as? Vowel {
                
                // Expected a vowel
                if nextBias == .ExpectVowel {
                    return false
                }
                
                // Appending a consonant after an initial vowel
                if numLetters() == 1 {
                    
                    expecting = lettersForInitialVowelConsonantPairs(last!, second: suffix)
                    
                    if !expecting.isEmpty {
                        if suffix.isDipthong() {
                            conState = .Dipthong
                        }
                        else {
                            conState = .SingleConsonant
                            sylState = .ArticulateStop
                        }
                        nextBias = .ExpectSubset
                        return true
                    }
                        
                    else {
                        return false
                    }
                }
                
                // Handle interior dipthongs after vowels -- H, W, and Y
                if lexSuffix.dipthong {
                    
                    // Vowel-H endings are uncommon
                    if endOfWord && suffix == .H && filterUncommon {
                        return false
                    }
                    
                    // Right now insist on next letter being a consonant, but is that right?
                    // NO -->  example ROYAL
                    
                    else if lexLast.makesDipthongs {
                        
                        // For right now, filter out E-H pairings (but what about BEHEST?)
                        if suffix == .H && last == .E {
                            return false
                        }
//                      nextBias = .ExpectVowel
                        conState = .Dipthong
                        return true
                    }
                        
                    else {
                        return false
                    }
                }
                
                sylState = .ArticulateStop
                
                if endOfWord {
                    
                    // REALLY NEED A BIG ROUTINE TO HANDLE DIFFERENT CASES
                    
                    // filter out uncommon letters at the end of the word
                    if lexSuffix.endBias < 2 {
                        
                        if suffix == .C && last == .I {
                            return true
                        }
                        else {
                            return false
                        }
                    }
                    
                    // No single vowel - K endings unless preceded by liquid
                    if suffix == .K && last!.isVowel() && nextToLast!.isConsonant() && !nextToLast!.isLiquid() {
                        return false
                    }
                    
                    // OS endings - not many of these in larger words
                    // Counterexample --> CASINOS
//                    if numLetters() > 4 && suffix == .S && last == .O && nextToLast != .I {
//                        return false
//                    }
                }
                
                // SPECIAL CASE: Liquid (L) following vowel blend
                if suffix == .L && vowState != .SingleVowel {
                    if nextToLast == .O && last == .U {
                        expecting = [.D, .S, .Y]
                    }
                    else {
                        expecting = [.S, .Y]
                    }
                    nextBias = .ExpectSubset
                }
                
                // Make sure U follows Q
                else if suffix == .Q {
                    expecting = [.U]
                    nextBias = .ExpectSubset
                }
                
                return true
            }
                
            // Bogus case
            else {
                return false
            }
            
        }
            
        // NEXT LETTER IS A VOWEL
        else if let lexSuffix = letterDictionary[suffix] as? Vowel {
            
            if hasNoLetters() {
                sylState = .ArticulateVowel
                vowState = .SingleVowel
                syllableCount++
                return true
            }
            
            // CONSONANT FOLLOWED BY VOWEL
            if let lexLast = letterDictionary[last!] as? Consonant {
                
                vowState = .NoVowel
                
                // Always OK at the start of a word
                if sylState == .ArticulateStart {
                    
                    sylState = .ArticulateVowel
                    syllableCount++
                    
                    
                    // May not want words ending in strange vowels
                    if endOfWord {
                        
                        if lexSuffix.endBias == 0 {
                            return false
                        }
                        
                        // ex. CHRO
                        else if conState == .TripleConsonantBlend {
                            return false
                        }
                        
                        else {
                            return true
                        }
                    }
                        
                    
                    else {
                        
                        // must have another vowel after QU
                        if suffix == .U && last == .Q {
                            nextBias = .ExpectVowel
                        }
                            
                        else {
                            nextBias = .ExpectAny
                        }
                        
                        vowState = .SingleVowel
                        return true
                    }
                }
                    
                // A bit more complicated in the middle or at the end
                else if sylState == .ArticulateStop {
                    
                    // Vowels added at the end of a word
                    if endOfWord {
                        
                        // E's are always OK and maintain the current syllable count
                        if suffix == .E {
                            return true
                        }
                            
                        else {
                            
                            // No non-E vowel endings for 6-letter words or more
                            if numLetters() > 5 {
                                return false
                            }
                            
                            syllableCount++
                            sylState = .ArticulateVowel
                            
                            // Filter out unusual vowel endings
                            if lexSuffix.endBias == 0 {
                                return testEndingVowelExceptions(letters, final: suffix)
                            }
                            
                            return true
                        }
                    }
                        
                    // Just need to handle special cases with certin consonant-vowel blends
                    // ex. S-I and T-I
                    else {
                        
                        // must have another vowel after QU
                        if suffix == .U && last == .Q {
                            nextBias = .ExpectVowel
                        }
                        else {
                            syllableCount++
                            sylState = .ArticulateVowel
                            vowState = .SingleVowel
                            nextBias = .ExpectAny
                        }
                        
                        return true
                    }
                }
                    
                // Vowel after dipthong
                else if sylState == .ArticulateVowel {
                    
                    // No final vowels after a dipthong 
                    // What about MOCHA ??
                    if endOfWord && lexLast.dipthong {
                        return false
                    }
                    
                    vowState = .SingleVowel
                    syllableCount++
                    return true
                }                
            }
                
            // VOWEL FOLLOWED BY VOWEL
            else if let lexLast = letterDictionary[last!] as? Vowel {
                
                // First letter was a vowel - very strict about blends here
                if numLetters() == 1 {
                    
                    // Special case for vowels after Y, these are ok
                    if sylState == .ArticulateStart {
                        sylState = .ArticulateVowel
                        nextBias = .ExpectConsonant
                        return true
                    }
                    
                    // Vowels blend, but make sure next letter better is a consonant
                    else if lexLast.blendStart.indexOf(suffix) != nil {
                        vowState = .DoubleVowelBlend
                        expecting = consonantsForVowelBlend(last!, second: suffix, pred: nextToLast)
                        if expecting.isEmpty {
                            nextBias = .ExpectConsonant
                        }
                        else {
                            nextBias = .ExpectSubset
                        }
                        return true
                    }
                        
                    // SPECIAL EXCEPTIONS FOR VOWEL COMBINATIONS HERE
                    // 1) GAOL
                    else if suffix == .O && last == .A && nextToLast == .G {
                        vowState = .DoubleVowelBlend
                        expecting = consonantsForVowelBlend(last!, second: suffix, pred: nextToLast)
                        if expecting.isEmpty {
                            nextBias = .ExpectConsonant
                        }
                        else {
                            nextBias = .ExpectSubset
                        }
                        return true
                    }
                        
                    else {
                        return false
                    }
                }
                    
                // If the vowels don't blend here, assume the next one starts a new syllable
                else {
                    
                    // Too many consecutive vowels
                    if nextBias == .ExpectConsonant {
                        return false
                    }
                                        
                    // Next try end of word cases
                    if endOfWord {
                        
                        if lexSuffix.endBias == 0 {
                            return false
                        }
                            
                        // no ending vowel blends after a dipthong
//                        else if last!.isDipthong() {
//                            return false
//                        }
                            
                        // make sure they blend
                        else if lexLast.blendInto.indexOf(suffix) != nil {
                            return true
                        }
                                                   
                        // and any final E combination (except for A)
                        else if suffix == .E && last != .A {
                            return true
                        }
                            
                        else {
                            return false
                        }
                    }
                    
                    // Special case for vowel after Q-U...it's not a blend here
                    if nextToLast == .Q {
                        sylState = .ArticulateVowel
                        vowState = .SingleVowel
                        nextBias = .ExpectAny
                        return true
                    }
                    
                    // Otherwise, get a list of consonants which can follow the vowel blend
                    // If there are none, then reject this word
                    expecting = consonantsForVowelBlend(last!, second: suffix, pred: nextToLast)
                    if expecting.count > 0 {
                        sylState = .ArticulateVowel
                        vowState = .DoubleVowelBlend
                        nextBias = .ExpectSubset
                        return true
                    }
                    else {
                        return false
                    }
                }
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
        
        return true
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
