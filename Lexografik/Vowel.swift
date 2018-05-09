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
    let defFinal: [Letter]
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
        var lastFollowers = defFinal
        if dynFollowers != nil {
            lastFollowers += self.dynFollowers!(pea, .positionLAST)
        }
        return lastFollowers
    }
    
    func verifyFinal(pea: PhoneticElementArray) -> Bool {
        return true;
    }
    
    init(id: Letter, blendStart: [Letter], blendInto: [Letter], defFinal: [Letter],
         followerTable: [String:[Letter]],
         dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?) {
        
        self.blendStart = blendStart
        self.blendInto = blendInto
        self.defFinal = defFinal
        self.followerTable = followerTable
        
        super.init(first: id, second: nil, third: nil,
                   canStart: true, canEnd: true, canPlural: true,
                   dynFollowers: dynFollowers)

        self.verifyEndOfWord = { (elements:PhoneticElementArray) -> Bool in return true }
        self.verifyPlural = { (elements:PhoneticElementArray) -> Bool in return true }
    }
}

// VOWELS
let A = Vowel(id: .A,
              blendStart: [.A, .E, .I, .O, .U],
              blendInto: [.I, .O, .U],
    
              // Final consonant enders: GRAD, FLAG, FLAK, MORAL, TRAM, BRAN, SCRAP, AJAR, FLAT, FLAW, RELAX, TRAY
              defFinal: [.D, .G, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
              followerTable: [
                "GH":[.S],                              // GHASTLY
                "GN":[.R, .S, .T, .W],                  // GNARLY, GNASH, GNAT, GNAW
                "RH":[.P],                              // RHAPSODY
                "SM":[.C, .L, .R, .S, .T],              // SMACK, SMALL, SMART, SMASH, SMATTER
                "SN":[.C, .F, .G, .I, .P, .R, .T],      // SNACK, SNAFU, SNAG, SNAIL, SNAP, SNARE, SNATCH
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
                    
                    // All AO enders here: CACAO
                    if pea.matchesString("CAC", matchFull: true) {
                        followers += [.O]
                    }
                }

                return followers
            })

let E = Vowel( id: .E,
    blendStart: [.A, .E, .I, .O, .U],
    blendInto: [.A, .E, .I, .O, .U],
    
    // Final consonant enders: BRED, COMPEL, THEM, THEN, STEP, WATER, SLEW, FLEX, THEY
    defFinal: [.E, .D, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
    followerTable: [
        "AH":[.E],              // AHEM
        "RH":[.A],              // RHEA
        "SM":[.L],              // SMELL/SMELTER
        "SN":[.A, .E],          // SNEAK, SNEER
        "Y": [.A, .G, .L, .N, .O, .P, .S, .T, .W]],     // YEAR, YEGG, YELL, YENS, YEOMAN, YEPS, YESTERDAY, YETI, YEWS
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = pea.lastElement()
        
        if pos == .positionLAST {
            
            // Final EA words: ASEA, FLEA, PLEA, RHEA, UREA
            if pea.matchesSet(["AS", "FL", "PL", "RH", "UR"]) {
                followers += [.A]
            }
            
            // Final EE words...rying to cast a wide net here with many possibilities:
            // APOGEE, OVERSEE, FLEE, CAREFREE, AGREE & PEDIGREE, KNEE, THEE, TREE & THREE
            if lastElement!.id == "G" || lastElement!.id == "P" || lastElement!.id == "S" ||
                lastElement!.id == "FL" || lastElement!.id == "FR" || lastElement!.id == "GR" ||
                lastElement!.id == "KN" || lastElement!.id == "TH" || lastElement!.id == "TR" || lastElement!.id == "THR" {
                followers += [.E]
            }
            
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
    defFinal: [.E, .C, .D, .L, .M, .N, .O, .P, .S, .T, .X],
    followerTable: [
        "SM":[.L, .R, .T],              // SMILE, SMIRK, SMITE/SMITH
        "SN":[.C, .D, .F, .P, .T],      // SNICKER, SNIDE, SNIFF, SNIP, SNIT(CH)
        "Y": [.E, .N, .P]],             // YIELD, YING, YIPS
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = pea.lastElement()
        let penElement = pea.nextToLastElement()
        
        if pos == .positionLAST {
            
            // Trying to cover typical IA enders: MEDIA/ENCYCLOPEDIA, MANIA/CRANIA, GLIA/GANGLIA, ILIA, ZINNIA, CRITERIA
            if (lastElement!.id == "D" && penElement!.id == "E") ||
                (lastElement!.id == "N" && penElement!.id == "A") ||
                 lastElement!.id == "GL" || lastElement!.id == "L" ||
                 lastElement!.id == "NN" || lastElement!.id == "R" {
                followers += [.A]
            }

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

        return followers
    })

let O = Vowel( id: .O,
    blendStart: [.A, .O, .I, .U],
    blendInto: [.A, .E, .O, .I, .U],
    
    // Final consonant enders: TROD, GROG, CAROL, PROM, VALOR, TROT, BROW, BOOMBOX, DECOY
    defFinal: [.D, .L, .M, .N, .R, .S, .T, .W, .X, .Y],
    followerTable: [
        "AH":[.Y],                              // AHOY
        "GH":[.S],                              // GHOST
        "GN":[.C, .M],                          // GNOCCHI, GNOME
        "PS":[.R],                              // PSORIASIS
        "SM":[.C, .G, .K, .O, .T],              // SMOCK, SMOG, SMOKE, SMOOTH, SMOTE/SMOTHER
        "SN":[.B, .O, .R, .T, .U, .W],          // SNOB, SNOOT, SNORE, SNOT, SNOUT, SNOW
        "Y": [.D, .G, .L, .N, .U, .W, .Y]],     // YODEL, YOGA, YOLK, YON, YOUR, YOWS, YOYO
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = pea.lastElement()
        
        if pos == .positionLAST {
            
            // Words ending in OA: BOA, STOA, COCOA
            if pea.matchesSet(["B", "ST", "COC"]) {
                followers += [.A]
            }
            
            // Final B enders: BLOB, GLOB, SLOB, SNOB
            if pea.matchesSet(["BL", "GL", "SL", "SN"]) {
                followers += [.B]
            }
            
            // Only allow final C for BLOC, CHOC, CROC
            if pea.matchesSet(["BL", "CH", "CR"]) {
                followers += [.C]
            }
            
            // Final E for all words ending in HOE, NOE, SHOE, TOE and also FLOE, SLOE
            // 3 letter OE enders: DOE, FOE, JOE, NOE, ROE, WOE (POE? ZOE?)
            if lastElement!.id == "H" || lastElement!.id == "SH" || lastElement!.id == "N" || lastElement!.id == "T" ||
                pea.matchesSet(["FL", "SL"]) {
                followers += [.E]
            }
            
            // Final G goes for any word ending in LOG (CATALOG) or NOG (EGGNOG)
            // plus AGOG, BLOG, CLOG, FLOG, FROG, GROG, PROG, SLOG, SMOG
            if lastElement!.id == "L" || lastElement!.id == "N" ||
                pea.matchesSet(["AG", "BL", "CL", "FL", "FR", "GR", "PR", "SL", "SM"]) {
                followers += [.G]
            }
                
            // Only allow final K for AMOK
            if pea.matchesString("AM", matchFull: true) {
                followers += [.K]
            }
            
            // Final OO words: SHOO, IGLOO, TABOO, VOODOO
            if pea.matchesSet(["SH", "IGL", "TAB", "VOOD"]) {
                followers += [.O]
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
    defFinal: [.E, .B, .D, .G, .L, .M, .N, .P, .S, .T, .X],
    followerTable: [
        "GN":[.S],                      // GNUS
        "SM":[.G, .T],                  // SMUG, SMUT
        "SN":[.B, .C, .F, .G],          // SNUB, SNUCK, SNUFF, SNUG
        "Y": [.C, .L, .M, .P, .R]],     // YUCCA, YULE, YUMMY, YUPS, YURT
    
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = pea.lastElement()

        if pos == .positionLAST {
            
            // Final I for ENNUI
            if pea.matchesString("ENN", matchFull: true) {
                followers += [.I]
            }
            
            // Final UR restricted words: BLUR, INCUR, SLUR
            if pea.matchesSet(["BL", "INC", "SL"]) {
                followers += [.R]
            }
        }
        
        // Allow blending into U only for VACUUM
        if pea.matchesString("VACU", matchFull: false) {
            followers += [.M]
        }
        
        return followers
    })

let vowelMap: [Letter:Vowel] = [.A:A, .E:E, .I:I, .O:O, .U:U]
