//
//  LetterArray.swift
//  Lexografik
//
//  Created by Jay Wright on 9/17/15.
//  Copyright (c) 2015 Keybordz. All rights reserved.
//

import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

enum SyllableState: Int {
    case Empty = 0
    case articulateStart
    case articulateVowel
    case articulateStop
}

enum NextLetterBias: Int {
    case expectAny = 0
    case expectVowel
    case expectConsonant
    case expectSubset
    case expectSequence
    case expectElement
}

class LetterArray: Equatable {
    var letters: [Letter]
    var sylState: SyllableState = .Empty
    var nextBias: NextLetterBias = .expectAny
    var expecting: [Letter] = []
    var exactMatches: [String] = []
    var filterStops: Bool = true
    var oneSyllableWords: Bool = false
    var phonemes: PhoneticElementArray = PhoneticElementArray()
    var syllables: SyllabicArray = SyllabicArray()
    
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
    
    init(sourceArray: LetterArray) {
        self.letters = sourceArray.letters
        self.sylState = sourceArray.sylState
        self.nextBias = sourceArray.nextBias
        self.expecting = sourceArray.expecting
        self.phonemes.replaceElements(sourceArray.phonemes)
        self.filterStops = sourceArray.filterStops
        self.oneSyllableWords = sourceArray.oneSyllableWords
        self.exactMatches = sourceArray.exactMatches
        self.syllables.replaceElements(sourceArray.syllables)
    }
    
    static func == (rhs: LetterArray, lhs: LetterArray) -> Bool {
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
    
    func hasNoLetters() -> Bool {
        return letters.isEmpty
    }
    
    func numLetters() -> Int {
        return letters.count
    }
    
    func numSyllables() -> Int {
        return syllables.numSyllables()
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
        for x in 0 ..< syllables.elements.count {
            if x != syllables.elements.count - 1 {
                print(syllables.elements[x].letters(), terminator: "-")
            }
            else {
                print(syllables.elements[x].letters(), terminator: "")
            }
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
    
    func splitSyllables(newVowel: PhoneticElement) -> SyllabicElement {
        var newSyllable: SyllabicElement
        let currentIndex = syllables.elements.count - 1
        let stopElement = syllables.elements[currentIndex].finalConsonant!
        let oldStopper: PhoneticElement?
        let newStarter: PhoneticElement
        
        if stopElement is ConsonantBlend {
            let blendElement = stopElement as! ConsonantBlend
            
            // Single blend
            if blendElement.singlePhoneme {
                oldStopper = nil
                newStarter = stopElement
            }
                
            // Two-letter blend
            else if stopElement.third == nil {
                oldStopper = consonantMap[stopElement.first]!
                newStarter = consonantMap[stopElement.second!]!
            }
                
            // Three-letter blend
            else {
                
                // Most blends split after the first letter, except for CHR, SHR, THR, etc.
                if stopElement.second! == .H {
                    let cKey = "\(stopElement.first.rawValue)\(stopElement.second!.rawValue)"
                    oldStopper = consonantBlendMap[cKey]!
                    newStarter = consonantMap[stopElement.third!]!
                }
                else {
                    let cKey = "\(stopElement.second!.rawValue)\(stopElement.third!.rawValue)"
                    oldStopper = consonantMap[stopElement.first]!
                    newStarter = consonantBlendMap[cKey]!
                }
            }
        }
            
        // Single consonant
        else {
            oldStopper = nil
            newStarter = stopElement
        }
        
        syllables.elements[currentIndex].finalConsonant = oldStopper
        
        // Have to wait to initialize newSyllable here with the new consonant and then assign the vowel separately
        // This allows for Y's to work as vowel sounds
        newSyllable = SyllabicElement(firstElement: newStarter)
        newSyllable.vowelSound = newVowel
        return newSyllable
    }
    
    func processNewLetter(newElement: PhoneticElement, newState: SyllableState, bias: NextLetterBias, nRemain: Int) {
        
        // first syllable in the word 
        if sylState == .Empty {
            let newSyllable = SyllabicElement(firstElement: newElement)
            syllables.elements.append(newSyllable)
        }
        
        // either updating the current syllable or forced to split and create a new one
        else {
            let currentIndex = syllables.elements.count - 1
            
            if newState == .articulateStart {
                
                // This case is for updating an initial consonant sound with a blend, just a simple replacement
                if newElement is ConsonantBlend && !syllables.elements[currentIndex].isStopped() {
                    syllables.elements[currentIndex].initialConsonant = newElement
                }
                
                // Single consonant which starts a new syllable after a hard stop OR
                // a consonant blend following a previous single consonant stop
                else {
                    let newSyllable = SyllabicElement(firstElement: newElement)
                    syllables.elements.append(newSyllable)
                }
            }
            
            // all processing for vowel sounds
            else if newState == .articulateVowel {
                
                // Current syllable doesn't have a vowel yet
                if !syllables.elements[currentIndex].isComplete() {
                    syllables.elements[currentIndex].vowelSound = newElement
                }
                
                // Updating the vowel with a blend (or diphthong), may have to split if the blend is a glottal
                else if !syllables.elements[currentIndex].isStopped() {
                    
                    // Simple replacement for diphthongs
                    if newElement is DiphthongBlend {
                        syllables.elements[currentIndex].vowelSound = newElement
                    }
                        
                    // Adding a vowel after a diphthong, have to resplit so that the consonant part now starts the new syllable
                    else if syllables.elements[currentIndex].vowelSound! is DiphthongBlend {
                        let oldVowel = vowelMap[syllables.elements[currentIndex].vowelSound!.first]!
                        let newStarter = consonantMap[syllables.elements[currentIndex].vowelSound!.second!]
                        syllables.elements[currentIndex].vowelSound = oldVowel
                        var newSyllable = SyllabicElement(firstElement: newElement)
                        newSyllable.initialConsonant = newStarter
                        syllables.elements.append(newSyllable)
                    }
                        
                    // Adding a vowel after a simple Y operating as a vowel, just create a syllable with the new vowel
                    else if syllables.elements[currentIndex].vowelSound!.id == "Y" {
                        let newSyllable = SyllabicElement(firstElement: newElement)
                        syllables.elements.append(newSyllable)
                    }
                    
                    else if newElement is VowelBlend {
                        let blendElement = newElement as! VowelBlend
                        
                        // Simple replacement for blends that don't involve glottal stops
                        if !blendElement.glottalStop {
                            syllables.elements[currentIndex].vowelSound = newElement
                        }
                        
                        // Otherwise have to create a new syllable and split up the vowel blend
                        else {
                            let newVowel = vowelMap[newElement.second!]!
                            let newSyllable = SyllabicElement(firstElement: newVowel)
                            syllables.elements.append(newSyllable)
                        }
                    }
                    
                    // Adding a single vowel after a vowel blend (this is for cases like WOOING, RUEING, etc.)
                    // Here the new vowel starts a new syllable
                    else {
                        let newSyllable = SyllabicElement(firstElement: newElement)
                        syllables.elements.append(newSyllable)
                    }
                }
                
                // Adding a vowel to a consonant that is stopped, have to create a new syllable
                else {
                    let blendElement = syllables.elements[currentIndex].finalConsonant as? ConsonantBlend
                    
                    // Check if adding a final (silent) E in one of the last 2 positions in the word
                    // (If this is in the penultimate position, then the last letter could be an S or D which would still be
                    // part of the same syllable, but if it's anything else like R, N, or L then will just delay creating
                    // the new syllabe until certain)
                    // EXCEPTION: Always have to split if the preceding blend ends in a liquid (L or R) like TABLE or CADRE
                    if nRemain <= 2 && newElement.id == "E" &&
                        !(blendElement != nil && (blendElement?.lastLetter().isLiquid())!) {
                        syllables.elements[currentIndex].silentE = newElement
                    }
                        
                    // Create a new syllable
                    else {
                        let newSyllable = splitSyllables(newVowel: newElement)
                        syllables.elements.append(newSyllable)
                    }
                }
            }
                
            // newState is articulateStop
            else {
                
                // No final consonant yet
                if !syllables.elements[currentIndex].isStopped() {
                    syllables.elements[currentIndex].finalConsonant = newElement
                }
                    
                // General case for adding a consonant or consonant blend
                else if nRemain > 1 || syllables.elements[currentIndex].silentE == nil {
                    
                    // If new letter is a single consonant and the current syllable is already stopped, create a new syllable
                    // Cases for this included liquids (HASSLE) and interior hard stops (INLET)
                    if syllables.elements[currentIndex].isStopped() && newElement is Consonant {
                        
                        // Exception for S plurals
                        if nRemain == 1 && newElement.id == "S" {
                            syllables.elements[currentIndex].ancillaryConsonant = newElement
                        }
                        
                        else {
                            let newSyllable = SyllabicElement(firstElement: newElement)
                            syllables.elements.append(newSyllable)
                        }
                    }
                    else {
                        syllables.elements[currentIndex].finalConsonant = newElement
                    }
                }
                
                // Appending last letter following a silent E,
                else {
                    let voicedPluralConsonants = ["C", "G", "Z",                       // LACES, CAGES, BLAZES
                                                  "LS", "NS", "RS", "S", "SH", "SS",   // LENSES, VERSES, RAISES, LASHES, CLASSES
                                                  "LCH", "LSH", "NCH", "RCH", "RSH", "TCH"]
                    
                    let voicedPastConsonants = ["D", "DD", "LD", "ND", "RD",           // CEDED, MOLDED, HANDED, CARDED
                                                "T", "BT", "CT", "FT", "LT", "NT",     // RATED, DOUBTED,
                                                "PT", "RT", "ST", "TT", "XT"]
                    
                    // If it's S or a D (with certain previous consonant stops) just tack it on the end
                    if (newElement.id == "S" && !voicedPluralConsonants.contains(syllables.elements[currentIndex].finalConsonant!.id)) ||
                        (newElement.id == "D" && !voicedPastConsonants.contains(syllables.elements[currentIndex].finalConsonant!.id)) {
                        syllables.elements[currentIndex].ancillaryConsonant = newElement
                    }
                        
                    // Otherwise, have to create a new syllable...single consonants and blends that are unique phonemes (SH, CH)
                    // or liquid combinations (DL, STL) become the starter in the new syllable, other blends must be split so
                    // first letter still stops the first syllable, and the rest starts the new syllable
                    else {
                        var newSyllable = splitSyllables(newVowel: syllables.elements[currentIndex].silentE!)
                        newSyllable.finalConsonant = newElement
                        syllables.elements[currentIndex].silentE = nil
                        syllables.elements.append(newSyllable)
                    }
                }
            }
        }
        
        syllables.skipLast = false
        phonemes.appendElement(newElement)
        sylState = newState
        nextBias = bias
    }
    
    func processMatches(suffix: Letter) -> Bool {
        let mKey = "\(phonemes.stringRep())\(suffix.rawValue)"
        if let matches = wordMatchDictionary[mKey] {
            for matchString in matches {

                if let pIndex = matchString.index(of: "+") {
                    let prefixString = matchString[..<pIndex]
                    let lastChar = prefixString.last!
                    let lastLetter = Letter(rawValue: String(lastChar))!
                    var irregularForm = false
                    
                    // Add a match for the regular string
                    exactMatches.append(String(prefixString))
                    
                    let tokenString = matchString[matchString.index(after: pIndex)...]
                    for token in tokenString {
                        
                        switch token {
                        
                        // Add match for plural nouns
                        case "s":
                            exactMatches.append(String(prefixString) + String("S"))
                            break
                            
                        // Add LY match for adverb form
                        case "l":
                            exactMatches.append(String(prefixString) + String("LY"))
                            break
                            
                        // Add Y to noun form to make adjective
                        case "y":
                            exactMatches.append(String(prefixString) + String("Y"))
                            break
                            
                        case "!":
                            irregularForm = true
                            break
                            
                        // Add matches for verb plural, past tense, and gerund
                        case "r", "n", "v":
                            var prefixCopy = String(prefixString)
                            var nextToLastLetter: Letter? = nil
                            
                            // Try to get the next to last character (if there is one)
                            if prefixString.count > 1 {
                                let penIndex = prefixString.index(prefixString.endIndex, offsetBy: -2)
                                let nextToLastChar = prefixString[penIndex]
                                nextToLastLetter = Letter(rawValue: String(nextToLastChar))
                            }
                            
                            // Normally for words ending in E, have to drop the E when creating gerund and TION followers
                            if lastLetter == .E && !irregularForm {
                                prefixCopy.remove(at: prefixCopy.index(before: prefixCopy.endIndex))
                            }
                                
                            // For words ending in a single consonant, the consonant is usually doubled for past tense & gerund
                            else if !irregularForm && lastLetter.isDoublingConsonant() &&
                                (nextToLastLetter == nil || nextToLastLetter!.isVowel()) {
                                prefixCopy.append(lastChar)
                            }
                            
                            // Verb forms: plural, past tense, and gerund
                            if token == "v" {
                                exactMatches.append(String(prefixString) + String("S"))
                                exactMatches.append(String(prefixCopy) + String("ED"))
                                exactMatches.append(String(prefixCopy) + String("ING"))
                            }
                        
                            // Action noun forms
                            else if token == "r" {
                                exactMatches.append(String(prefixCopy) + String("ER"))
                                exactMatches.append(String(prefixCopy) + String("ERS"))
                            }
                                
                            // Stae noun form
                            else if token == "n" {
                                if lastLetter == .T {
                                    exactMatches.append(String(prefixString) + String("ION"))
                                    exactMatches.append(String(prefixString) + String("IONS"))
                                }
                                else if lastLetter == .E {
                                    if nextToLastLetter != nil && nextToLastLetter! == .T {
                                        exactMatches.append(String(prefixCopy) + String("ION"))
                                        exactMatches.append(String(prefixCopy) + String("IONS"))
                                    }
                                    else if nextToLastLetter != nil && nextToLastLetter! == .D {
                                        prefixCopy.remove(at: prefixCopy.index(before: prefixCopy.endIndex))
                                        exactMatches.append(String(prefixCopy) + String("SION"))
                                        exactMatches.append(String(prefixCopy) + String("SIONS"))
                                    }
                                    else {
                                        exactMatches.append(String(prefixCopy) + String("ATION"))
                                        exactMatches.append(String(prefixCopy) + String("ATIONS"))
                                    }
                                }
                                else {
                                    print("n case not handled")
                                }
                            }
                            break
                            
                        default:
                            break
                        }
                    }
                }
                else {
                    exactMatches.append(matchString)
                }
            }
            return true
        }
        else {
            return false
        }
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
            let newState: SyllableState
            expecting = suffixProtocol.initialFollowers(nRemain: remainingLetters)
            if expecting.isEmpty {
                return false
            }
            if suffix.isVowel() {
                newState = .articulateVowel
            }
            else {
                newState = .articulateStart
            }
            processNewLetter(newElement: lexSuffix, newState: newState, bias: .expectSubset, nRemain: remainingLetters)
            return true
        }
            
        else {
            lastElement = phonemes.lastElement()
            
            // Check if there is a predefined set of words for the combined prefix
            if nLetters == 2 && processMatches(suffix: suffix) {
                let newState: SyllableState
                if suffix.isVowel() {
                    newState = .articulateVowel
                }
                else if sylState == .articulateVowel {
                    newState = .articulateStop
                }
                else {
                    newState = sylState
                }
                processNewLetter(newElement: lexSuffix, newState: newState, bias: .expectSequence, nRemain: remainingLetters)
                return true
            }
        }
        
        // Matching exact sequence of letters
        if nextBias == .expectSequence {
            var x = 0
            var matchLetter: Letter
            for matchString in exactMatches {
                
                // any strings which don't match the remaining number of letters can be removed immediately
                if matchString.count != remainingLetters {
                    exactMatches.remove(at: x)
                    continue
                }

                // Otherwise the matched string only has to contain the current string
                matchLetter = Letter(rawValue: String(matchString[0]))!
                if suffix != matchLetter {
                    exactMatches.remove(at: x)
                }
                    
                // Remove the matched character from the string
                else {
                    exactMatches[x].remove(at: matchString.startIndex)
                    x += 1
                }
            }
            
            // If no matches, then this sequence isn't a valid word
            if exactMatches.count == 0 {
                return false
            }
                
            // Approve the new letter and keep going
            else {
                let newState: SyllableState
                if suffix.isVowel() {
                    newState = .articulateVowel
                }
                else if sylState == .articulateVowel {
                    newState = .articulateStop
                }
                else {
                    newState = sylState
                }
                processNewLetter(newElement: lexSuffix, newState: newState, bias: .expectSequence, nRemain: remainingLetters)
                return true
            }
        }
        
        // Expecting certain letters
        else if nextBias == .expectSubset {
            if expecting.contains(suffix) {
                expecting = []
                nextBias = .expectAny
            }
                
//            else {
//                for lt in expecting {
//                    if lt.rawValue.count > 1 {
//                        if suffix.rawValue.prefix(0) == lt.rawValue.prefix(0) {
//                            nextBias = .expectSequence
//                            exactMatches.append(lt.rawValue.prefix(1))
//                            phonemes.appendElement(lexSuffix)
//                            return true
//                        }
//                    }
//                }
//            }
                
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
                if endOfWord && suffix == .S && last! != .S {
                    processNewLetter(newElement: lexSuffix!, newState: .articulateStop, bias: .expectSubset, nRemain: remainingLetters)
                    return true
                }
                    
                // Treat interior and final Y's the same way as vowels
                else if suffix == .Y {
                    
                    if !endOfWord {
                        // First Y after initial consonant or consonant blend
                        if phonemes.numElements() == 1 {
                            expecting = suffixProtocol.secondFollowers(syll: syllables, nRemain: remainingLetters)
                        }
                            
                        // Just before the last letter
                        else if remainingLetters == 2 {
                            expecting = suffixProtocol.lastFollowers(syll: syllables)
                        }
                            
                        // Somewhere in the middle of the word
                        else {
                            expecting = suffixProtocol.midFollowers(syll: syllables, nRemain: remainingLetters)
                        }
                        
                        // Probably shouldn't have to make this exception but for now so we don't have interior Y's all over the place
                        if !filterStops {
                            expecting += lexSuffix!.hardStops
                        }
                        
                        if expecting == [] {
                            return false
                        }
                    }
                    
                    processNewLetter(newElement: lexSuffix!, newState: .articulateVowel, bias: .expectSubset,
                                     nRemain: remainingLetters)
                    return true
                }
                
                // This is for single consonants that follow an interior Y (treat just like following a vowel)
                else if lastElement!.id == "Y" {

                    if (!endOfWord) {
                        if remainingLetters == 2 {
                            expecting = suffixProtocol.lastFollowers(syll: syllables)
                        }
                        else {
                            expecting = suffixProtocol.midFollowers(syll: syllables, nRemain: remainingLetters)
                        }
                        if expecting.isEmpty {
                            return false
                        }
                    }
                    processNewLetter(newElement: lexSuffix!, newState: .articulateStop, bias: .expectSubset, nRemain: remainingLetters)
                    return true
                }
                
                // Consonant following vowel-diphthong pair like AH, OW, etc.
                else if lastElement is DiphthongBlend {

                    // If following a W-diphthong blend with an R or H, then resplit so that vowel becomes single element
                    // Then match a new blend with the preceding letter and the new one (fall thru to next section)
                    if last! == .W && (suffix == .R || suffix == .H) {
                        reBlend = vowelMap[nextToLast!]
                        syllables.elements[syllables.elements.count-1].setVowel(reBlend!)
                        sylState = .articulateStop
                        lastElement = consonantMap[last!]
                    }
                        
                    // Otherwise just add on the new letter separately
                    else {
                        
                        if !endOfWord {
                            if remainingLetters == 2 {
                                expecting = suffixProtocol.lastFollowers(syll: syllables)
                            }
                            else {
                                expecting = suffixProtocol.midFollowers(syll: syllables, nRemain: remainingLetters)
                            }
                            
                            if expecting.isEmpty {
                                return false
                            }
                        }
                        processNewLetter(newElement: lexSuffix!, newState: .articulateStart, bias: .expectSubset,
                                         nRemain: remainingLetters)
                        return true
                    }
                }
                    
                // Try to match consecutive consonants to a blend element
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
                    
                    // Have to replace the previous final consonant now that the new blend is in effect
                    if conBlend != nil {
                        syllables.elements[syllables.elements.count-1].setFinal(reBlend!)
                        sylState = .articulateStart
                    }
                }
                
                // All cases where consonants don't blend...hard stops, etc.
                if conBlend == nil {
                        
                    // Letters blend phonetically but don't form a unit (ex. CST in ECSTASY)
                    // Just deal with the new letter by itself
                    if (lastElement! is Consonant || lastElement! is ConsonantBlend) &&
                           lexLast.blendInto.contains(suffix) &&
                           (sylState != .articulateStart) {
                        expecting = suffixProtocol.initialFollowers(nRemain: remainingLetters)
                        processNewLetter(newElement: lexSuffix!, newState: .articulateStart, bias: .expectSubset,
                                         nRemain: remainingLetters)
                        return true
                    }
                        
                    // Check if liquid L can follow consonant blend
                    else if suffix == .L && lexLast.liquidBlend {
                        
                        // If the next letter is the last one, only approve E and Y to follow liquid blend
                        if remainingLetters == 2 {
                            expecting = [.E, .Y]
                        }
                        else {
                            expecting = suffixProtocol.initialFollowers(nRemain: remainingLetters)
                        }
                        processNewLetter(newElement: lexSuffix!, newState: .articulateStart, bias: .expectSubset,
                                         nRemain: remainingLetters)
                        return true
                    }
                     
                    // Adding the new consonant is ok if filterStops is turned off
                    else if !filterStops {
                        
                        // Treat the new letter as the first in a new word (biased towards expecting vowel followers)
                        expecting = suffixProtocol.initialFollowers(nRemain: remainingLetters)
                        processNewLetter(newElement: lexSuffix!, newState: .articulateStart, bias: .expectSubset,
                                         nRemain: remainingLetters)
                        return true
                    }
                    
                    else {
                        return false
                    }
                }
                    
                // Have to remove the last phoneme so that followers for consonant blends will properly generate
                phonemes.removeLastElement()
                
                // If a triple blend has been broken up, then the first part must be reattached
                if reBlend != nil {
                    phonemes.appendElement(reBlend!)
                }
                else {
                    syllables.skipLast = true
                }
                
                if (!endOfWord) {
                    // Blend occurs at the start of the word
                    if nLetters == 1 {
                        expecting = conBlend!.initialFollowers(nRemain: remainingLetters)
                    }

                    // Adding the blend after an initial vowel (make sure to ignore Y blends)
                    else if phonemes.numElements() == 1 {
                        expecting = conBlend!.secondFollowers(syll: syllables, nRemain: remainingLetters)
                    }
                        
                    // Blend immediately precedes the last letter
                    else if remainingLetters == 2 {
                        expecting = conBlend!.lastFollowers(syll: syllables)
                    }
                        
                    // Somewhere in the middle
                    else {
                        expecting = conBlend!.midFollowers(syll: syllables, nRemain: remainingLetters)
                        
                        // If filterStops is turned off, then allow prescribed letters which follow a hard stop
                        if !filterStops && sylState != .articulateStart {
                            expecting += lexSuffix!.hardStops
                        }
                    }
                    
                    if expecting.isEmpty {
                        return false
                    }
                }
                
                processNewLetter(newElement: conBlend!, newState: sylState, bias: .expectSubset, nRemain: remainingLetters)
                return true
            }
                
            // VOWEL FOLLOWED BY CONSONANT
            else if last!.isVowel() {
                
                // Appending a consonant after an initial vowel
                if nLetters == 1 && !suffix.isDipthong() {
                    
                    expecting = suffixProtocol.secondFollowers(syll: syllables, nRemain: remainingLetters)
                    
                    // If filterStops is turned off, then allow prescribed letters which follow a hard stop
                    if !filterStops {
                        expecting += lexSuffix!.hardStops
                    }
                    
                    if !expecting.isEmpty {
                        processNewLetter(newElement: lexSuffix!, newState: .articulateStop, bias: .expectSubset,
                                         nRemain: remainingLetters)
                        return true
                    }
                    else {
                        return false
                    }
                }
                    
                // Special case for vowels followed by H, W, and Y
                else if suffix.isDipthong() && (lastElement! is Vowel || lastElement! is VowelBlend) {
                    
                    // NOTE: If following a vowel blend, only grab the last letter to match with
                    let dKey = "\(last!.rawValue)\(suffix.rawValue)"
                    let dipBlend = diphthongBlendMap[dKey]
                    
                    if dipBlend == nil {
                        return false
                    }                    
                    
                    // Final letter processing for dipthong blends
                    if endOfWord {
                        phonemes.removeLastElement()
                        processNewLetter(newElement: dipBlend!, newState: .articulateVowel, bias: .expectSubset,
                                         nRemain: remainingLetters)
                        return true
                    }

                    // Blend occurs at the start of the word
                    if nLetters == 1 {
                        expecting = dipBlend!.initialFollowers(nRemain: remainingLetters)
                    }
                        
                    // Here, adding the diphthong doesn't add a new element so any consonant entity (single or blend)
                    // paired with the succeeding vowel means there will already be 2 elements present before calling secondFollowers
                    // (However, if the last element is a vowel blend, then this doesn't work ex. VIEW)
                    else if phonemes.numElements() == 2 && lastElement is Vowel {
                        expecting = dipBlend!.secondFollowers(syll: syllables, nRemain: remainingLetters)
                    }
                        
                    // Blend immediately precedes the last letter
                    else if remainingLetters == 2 {
                        expecting = dipBlend!.lastFollowers(syll: syllables)
                    }
                        
                    // Somewhere in the middle
                    else {
                        expecting = dipBlend!.midFollowers(syll: syllables, nRemain: remainingLetters)
                    }

                    if expecting.isEmpty {
                        return false
                    }
                    
                    // No change in sylState here since the vowel sound is still active with the diphthong
                    phonemes.removeLastElement()
                    processNewLetter(newElement: dipBlend!, newState: .articulateVowel, bias: .expectSubset,
                                     nRemain: remainingLetters)
                    return true
                }
                    
                // General case for final letter processing (single consonant after vowel)
                else if endOfWord {
                    processNewLetter(newElement: lexSuffix!, newState: .articulateStop, bias: .expectSubset,
                                     nRemain: remainingLetters)
                    return true
                }
                
                if phonemes.numElements() == 1 {
                    expecting = suffixProtocol.secondFollowers(syll: syllables, nRemain: remainingLetters)
                }
                else if remainingLetters == 2 {
                    expecting = suffixProtocol.lastFollowers(syll: syllables)
                }
                else {
                    expecting = suffixProtocol.midFollowers(syll: syllables, nRemain: remainingLetters)
                    
                    // If filterStops is turned off, then allow prescribed letters which follow a hard stop
                    if !filterStops {
                        expecting += lexSuffix!.hardStops
                    }
                }
                
                if expecting == [] {
                    return false
                }
                
                processNewLetter(newElement: lexSuffix!, newState: .articulateStop, bias: .expectSubset, nRemain: remainingLetters)
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
                
                // General end of word processing for single vowel ender
                if endOfWord {
                    processNewLetter(newElement: lexSuffix, newState: .articulateVowel, bias: .expectSubset, nRemain: remainingLetters)
                    return true
                }
                
                else {
                    
                    // Special case for QU
                    if suffix == .U && lastElement!.id.range(of: "Q") != nil {
                        let conBlend = consonantBlendMap["\(lastElement!.id)U"]

                        if (nLetters == 1 && lastElement is Consonant) ||           // QU
                            (nLetters == 2 && lastElement is ConsonantBlend) {      // SQU, NQU
                            expecting = conBlend!.initialFollowers(nRemain: remainingLetters)
                        }
                        else if remainingLetters == 2 {
                            expecting = conBlend!.lastFollowers(syll: syllables)
                        }
                        else {
                            expecting = conBlend!.midFollowers(syll: syllables, nRemain: remainingLetters)
                        }
                        if expecting == [] {
                            return false
                        }
                        
                        // Syllable state is unchanged going from Q to QU
                        phonemes.removeLastElement()
                        processNewLetter(newElement: conBlend!, newState: sylState, bias: .expectSubset,
                                         nRemain: remainingLetters)
                    }

                    // All other cases
                    else {
                        
                        // First vowel added after initial consonant/consonant blend
                        if phonemes.numElements() == 1 {
                            expecting = suffixProtocol.secondFollowers(syll: syllables, nRemain: remainingLetters)
//                            if expecting != [] {
//                                processNewLetter(newElement: lexSuffix, newState: .articulateVowel, bias: .expectSubset,
//                                                 nRemain: remainingLetters)
//                                return true
//                            }
                        }
                            
                        // Just before the last letter
                        else if remainingLetters == 2 {
                            expecting = suffixProtocol.lastFollowers(syll: syllables)
                        }
                        
                        // Somewhere in the middle of the word
                        else {
                            expecting = suffixProtocol.midFollowers(syll: syllables, nRemain: remainingLetters)
                        }
                        
                        if expecting == [] {
                            return false
                        }
                        processNewLetter(newElement: lexSuffix, newState: .articulateVowel, bias: .expectSubset,
                                         nRemain: remainingLetters)
                    }
                    return true
                }
            }
                
            // VOWEL FOLLOWED BY VOWEL
            else if last!.isVowel() {
                var vKey: String
                var vowelBlend: VowelBlend?
                
                // For vowels following QU, need to treat them as single vowels after a consonant
                if lastElement!.id.contains("QU") {
                    
                    // First vowel added after initial consonant/consonant blend
                    if phonemes.numElements() == 1 {
                        expecting = suffixProtocol.secondFollowers(syll: syllables, nRemain: remainingLetters)
                    }
                    
                    // Just before the last letter
                    else if remainingLetters == 2 {
                        expecting = suffixProtocol.lastFollowers(syll: syllables)
                    }
                        
                    // Somewhere in the middle of the word
                    else {
                        expecting = suffixProtocol.midFollowers(syll: syllables, nRemain: remainingLetters)
                    }
                    
                    if expecting == [] {
                        return false
                    }
                    processNewLetter(newElement: lexSuffix, newState: .articulateVowel, bias: .expectSubset,
                                     nRemain: remainingLetters)
                    return true
                }
                
                // Try to find a blend using the last element combined with the new suffix
                vKey = "\(lastElement!.id)\(suffix.rawValue)"
                vowelBlend = vowelBlendMap[vKey]
                
                // Didn't find a blend with this combination of vowels, should only fail for most triple blends
                if vowelBlend == nil {
                    
                    // Certain vowel blends are marked to blend into others, especially for double vowels
                    // which can produce gerunds like SEEING, WOOING, etc. also LUAU
                    if !endOfWord && lastElement! is VowelBlend {
                        let lexLast = lastElement! as! VowelBlend
                        
                        if lexLast.blendInto.contains(suffix) {
                            if remainingLetters == 2 {
                                expecting = suffixProtocol.lastFollowers(syll: syllables)
                            }
                            else {
                                expecting = suffixProtocol.midFollowers(syll: syllables, nRemain: remainingLetters)
                            }
                            if expecting == [] {
                                return false
                            }
                            processNewLetter(newElement: lexSuffix, newState: .articulateVowel, bias: .expectSubset,
                                             nRemain: remainingLetters)
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
                
                // End of word processing for vowel blend enders
                if endOfWord {
                    processNewLetter(newElement: vowelBlend!, newState: .articulateVowel, bias: .expectSubset,
                                     nRemain: remainingLetters)
                    return true
                }
                
                // Remove the first part of the blend to test correctly
                syllables.skipLast = true
                phonemes.removeLastElement()
                
                // Blend occurs at the start of the word
                if nLetters == 1 {
                    expecting = vowelBlend!.initialFollowers(nRemain: remainingLetters)
                }
                                        
                // Adding the blend after an initial cononsant
                else if phonemes.numElements() == 1 {
                    expecting = vowelBlend!.secondFollowers(syll: syllables, nRemain: remainingLetters)
                }
                    
                // Blend immediately precedes the last letter
                else if remainingLetters == 2 {
                    expecting = vowelBlend!.lastFollowers(syll: syllables)
                }
                    
                // Somewhere in the middle
                else {
                    expecting = vowelBlend!.midFollowers(syll: syllables, nRemain: remainingLetters)
                }
                
                if expecting.isEmpty {
                    return false
                }
                
                processNewLetter(newElement: vowelBlend!, newState: .articulateVowel, bias: .expectSubset, nRemain: remainingLetters)
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

