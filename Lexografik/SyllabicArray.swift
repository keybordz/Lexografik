//
//  SyllabicArray.swift
//  Lexografik
//
//  Created by Jay Wright on 6/3/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import Foundation

class SyllabicArray {
    var elements: [SyllabicElement]
    var skipLast: Bool = false
    var final: Bool = false
    
    init() {
        elements = []
    }
    
    init(syll: SyllabicArray) {
        
        // is this really a copy?
        elements = syll.elements
    }
    
    func numSyllables() -> Int {
        return elements.count
    }
    
    func numLetters() -> Int {
        var nLetters = 0
        
        for e in elements {
            nLetters += e.numLetters()
        }
        
        return nLetters
    }
    
    func firstSyllable() -> SyllabicElement {
        
        return self.elements[0]
    }
    
    func currentSyllable() -> SyllabicElement {
        
        return self.elements[self.elements.count - 1]
    }
    
    func replaceElements(_ newElements: SyllabicArray) {
        elements = newElements.elements
    }
    
    func stringRep() -> String {
        var elementStr: String = ""
        
        for e in elements {
            elementStr.append(e.letters())
        }
        
        return elementStr
    }
    
    func initialVowel() -> PhoneticElement? {
        if elements.count == 0 {
            return nil
        }
        
        // Special case where two vowels are separated by a glottal stop at the start of the word (ex. AORTA)
        else if elements.count > 1 && elements[0].initialConsonant == nil &&
            elements[0].finalConsonant == nil && elements[1].initialConsonant == nil {
            let combinedVowelID = elements[0].vowelSound!.id + elements[1].vowelSound!.id
            let combinedVowel = vowelBlendMap[combinedVowelID]
            return combinedVowel
        }
            
        else {
            return elements[0].vowelSound
        }
    }
    
    func firstElement() -> PhoneticElement? {
        if elements.count == 0 {
            return nil
        }
        else if elements[0].initialConsonant != nil {
            return elements[0].initialConsonant
        }
        else {
            return elements[0].vowelSound
        }
    }
    
    func lastElement() -> PhoneticElement? {
        let lastSyllable = elements[elements.count - 1]
        var prevSyllable: SyllabicElement? = nil
        
        if elements.count > 1 {
            prevSyllable = elements[elements.count - 2]
        }
        
        if lastSyllable.ancillaryConsonant != nil {
            if !skipLast {
                return lastSyllable.ancillaryConsonant
            }
            else {
                return lastSyllable.silentE
            }
        }
        else if lastSyllable.silentE != nil {
            if !skipLast {
                return lastSyllable.silentE
            }
            else {
                return lastSyllable.finalConsonant
            }
        }
        else if lastSyllable.finalConsonant != nil {
            if !skipLast {
                return lastSyllable.finalConsonant
            }
            else {
                return lastSyllable.vowelSound
            }
        }
            
        else if lastSyllable.vowelSound != nil {
            if !skipLast {
                return lastSyllable.vowelSound
            }
            else if lastSyllable.initialConsonant != nil {
                return lastSyllable.initialConsonant
            }
            else if prevSyllable != nil {
                if prevSyllable!.finalConsonant != nil {
                    return prevSyllable!.finalConsonant
                }
                else {
                    return prevSyllable!.vowelSound
                }
            }
            else {
                return nil
            }
        }
        
        // This has to be the consonant start of a word
        else {
            return lastSyllable.initialConsonant
        }
    }
    
    func nextToLastElement() -> PhoneticElement? {
        let lastSyllable = elements[elements.count - 1]
        var prevSyllable: SyllabicElement? = nil

        if elements.count > 1 {
            prevSyllable = elements[elements.count - 2]
        }
        
        if lastSyllable.ancillaryConsonant != nil {
            if !skipLast {
                return lastSyllable.silentE
            }
            else {
                return lastSyllable.finalConsonant
            }
        }
        else if lastSyllable.silentE != nil {
            if !skipLast {
                return lastSyllable.finalConsonant
            }
            else {
                return lastSyllable.vowelSound
            }
        }
        else if lastSyllable.finalConsonant != nil  {
            if !skipLast {
                return lastSyllable.vowelSound
            }
            else {
                if lastSyllable.initialConsonant != nil {
                    return lastSyllable.initialConsonant
                }
                else if prevSyllable != nil {
                    if prevSyllable!.finalConsonant != nil {
                        return prevSyllable!.finalConsonant
                    }
                    else {
                        return prevSyllable!.vowelSound
                    }
                }
                else {
                    return nil
                }
            }
        }
        else if lastSyllable.vowelSound != nil {
            
            if lastSyllable.initialConsonant != nil && !skipLast {
                return lastSyllable.initialConsonant
            }
            else if prevSyllable != nil {
                if prevSyllable!.finalConsonant != nil || skipLast {
                    return prevSyllable!.finalConsonant
                }
                else {
                    return prevSyllable!.vowelSound
                }
            }
            else {
                return nil
            }
        }
        else if prevSyllable != nil {
            if prevSyllable!.finalConsonant != nil && !skipLast {
                return prevSyllable!.finalConsonant
            }
            else {
                return prevSyllable!.vowelSound
            }
        }
        else {
            return nil
        }
    }

    func matchesString(_ compareString: String, matchFull: Bool) -> Bool {
        let fullString = self.stringRep()
        
        if matchFull {
            if compareString == fullString {
                return true
            }
            else {
                return false
            }
        }
        
        else {
            let shortString = String(fullString.prefix(fullString.count - 1))
            if compareString == shortString {
                return true
            }
            else {
                return false
            }
        }
     }
    
    func matchesSet(_ checkSet: [String]) -> Bool {
        for item in checkSet {
            if matchesString(item, matchFull: !skipLast) {
                return true
            }
        }
        return false
    }

}
