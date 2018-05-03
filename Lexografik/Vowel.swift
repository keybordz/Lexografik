//
//  Vowel.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class Vowel: LexicalLetter, PhoneticFollowers {
    let blendStart: [Letter]
    let blendInto: [Letter]
    let finalCons: [Letter]
    let followerTable: [String:[Letter]]
    
    func initialFollowers(nRemain: Int) -> [Letter] {
        let initFollowers = blendStart + allConsonants
        return initFollowers
    }
    
    func secondFollowers(pea: PhoneticElementArray, nRemain: Int) -> [Letter] {
        let firstElement = pea.firstElement()               // Should only be one element
        
        if let secondFollowers = followerTable[firstElement!.id] {
            return secondFollowers
        }
        else {
            return []
        }
    }
    
    func midFollowers(pea: PhoneticElementArray, nRemain: Int) -> [Letter] {
        var midFollowers = blendInto + allConsonants
        if dynFollowers != nil {
            midFollowers += self.dynFollowers!(pea, .positionMIDDLE)
        }
        return midFollowers
    }
    
    func lastFollowers(pea: PhoneticElementArray) -> [Letter] {
        var lastFollowers = blendInto + finalCons
        if dynFollowers != nil {
            lastFollowers += self.dynFollowers!(pea, .positionLAST)
        }
        return lastFollowers
    }
    
    func verifyFinal(pea: PhoneticElementArray) -> Bool {
        return true;
    }
    
    init(id: Letter, blendStart: [Letter], blendInto: [Letter], finalConsonants: [Letter],
         followerTable: [String:[Letter]],
         dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?) {
        
        self.blendStart = blendStart
        self.blendInto = blendInto
        self.finalCons = finalConsonants
        self.followerTable = followerTable
        
        super.init(first: id, second: nil, third: nil,
                   canStart: true, canEnd: true, canPlural: true,
                   dynFollowers: dynFollowers)
    
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
let A = Vowel(id: .A,
              blendStart: [.A, .E, .I, .O, .U],
              blendInto: [.I, .O, .U],
    
              // Final consonant enders: GRAD, FLAG, FLAK, MORAL, TRAM, BRAN, SCRAP, AJAR, FLAT, FLAW, RELAX, TRAY
              finalConsonants: [.D, .G, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
              followerTable: [
                "GH":[.S],
                "GN":[.R, .S, .T, .W],                  // GNARLY, GNASH, GNAT, GNAW
                "RH":[.P],
                "Y": [.C, .K, .M, .N, .P, .R, .W]],     // YACHT, YAKS, YAMS, YANG, YAPS, YARD, YAWN
              dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                var followers: [Letter] = []
                    
                if pos == .positionLAST {
                        
                // Final B enders: BLAB, CRAB, DRAB, FLAB, GRAB, REHAB, SCAB, SLAB, SQUAB, STAB, SWAB
                if pea.matchesSet(["BL", "CR", "DR", "FL", "GR", "REH", "SC", "SL", "SQU", "ST", "SW"]) {
                    followers += [.B]
                }
                        
                // C enders: COGNAC, LILAC, TARMAC, SUMAC
                if pea.matchesSet(["COGN", "LIL", "SUM", "TARM"]) {
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
    blendInto: [.A, .E, .I, .O, .U],
    
    // Final consonant enders: BRED, COMPEL, THEM, THEN, STEP, WATER, SLEW, FLEX, THEY
    finalConsonants: [.D, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
    followerTable: [
        "AH":[.E],
        "RH":[.A],
        "Y": [.A, .G, .L, .N, .O, .P, .S, .T, .W]],     // YEAR, YEGG, YELL, YENS, YEOMAN, YEPS, YESTERDAY, YETI, YEWS
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
    followerTable: [
        "Y": [.E, .N, .P]],     // YIELD, YING, YIPS
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Final B enders: CRIB, DRIB, SAHIB
            if pea.matchesSet(["CR", "DR", "SAH"]) {
                followers += [.B]
            }
            
            // Final G enders: BRIG, PRIG, SPRIG, STIG, SWIG, TRIG, TWIG
            if pea.matchesSet(["BR", "PR", "SPR", "ST", "SW", "TR", "TW"]) {
                followers += [.G]
            }
            
            // Only allow final R for EMIR, NADIR, STIR, TAPIR
            if pea.matchesSet(["EM", "NAD", "ST", "TAP"]) {
                followers += [.R]
            }
        }
        
        // To make gerunds following double vowels work (FREEING, WOOING, etc.)
        else if pos != .positionFIRST && (pea.lastElement()!.id == "EE" || pea.lastElement()!.id == "OO") {
            followers += [.N]
        }

        return followers
    })

let O = Vowel( id: .O,
    blendStart: [.A, .O, .I, .U],
    blendInto: [.A, .E, .O, .I, .U],
    
    // Final consonant enders: TROD, GROG, CAROL, PROM, VALOR, TROT, BROW, BOOMBOX, DECOY
    finalConsonants: [.D, .G, .L, .M, .N, .R, .S, .T, .W, .X, .Y],
    followerTable: [
        "AH":[.Y],
        "GH":[.S],
        "GN":[.C, .M],
        "Y": [.D, .G, .L, .N, .U, .W, .Y]],     // YODEL, YOGA, YOLK, YON, YOUR, YOWS, YOYO
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Final B enders: BLOB, GLOB, SLOB, SNOB
            if pea.matchesSet(["BL", "GL", "SL", "SN"]) {
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
    finalConsonants: [.B, .D, .G, .L, .M, .N, .P, .S, .T, .X],
    followerTable: [
        "GN":[.S],                      // GNUS
        "Y": [.C, .L, .M, .P, .R]],     // YUCCA, YULE, YUMMY, YUPS, YURT
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        
       // Allow blending into U only for VACUUM
        if pos == .positionMIDDLE && pea.matchesString("VACU", matchFull: false) {
            return [.U]
        }
            
        // Final R restricted words: BLUR, CUR, FUR, SLUR
        else if pos == .positionLAST && pea.matchesSet(["BL", "C", "F", "SL"]) {
            return [.R]
        }
            
        // Final I for ENNUI
        else if pos == .positionLAST && pea.matchesString("ENN", matchFull: true) {
            return [.I]
        }
            
        else {
            return []
        }
    })

let vowelMap: [Letter:Vowel] = [.A:A, .E:E, .I:I, .O:O, .U:U]
