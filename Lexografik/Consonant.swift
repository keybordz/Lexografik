//
//  Consonant.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class Consonant: LexicalLetter {

    let dipthong: Bool
    let liquidBlend: Bool
    
    init(id: Letter, blendStart: [Letter], blendInto: [Letter], blendFinal: [Letter],
         canPlural: Bool, endBias: Int, dipthong: Bool, liquidBlend: Bool) {
        
        self.dipthong = dipthong
        self.liquidBlend = liquidBlend
        super.init(id: id, blendStart: blendStart, blendInto: blendInto, blendFinal: blendFinal,
                   canPlural: canPlural, endBias: endBias)
        
        self.initialFollowers = { return blendStart + vowels + [.Y] }
        self.interiorFollowers = { (phonemes:PhoneticElementArray) -> [Letter] in
            return blendInto + vowels }

        if endBias > 1 {
            self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
        }
        else {
            self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        
        if canPlural {
            self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
            self.finalFollowers = { (phonemes:PhoneticElementArray) -> [Letter] in
                return blendFinal + [.S] }
        }
        else {
            self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return false }
            self.finalFollowers = { (phonemes:PhoneticElementArray) -> [Letter] in
                return blendFinal }
        }
        
    }
    
    init(id: Letter, blendStart: [Letter], blendInto: [Letter], blendFinal: [Letter],
         canPlural: Bool, endBias: Int, dipthong: Bool, liquidBlend: Bool,
         initial: (() -> [Letter])?,
         interior: ((PhoneticElementArray) -> [Letter])?,
         verifyEnd: ((PhoneticElementArray) -> Bool)?) {
        
        self.dipthong = dipthong
        self.liquidBlend = liquidBlend
        super.init(id: id, blendStart: blendStart, blendInto: blendInto, blendFinal: [],
                   canPlural: canPlural, endBias: endBias)
        
        if initial == nil {
            self.initialFollowers = { return blendStart + vowels + [.Y] }
        }
        else {
            self.initialFollowers = initial
        }
        
        if interior == nil {
            self.interiorFollowers = { (phonemes:PhoneticElementArray) -> [Letter] in
                return blendInto + vowels + [.Y] }
        }
        else {
            self.interiorFollowers = interior
        }
        
        if canPlural {
            self.finalFollowers = { (phonemes:PhoneticElementArray) -> [Letter] in
                return blendFinal + [.S] }
        }
        else {
            self.finalFollowers = { (phonemes:PhoneticElementArray) -> [Letter] in
                return blendFinal }
        }
        
        if verifyEnd == nil {
            if endBias == 0 {
                self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
            }
            else {
                self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
            }
        }
        else {
            self.verifyEndOfWord = verifyEnd
            
            // If there's a conditional test for the end, then use it to verify pluralization
            verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in
                let testPhonemes = PhoneticElementArray(pea: phonemes)
                testPhonemes.removeLastElement()
                return self.verifyEndOfWord!(testPhonemes)
            }
        }
        
        if canPlural {
            self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
        }
        else {
            self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
    }
}

// CONSONANTS
let B = Consonant( id: .B,
    blendStart: [.L, .R],
    blendInto: [.B, .L],
    blendFinal: [.A, .E, .I, .O, .Y],
    canPlural: true,
    endBias: 2,
    dipthong: false,
    liquidBlend: true,
    initial: nil,
    interior: nil,
    verifyEnd:
    { (phonemes: PhoneticElementArray) in
        let lastElement = phonemes.lastElement()
        
        if phonemes.numLetters() == 3 {
            if phonemes.numSyllables() == 1 && lastElement!.id != "E" {
                return true
            }
            else {
                return false
            }
        }
        else {
            return true
        }
} )

let C = Consonant( id: .C,
    blendStart: [.H, .L, .R],
    blendInto: [.C, .H, .K, .R, .S, .T],
    blendFinal: [.A, .E, .H, .I, .K, .O, .T, .Y],
    canPlural: true,
    endBias: 1,
    dipthong: false,
    liquidBlend: true,
    initial: nil,
    interior: nil,
    verifyEnd:
    { (phonemes: PhoneticElementArray) in
        
        let lastElement = phonemes.lastElement()
        
        // Single vowels
        if lastElement is Vowel {
            
            // IC is always a valid ending
            if lastElement!.id == "I" {
                return true
            }
                
            // other vowels only work with single syllable words
            // COULD BE EXCEPTIONS TO THIS...something like EMACS?
            else if phonemes.numSyllables() > 1 {
                return false
            }
                
            else {
                return true
            }
        }
            
        // Vowel blends that end in I are ok
        else if lastElement is VowelBlend && String(Array(lastElement!.id)[1]) == "I" {
            return true
        }
            
        else {
            return false
        }
    } )

let D = Consonant( id: .D,
    blendStart: [.R],
    blendInto: [.D],
    blendFinal: [.A, .E, .I, .O, .Y],
    canPlural: true,
    endBias: 3,
    dipthong: false,
    liquidBlend: true )

let F = Consonant( id: .F,
    blendStart: [.L, .R],
    blendInto: [.F, .R, .T],    // do we need L here?
    blendFinal: [.E, .F, .I, .T, .U, .Y],
    canPlural: true,
    endBias: 2,
    dipthong: false,
    liquidBlend: true,
    initial: nil,
    interior: nil,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        
        let lastElement = phonemes.lastElement()
        
        // 4 letter words: only allow vowel blends and E ("CLEF"), no 2-syllable words ending in F
        if phonemes.numLetters() < 4 {
            if lastElement! is VowelBlend {
                return true
            }
            else if phonemes.numSyllables() == 2 || lastElement!.id != "E" {
                return false
            }
            else {
                return true
            }
        }
            
        // Only allow vowel blends (which ones?) for 5-letter or longer words, ex. THIEF, PROOF
        else {
            if lastElement! is VowelBlend {
                return true
            }

            else {
                return true
            }
        }
    }
)

let G = Consonant( id: .G,
    blendStart: [.L, .N, .R],
    blendInto: [.G, .H, .N],
    blendFinal: [.A, .E, .H, .I, .N, .O, .Y],
    canPlural: true,
    endBias: 2,
    dipthong: false,
    liquidBlend: true,
    initial: nil,
    interior: nil,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        
        let lastElement = phonemes.lastElement()
        
        // No vowel blends before G?
        if lastElement is VowelBlend {
            return false
        }
        
        else if lastElement is Vowel {
            
            // No 4 or 5-letter, 2 syllable words ending in G except AGOG
            if phonemes.numLetters() <= 4 && phonemes.numSyllables() == 2 && lastElement!.id != "O" {
                return false
            }
            else {
                return true
            }
        }
        
        else {
            return true
        }
    }
)

let H = Consonant( id: .H,
    blendStart: [],
    blendInto: [.M, .R, .T],
    blendFinal: [.E, .N, .T, .O, .Y],
    canPlural: true,
    endBias: 3,
    dipthong: true,
    liquidBlend: false )

let J = Consonant( id: .J,
    blendStart: [],
    blendInto: [],
    blendFinal: [.A, .O],
    canPlural: false,
    endBias: 0,
    dipthong: false,
    liquidBlend: false )

let K = Consonant( id: .K,
    blendStart: [.L, .N, .R],
    blendInto: [.L, .N, .R],
    blendFinal: [.A, .E, .I, .O, .Y],
    canPlural: true,
    endBias: 2,
    dipthong: false,
    liquidBlend: true,
    initial: nil,
    interior: nil,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        
        let lastElement = phonemes.lastElement()
        let finalKWords = ["TRE", "AMO"]    // Only valid 4-letter works ending in vowel-K
        
        if lastElement is Vowel {
            
            // Need to allow words like TREK and AMOK
            if phonemes.numLetters() == 3 && lastElement! is Vowel {
                for word in finalKWords {
                    if phonemes.matchesString(word, matchFull: true) {
                        return true
                    }
                }
                return false
            }
                    
            
            else {
                return false
            }
        }
            
        else {
            return true
        }
    } )

let L = Consonant( id: .L,
    blendStart: [],
    blendInto: [.B, .C, .D, .F, .G, .K, .L, .M, .P, .S, .T, .V],
    blendFinal: [.A, .B, .D, .E, .I, .L, .M, .O, .P, .T, .Y],
    canPlural: true,
    endBias: 2,
    dipthong: false,
    liquidBlend: false )

let M = Consonant( id: .M,
    blendStart: [],
    blendInto: [.B, .M, .P],
    blendFinal: [.A, .B, .E, .I, .O, .P, .Y],
    canPlural: true,
    endBias: 2,
    dipthong: false,
    liquidBlend: false )

let N = Consonant( id: .N,
    blendStart: [.Y],
    blendInto: [.C, .D, .F, .G, .K, .L, .M, .N, .P, .Q, .S, .T, .V, .Y, .Z],
    blendFinal: [.C, .D, .E, .G, .I, .K, .N, .O, .T, .Y],
    canPlural: true,
    endBias: 3,
    dipthong: false,
    liquidBlend: false )

let P = Consonant( id: .P,
    blendStart: [.H, .L, .R, .S],
    blendInto: [.P, .S, .T],
    blendFinal: [.A, .E, .H, .I, .O, .T, .Y],
    canPlural: true,
    endBias: 2,
    dipthong: false,
    liquidBlend: true,
    initial: nil,
    interior: nil,
    verifyEnd:
    { (phonemes: PhoneticElementArray) in
        
        if phonemes.numLetters() == 3 {
            if phonemes.numSyllables() == 1 {
                return true
            }
            else {
                return false
            }
        }
        else {
            return true
        }
} )

let Q = Consonant( id: .Q,
    blendStart: [],
    blendInto: [],
    blendFinal: [],
    canPlural: false,
    endBias: 0,
    dipthong: false,
    liquidBlend: false,
    initial: { return [.U] },
    interior: { (phonemes: PhoneticElementArray) -> [Letter] in return [.U] },
    verifyEnd: nil )

let R = Consonant( id: .R,
    blendStart: [.H],
    blendInto: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V],
    blendFinal: [.A, .B, .D, .E, .F, .G, .I, .K, .L, .M, .N, .O, .P, .T, .Y],
    canPlural: true,
    endBias: 3,
    dipthong: false,
    liquidBlend: false,
    initial: nil,
    interior: nil,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        
        let lastElement = phonemes.lastElement()
        let finalIRWords = ["EMI", "STI", "NADI"]
        
        // No consonant-I-R endings except for STIR, NADIR, EMIR -- any others?
        if lastElement is Vowel && lastElement!.id == "I" {
            
            if phonemes.numLetters() < 5 {
                for word in finalIRWords {
                    if phonemes.matchesString(word, matchFull: true) {
                        return true
                    }
                }
                return false
            }
                
            else {
                return false
            }
        }
        
        else {
            return true
        }
    } )

let S = Consonant(id: .S,
    blendStart: [.C, .H, .K, .L, .M, .N, .P, .Q, .T, .W],
    blendInto: [.C, .H, .K, .L, .M, .N, .P, .Q, .S, .T, .W],
    blendFinal: [.A, .C, .E, .H, .K, .M, .O, .P, .S, .T, .Y],
    canPlural: false,
    endBias: 3,
    dipthong: false,
    liquidBlend: false )

let T = Consonant( id: .T,
    blendStart: [.H, .R, .W, .Y],
    blendInto: [.C, .H, .R, .T, .Z],
    blendFinal: [.A, .E, .H, .O, .T, .Y, .Z],
    canPlural: true,
    endBias: 3,
    dipthong: false,
    liquidBlend: true )

let V = Consonant( id: .V,
    blendStart: [.Y],
    blendInto: [],
    blendFinal: [.E, .Y],
    canPlural: false,
    endBias: 0,
    dipthong: false,
    liquidBlend: false )

let W = Consonant( id: .W,
    blendStart: [.H, .R],
    blendInto: [.D, .K, .L, .N, .S, .T],
    blendFinal: [.L, .N, .Y],
    canPlural: true,
    endBias: 3,
    dipthong: true,
    liquidBlend: false )

let X = Consonant( id: .X,
    blendStart: [],
    blendInto: [.T],
    blendFinal: [.I, .T, .Y],
    canPlural: false,
    endBias: 2,
    dipthong: false,
    liquidBlend: true,
    initial: { return [] },
    interior: { (phonemes:PhoneticElementArray) -> [Letter] in return [.A, .C, .E, .I, .P, .T] },
    verifyEnd: nil )

let Y = Consonant( id: .Y,
    blendStart: [],
    blendInto: [.L, .M, .N, .P, .R, .S],    // these are also covered in YBlend, are they needed here?
    blendFinal: [.L, .O, .M, .R],   // VINYL, YOYO, ANTONYM, MARTYR
    canPlural: false,
    endBias: 3,
    dipthong: true,
    liquidBlend: true )

let Z = Consonant( id: .Z,
    blendStart: [.Y],    // ZYGOTE
    blendInto: [.Z],
    blendFinal: [.A, .E, .O, .Y, .Z],
    canPlural: false,
    endBias: 1,
    dipthong: false,
    liquidBlend: true )

let consonantMap: [Letter:Consonant] = [.B:B, .C:C, .D:D, .F:F, .G:G, .H:H, .J:J, .K:K, .L:L, .M:M, .N:N,
     .P:P, .Q:Q, .R:R, .S:S, .T:T, .V:V, .W:W, .X:X, .Y:Y, .Z:Z]


