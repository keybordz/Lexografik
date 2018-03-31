//
//  Vowel.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class Vowel: LexicalLetter {
    
    override init(id: Letter, blendStart: [Letter], blendInto: [Letter], blendFinal: [Letter], canPlural: Bool, endBias: Int) {
        
        super.init(id: id, blendStart: blendStart, blendInto: blendInto, blendFinal: blendFinal, canPlural: canPlural, endBias: endBias)
        
        self.initialFollowers = { return blendStart + consonants }
        self.interiorFollowers = { (phonemes:PhoneticElementArray) in return blendInto + consonants }
        self.finalFollowers = { (phonemes:PhoneticElementArray) in return blendInto + blendFinal }
    
        self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in
            let lastElement = phonemes.lastElement()
            
            // No short words with a triple consonant followed by a vowel, i.e. CHRO
            if phonemes.numLetters() == lastElement!.numLetters && lastElement! is ConsonantBlend {
                return false
            }
                
            else if endBias == 0 {
                return false
            }
                
            else {
                return true     
            }
        }

        self.verifyPlural = { (elements:PhoneticElementArray) -> Bool in return true }
    }
    
    init(id: Letter, blendStart: [Letter], blendInto: [Letter], blendFinal: [Letter], canPlural: Bool, endBias: Int,
        verifyEnd: @escaping (PhoneticElementArray) -> Bool) {
        
        super.init(id: id, blendStart: blendStart, blendInto: blendInto, blendFinal: blendFinal, canPlural: canPlural, endBias: endBias)
        
        self.initialFollowers = { return blendStart + consonants }
        self.interiorFollowers = { (phonemes:PhoneticElementArray) in return blendInto + consonants }
        self.verifyEndOfWord = verifyEnd
        self.verifyPlural = { (elements:PhoneticElementArray) -> Bool in return true }
    }

}

// VOWELS
let A = Vowel( id: .A,
    blendStart: [.A, .E, .I, .O, .U],
    blendInto: [.I, .U],
    blendFinal: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
    canPlural: true,
    endBias: 1 )

let E = Vowel( id: .E,
    blendStart: [.A, .E, .I, .O, .U],
    blendInto: [.A, .E, .I, .U],
    blendFinal: [.D, .F, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
    canPlural: true,
    endBias: 3 )

let I = Vowel( id: .I,
    blendStart: [.O],
    blendInto: [.A, .E, .O],
    blendFinal: [.B, .C, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T, .X],
    canPlural: true,
    endBias: 0,
    verifyEnd: { (phonemes: PhoneticElementArray) in
        let finalIWords = ["ANT", "CORG", "DEL", "FOC", "GNOCCH", "LOC", "RAK",
                           "SAFAR", "SALAM", "SAR", "SUSH", "TOR", "WAD", "YOG", "LATH"]
        
        for word in finalIWords {
            if phonemes.matchesString(word, matchFull: true) {
                return true
            }
        }

        return false
} )

let O = Vowel( id: .O,
    blendStart: [.A, .O, .I, .U],
    blendInto: [.A, .E, .O, .I, .U],
    blendFinal: [.B, .C, .D, .G, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
    canPlural: true,
    endBias: 1 )

let U = Vowel( id: .U,
    blendStart: [],
    blendInto: [.I],
    blendFinal: [.B, .D, .G, .M, .N, .P, .R, .S, .T, .X, .Y],
    canPlural: true,
    endBias: 0,
    verifyEnd: { (phonemes: PhoneticElementArray) in
        let finalUWords = ["SNAF", "TOF", "THR"]
        
        for word in finalUWords {
            if phonemes.matchesString(word, matchFull: true) {
                return true
            }
        }
        
        return false
} )

let vowelMap: [Letter:Vowel] = [.A:A, .E:E, .I:I, .O:O, .U:U]
