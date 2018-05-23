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
}
