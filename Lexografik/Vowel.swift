//
//  Vowel.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class Vowel: LexicalLetter {
    
    init(id: Letter, blendStart: [Letter], blendInto: [Letter], finalConsonants: [Letter], endBias: Int,
                  dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?) {
        
        super.init(id: id,
                   blendStart: blendStart + allConsonants,
                   blendInto: blendInto + allConsonants,
                   blendFinal: blendInto + finalConsonants,
                   canPlural: true, endBias: endBias)
    
        self.instNextLetters = dynFollowers
        
//        self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in
//            let lastElement = phonemes.lastElement()
//
//            // No short words with a triple consonant followed by a vowel, i.e. CHRO
//            if phonemes.numLetters() == lastElement!.numLetters && lastElement! is ConsonantBlend {
//                return false
//            }
//
//            else if endBias == 0 {
//                return false
//            }
//
//            else {
//                return true
//            }
//        }

        self.verifyEndOfWord = { (elements:PhoneticElementArray) -> Bool in return true }
        self.verifyPlural = { (elements:PhoneticElementArray) -> Bool in return true }
    }
    
}

// VOWELS
let A = Vowel( id: .A,
    blendStart: [.A, .E, .I, .O, .U],
    blendInto: [.I, .O, .U],
    
    // Final consonant enders: GRAD, FLAG, FLAK, MORAL, TRAM, BRAN, SCRAP, AJAR, FLAT, FLAW, RELAX, TRAY
    finalConsonants: [.D, .G, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
    endBias: 1,
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        if pos == .positionLAST {
            
            // Final B enders: BLAB, CRAB, DRAB, FLAB, GRAB, REHAB, SCAB, SLAB, SQUAB
            if pea.matchesSet(["BL", "CR", "DR", "FL", "GR", "REH", "SC", "SL", "SQU"]) {
                return [.B]
            }
                
            // Only C ender so far is LILAC
            else if pea.matchesString("LIL", matchFull: true) {
                return [.C]
            }
                
            // Only K ender is FLAK
            else if pea.matchesString("FL", matchFull: true) {
                return [.K]
            }
                
            else {
                return []
            }
        }
        else {
            return []
        }
    })

let E = Vowel( id: .E,
    blendStart: [.A, .E, .I, .O, .U],
    blendInto: [.A, .E, .I, .U],
    
    // Final consonant enders: BRED, COMPEL, THEM, THEN, STEP, WATER, SLEW, FLEX, THEY
    finalConsonants: [.D, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
    endBias: 3,
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        
        if pos == .positionLAST {
            
            // Only allow final F for CLEF
            if pea.matchesString("CL", matchFull: true) {
                return [.F]
            }
            
            // Only allow final G for DREG
            if pea.matchesString("DR", matchFull: true) {
                return [.G]
            }
                
            // Only allow final K for TREK
            else if pea.matchesString("TR", matchFull: true) {
                return [.K]
            }
            
            else {
                return []
            }
        }
        else {
            return []
        }
    })

let I = Vowel( id: .I,
    blendStart: [.O],
    blendInto: [.A, .E, .O],
    
    // Final consonant enders: DRIB, GENERIC, SQUID, TRIG, UNTIL, MAXIM, SPIN, STIR, SPLIT, REMIX
    finalConsonants: [.B, .C, .D, .L, .M, .N, .P, .S, .T, .X],
    endBias: 0,
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        
        // Only allow final R for EMIR, NADIR, STIR
        if pos == .positionLAST && pea.matchesSet(["EM", "NAD", "ST"]) {
            return [.R]
        }
            
        // Final G enders: BRIG, PRIG, SPRIG, STIG, SWIG, TWIG
        else if pea.matchesSet(["BR", "PR", "SPR", "ST", "SW", "TW"]) {
            return [.G]
        }
        
        else {
            return []
        }
    })

let O = Vowel( id: .O,
    blendStart: [.A, .O, .I, .U],
    blendInto: [.A, .E, .O, .I, .U],
    
    // Final consonant enders: BLOB, CROC, TROD, GROG, CAROL, PROM, TROT, BROW, BOOMBOX, DECOY
    finalConsonants: [.D, .G, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
    endBias: 1,
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        if pos == .positionLAST {
            
            // Only allow final B if preceded by L (BLOB, GLOB, SLOB)
            if pea.lastElement()!.id == "L" {
                return [.B]
            }
            
            // Only allow final C for CROC
            else if pea.matchesString("CR", matchFull: true) {
                return [.C]
            }
                
            // Only allow final K for AMOK
            if pea.matchesString("AM", matchFull: true) {
                return [.K]
            }

            else {
                return []
            }
        }
            
        else {
            return []
        }
    })

let U = Vowel( id: .U,
    blendStart: [],
    blendInto: [.A, .E, .I, .O],    // blends into U only for VACUUM
    
    // Final consonant enders: DRUB, THUD, PLUG, MOGUL, DRUM, STUN, BLUR, GLUT, FLUX
    finalConsonants: [.B, .D, .G, .L, .M, .N, .P, .R, .S, .T, .X],
    endBias: 0,
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        if pos == .positionLAST {
            return []
        }
        else {
            return []
        }
    })

let vowelMap: [Letter:Vowel] = [.A:A, .E:E, .I:I, .O:O, .U:U]
