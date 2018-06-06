//
//  SyllabicElement.swift
//  Lexografik
//
//  Created by Jay Wright on 5/19/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import Foundation

struct SyllabicElement {
    var initialConsonant: PhoneticElement?
    var vowelSound: PhoneticElement?
    var finalConsonant: PhoneticElement?
    var silentE: PhoneticElement?                    // can only be E
    var ancillaryConsonant: PhoneticElement?         // can only be D or S
    
    init(source: SyllabicElement) {
        self.initialConsonant   = source.initialConsonant
        self.vowelSound         = source.vowelSound
        self.finalConsonant     = source.finalConsonant
        self.silentE            = source.silentE
        self.ancillaryConsonant = source.ancillaryConsonant
    }
    
    // NOTE: This will always treat Y's as consonants!
    init(firstElement: PhoneticElement) {
        if firstElement is Vowel {
            self.vowelSound = firstElement
        }
        else {
            self.initialConsonant = firstElement
        }
    }
    
    func isComplete() -> Bool {
        if self.vowelSound == nil {
            return false
        }
        else {
            return true
        }
    }
    
    func isStopped() -> Bool {
        if self.finalConsonant == nil {
            return false
        }
        else {
            return true
        }
    }
    
    func letters() -> String {
        var stringRep: String = ""
        
        if initialConsonant != nil {
            stringRep.append(initialConsonant!.id)
        }
        if vowelSound != nil {
            stringRep.append(vowelSound!.id)
        }
        if finalConsonant != nil {
            stringRep.append(finalConsonant!.id)
        }
        if silentE != nil {
            stringRep.append(silentE!.id)
        }
        if ancillaryConsonant != nil {
            stringRep.append(ancillaryConsonant!.id)
        }
        return stringRep
    }
    
    func numLetters() -> Int {
        var letterCount: Int = 0
        
        if initialConsonant != nil {
            letterCount += initialConsonant!.id.count
        }
        if vowelSound != nil {
            letterCount += vowelSound!.id.count
        }
        if finalConsonant != nil {
            letterCount += finalConsonant!.id.count
        }
        if silentE != nil {
            letterCount += silentE!.id.count
        }
        if ancillaryConsonant != nil {
            letterCount += ancillaryConsonant!.id.count
        }
        return letterCount
    }
    
    mutating func setVowel(_ newVowel: PhoneticElement) {
        self.vowelSound = newVowel
    }
    
    mutating func setFinal(_ newFinal: PhoneticElement) {
        self.finalConsonant = newFinal
    }
}
