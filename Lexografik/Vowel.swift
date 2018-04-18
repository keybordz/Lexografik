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
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Final B enders: BLAB, CRAB, DRAB, FLAB, GRAB, REHAB, SCAB, SLAB, SQUAB, STAB, SWAB
            if pea.matchesSet(["BL", "CR", "DR", "FL", "GR", "REH", "SC", "SL", "SQU", "ST", "SW"]) {
                followers += [.B]
            }
                
            // Only C ender so far is LILAC
            if pea.matchesString("LIL", matchFull: true) {
                followers += [.C]
            }
                
            // Only K ender is FLAK
            if pea.matchesString("FL", matchFull: true) {
                followers += [.K]
            }
        }
        return followers
    })

let E = Vowel( id: .E,
    blendStart: [.A, .E, .I, .O, .U],
    blendInto: [.A, .E, .I, .U],
    
    // Final consonant enders: BRED, COMPEL, THEM, THEN, STEP, WATER, SLEW, FLEX, THEY
    finalConsonants: [.D, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
    endBias: 3,
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Only allow final F for CLEF
            if pea.matchesString("CL", matchFull: true) {
                followers += [.F]
            }
            
            // Only allow final G for DREG
            if pea.matchesString("DR", matchFull: true) {
                followers += [.G]
            }
                
            // Only allow final K for TREK
            if pea.matchesString("TR", matchFull: true) {
                followers += [.K]
            }
        }
        
        return followers
    })

let I = Vowel( id: .I,
    blendStart: [.O],
    blendInto: [.A, .E, .O],
    
    // Final consonant enders: GENERIC, SQUID, UNTIL, MAXIM, SPIN, STIR, SPLIT, REMIX
    finalConsonants: [.C, .D, .L, .M, .N, .P, .S, .T, .X],
    endBias: 0,
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Final B enders: CRIB, DRIB
            if pea.matchesSet(["CR", "DR"]) {
                followers += [.B]
            }
            
            // Final G enders: BRIG, PRIG, SPRIG, STIG, SWIG, TRIG, TWIG
            if pea.matchesSet(["BR", "PR", "SPR", "ST", "SW", "TR", "TW"]) {
                followers += [.G]
            }
            
            // Only allow final R for EMIR, NADIR, STIR
            if pea.matchesSet(["EM", "NAD", "ST"]) {
                followers += [.R]
            }
        }

        return followers
    })

let O = Vowel( id: .O,
    blendStart: [.A, .O, .I, .U],
    blendInto: [.A, .E, .O, .I, .U],
    
    // Final consonant enders: TROD, GROG, CAROL, PROM, VALOR, TROT, BROW, BOOMBOX, DECOY
    finalConsonants: [.D, .G, .L, .M, .N, .R, .S, .T, .W, .X, .Y],
    endBias: 1,
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Final B enders: BLOB, GLOB, SLOB
            if pea.matchesSet(["BL", "GL", "SL"]) {
                followers += [.B]
            }
            
            // Only allow final C for CHOC, CROC
            if pea.matchesSet(["CH", "CR"]) {
                followers += [.C]
            }
                
            // Only allow final K for AMOK
            if pea.matchesString("AM", matchFull: true) {
                followers += [.K]
            }
            
            // Only allow final P for CHOP, CLOP, CROP, DROP, FLOP, PLOP, PROP, SHOP, SLOP, STOP
            if pea.matchesSet(["CH", "CL", "CR", "DR", "FL", "PL", "PR", "SH", "SL", "ST"]) {
                followers += [.P]
            }
        }
        return followers
    })

let U = Vowel( id: .U,
    blendStart: [],
    blendInto: [.A, .E, .I, .O],
    
    // Final consonant enders: DRUB, THUD, PLUG, MOGUL, DRUM, STUN, BLUR, GLUT, FLUX
    finalConsonants: [.B, .D, .G, .L, .M, .N, .P, .R, .S, .T, .X],
    endBias: 0,
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        
       // Allow blending into U only for VACUUM
        if pos == .positionMIDDLE && pea.matchesString("VACU", matchFull: false) {
            return [.U]
        }
        else {
            return []
        }
    })

let vowelMap: [Letter:Vowel] = [.A:A, .E:E, .I:I, .O:O, .U:U]
