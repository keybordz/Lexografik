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
    case expectElement
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
    
    
    func processNewLetter(element: PhoneticElement, state: SyllableState, bias: NextLetterBias) {
        phonemes.appendElement(element)
        sylState = state
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
            expecting = suffixProtocol.initialFollowers(nRemain: remainingLetters)
            if expecting.isEmpty {
                return false
            }
            if suffix.isVowel() {
                processNewLetter(element: lexSuffix, state: .articulateVowel, bias: .expectSubset)
            }
            else {
                processNewLetter(element: lexSuffix, state: .articulateStart, bias: .expectSubset)
            }
            return true
        }
            
        else {
            lastElement = phonemes.lastElement()
            
            // Check if there is a predefined set of words for the combined prefix
            if nLetters == 2 && processMatches(suffix: suffix) {
                if suffix.isVowel() {
                    processNewLetter(element: lexSuffix, state: .articulateVowel, bias: .expectSequence)
                }
                else if sylState == .articulateVowel {
                    processNewLetter(element: lexSuffix, state: .articulateStop, bias: .expectSequence)
                }
                else {
                    processNewLetter(element: lexSuffix, state: sylState, bias: .expectSequence)
                }
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
                if suffix.isVowel() {
                    processNewLetter(element: lexSuffix, state: .articulateVowel, bias: .expectSequence)
                }
                else if sylState == .articulateVowel {
                    processNewLetter(element: lexSuffix, state: .articulateStop, bias: .expectSequence)
                }
                else {
                    processNewLetter(element: lexSuffix, state: sylState, bias: .expectSequence)
                }
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
                if endOfWord && suffix == .S && lastElement!.id != "S" {
                    processNewLetter(element: lexSuffix!, state: .articulateStop, bias: .expectSubset)
                    return true
                }
                    
                // Treat interior and final Y's the same way as vowels
                else if suffix == .Y {
                
                    if !endOfWord {
                        
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
                    }
                    
                    processNewLetter(element: lexSuffix!, state: .articulateVowel, bias: .expectSubset)
                    return true
                }
                
                // This is for single consonants that follow an interior Y (treat just like following a vowel)
                else if lastElement!.id == "Y" {
                    
                    if !endOfWord {
                        if remainingLetters == 2 {
                            expecting = suffixProtocol.lastFollowers(pea: phonemes)
                        }
                        else {
                            expecting = suffixProtocol.midFollowers(pea: phonemes, nRemain: remainingLetters)
                        }
                        if expecting.isEmpty {
                            return false
                        }
                    }
                    
                    processNewLetter(element: lexSuffix!, state: .articulateStop, bias: .expectSubset)
                    return true
                }
                
                // Consonant following vowel-diphthong pair like AH, OW, etc.
                else if lastElement is DiphthongBlend {
                    
                    if !endOfWord {

                        // If following a W-diphthong blend with an R or H, then resplit so that vowel becomes single element
                        // Then match a new blend with the preceding letter and the new one (fall thru to next section)
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
                            processNewLetter(element: lexSuffix!, state: .articulateStop, bias: .expectSubset)
                            return true
                        }
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
                }
                
                // All cases where consonants don't blend...hard stops, etc.
                if conBlend == nil {
                    
                    // If it's not a blend at the end of the word, should be a special case like COLUMN
                    if endOfWord {
                        processNewLetter(element: lexSuffix!, state: .articulateStop, bias: .expectSubset)
                        return true
                    }
                        
                    // Letters blend phonetically but don't form a unit (ex. CST in ECSTASY)
                    // Just deal with the new letter by itself
                    else if (lastElement! is Consonant || lastElement! is ConsonantBlend) &&
                           lexLast.blendInto.contains(suffix) &&
                           (sylState != .articulateStart) {
                        expecting = suffixProtocol.initialFollowers(nRemain: remainingLetters)
                        processNewLetter(element: lexSuffix!, state: .articulateStart, bias: .expectSubset)
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
                        processNewLetter(element: lexSuffix!, state: .articulateStart, bias: .expectSubset)
                        return true
                    }
                     
                    // Adding the new consonant is ok if filterStops is turned off
                    else if !filterStops {
                        
                        // Treat the new letter as the first in a new word (biased towards expecting vowel followers)
                        expecting = suffixProtocol.initialFollowers(nRemain: remainingLetters)
                        processNewLetter(element: lexSuffix!, state: .articulateStart, bias: .expectSubset)
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
                        processNewLetter(element: lexSuffix!, state: .articulateStop, bias: .expectSubset)
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
                    
                    processNewLetter(element: conBlend!, state: .articulateStop, bias: .expectSubset)
                    return true
                }
            }
                
            // VOWEL FOLLOWED BY CONSONANT
            else if last!.isVowel() {
                
                // Appending a consonant after an initial vowel
                if nLetters == 1 && !suffix.isDipthong() {
                    
                    expecting = suffixProtocol.secondFollowers(pea: phonemes, nRemain: remainingLetters)
                    
                    if !expecting.isEmpty {
                        processNewLetter(element: lexSuffix!, state: .articulateStop, bias: .expectSubset)
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
                            processNewLetter(element: dipBlend!, state: .articulateVowel, bias: .expectSubset)
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
                        
                    // Here, adding the diphthong doesn't add a new element so any consonant entity (single or blend)
                    // paired with the succeeding vowel means there will already be 2 elements present before calling secondFollowers
                    else if phonemes.numElements() == 2 {
                        expecting = dipBlend!.secondFollowers(pea: phonemes, nRemain: remainingLetters)
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
                    if lexSuffix!.verifyEndOfWord!(phonemes) {
                        processNewLetter(element: lexSuffix!, state: .articulateStop, bias: .expectSubset)
                    }
                    else {
                        return false
                    }
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
                processNewLetter(element: lexSuffix!, state: .articulateStop, bias: .expectSubset)
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
                    if lexSuffix.verifyEndOfWord!(phonemes) {
                        processNewLetter(element: lexSuffix, state: .articulateVowel, bias: .expectSubset)
                        return true
                    }
                    else {
                        return false
                    }
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
                                processNewLetter(element: lexSuffix, state: .articulateVowel, bias: .expectSubset)
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
                        processNewLetter(element: lexSuffix, state: .articulateVowel, bias: .expectSubset)
                    }
                    return true
                }
            }
                
            // VOWEL FOLLOWED BY VOWEL
            else if last!.isVowel() {
                var vKey: String
                var vowelBlend: VowelBlend?
                
                // For vowels following QU, need to treat them as single vowels after a consonant
                if lastElement!.id == "QU" || lastElement!.id == "SQU" {
                    
                    // First vowel added after initial consonant/consonant blend
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
                    processNewLetter(element: lexSuffix, state: .articulateVowel, bias: .expectSubset)
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
                                expecting = suffixProtocol.lastFollowers(pea: phonemes)
                            }
                            else {
                                expecting = suffixProtocol.midFollowers(pea: phonemes, nRemain: remainingLetters)
                            }
                            if expecting == [] {
                                return false
                            }
                            processNewLetter(element: lexSuffix, state: .articulateStart, bias: .expectSubset)
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
                        processNewLetter(element: vowelBlend!, state: .articulateVowel, bias: .expectSubset)
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
                    processNewLetter(element: vowelBlend!, state: .articulateStart, bias: .expectSubset)
                }
                else {
                    processNewLetter(element: vowelBlend!, state: .articulateVowel, bias: .expectSubset)
                }
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

