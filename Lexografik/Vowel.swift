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
    }
}

// VOWELS
let A = Vowel(id: .A,
              blendStart: allVowels,
              blendInto: [.I, .O, .U],
    
              // Final consonant enders: GRAD, FLAG, FLAK, MORAL, TRAM, BRAN, SCRAP, AJAR, FLAT, FLAW, RELAX, TRAY
              defFinal: [.D, .G, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
              followerTable: [
                "B": allLetters - [.E, .H, .J, .O, .Q, .Z],
                "BL": [.B, .C, .D, .H, .M, .N, .R, .S, .T, .Z],
                                                        // BLAB, BLACK, BLADE, BLAME, BLAND/BLANCHE, BLARE, BLAST, BLATHER, BLAZE
                "BR": [.C, .D, .G, .I, .K, .N, .S, .T, .V, .W, .Y, .Z],
                "C": [.B, .C, .D, .F, .G, .I, .J, .K, .L, .M, .N, .P, .R, .S, .T, .U, .V, .W, .Y],
                "CH": [.D, .F, .I, .L, .M, .N, .O, .P, .R, .S, .T, .V, .W],
                "CL": [.C, .D, .I, .M, .N, .P, .R, .S, .T, .V, .W, .Y],
                                                        // CLACK, CLAD, CLAIM, CLAM, CLAN, CLAP, CLASP, CLAVE, CLAW
                "CR": [.B, .C, .D, .F, .G, .I, .M, .N, .P, .S, .T, .W, .Z],
                "D": allLetters - [.A, .E, .J, .K],
                "DR": [.B, .C, .F, .G, .I, .K, .M, .N, .P, .S, .T, .W, .Y],
                "F": allLetters - [.A, .E, .H, .J, .K, .O, .Q, .P],
                "FL": [.B, .C, .G, .I, .K, .M, .N, .P, .R, .S, .T, .U, .V, .W, .X, .Y],
                "FR": [.C, .G, .I, .M, .N, .T, .Y],
                "G": allLetters - [.A, .C, .E, .J, .K, .Q, .X],
                "GH":[.S],                              // GHASTLY
                "GL": [.C, .D, .M, .N, .R, .Z],
                "GR": [.B, .C, .D, .F, .I, .M, .N, .P, .S, .T, .V, .Y, .Z],
                "GN":[.R, .S, .T, .W],                  // GNARL, GNASH, GNAT, GNAW
                "H": [.B, .C, .D, .F, .G, .I, .J, .L, .M, .N, .P, .R, .S, .T, .U, .V, .W, .Y, .Z],
                "J": [.B, .C, .D, .G, .I, .M, .N, .R, .U, .V, .W, .Y, .Z],
                "KN": [.C, .P, .V],                     // KNACK, KNAPSACK, KNAVE
                "L": [.B, .C, .D, .G, .I, .K, .M, .N, .P, .Q, .R, .S, .T, .U, .V, .W, .X, .Y, .Z],
                "M": [.C, .D, .F, .G, .H, .I, .L, .M, .N, .P, .R, .S, .T, .U, .W, .X, .Y, .Z],
                "N": [.B, .D, .F, .G, .I, .K, .M, .N, .P, .S, .T, .U, .V, .Y],
                                                        // NABS, NADIR, NAGS, NAIL, NAKED, NAME, NANO, NAPS, NASTY, NAUTICAL, NAVY, NAYS
                "P": [.C, .D, .G, .I, .L, .M, .N, .P, .R, .S, .T, .U, .V, .W, .Y],
                "PH": [.L, .N, .R, .S],                  // PHALANX, PHANTOM, PHARISEE, PHASE
                "QU": [.C, .D, .F, .G, .I, .K, .L, .N, .R, .S, .V, .Y],
                                                        // QUACK, QUAD, QUAFF, QUAGMIRE, QUAIL, QUAKE, QUALITY,
                                                        // QUANT(ITY), QUARTER/QUARRY, QUASH, QUAVER, QUAY
                "R": [.B, .C, .D, .F, .G, .I, .J, .K, .L, .M, .N, .P, .R, .S, .T, .U, .V, .W, .Y, .Z],
                "RH": [.P],                              // RHAPSODY
                "S": [.B, .C, .D, .F, .G, .H, .I, .K, .L, .M, .N, .P, .R, .S, .T, .U, .V, .W, .X, .Y],
                "SH": [.B, .C, .D, .F, .G, .H, .K, .L, .M, .N, .P, .R, .S, .T, .V, .W, .Y],
                "SC": [.B, .D, .F, .L, .M, .N, .R, .T],   // SCAB, SCAD, SCAFFOLD, SCALAWAG, SCAM, SCAN, SCAR(F/V), SCAT
                "SM": [.C, .L, .R, .S, .T],              // SMACK, SMALL, SMART, SMASH, SMATTER
                "SN": [.C, .F, .G, .I, .P, .R, .T],      // SNACK, SNAFU, SNAG, SNAIL, SNAP, SNARE, SNATCH
                "SQU": [.B, .D, .L, .N, .R, .S, .T, .W], // SQUABBLE, SQUAD, SQUALOR, SQUANDER, SQUARE, SQUASH, SQUAT, SQUAWK
                "T": [.B, .C, .D, .F, .G, .I, .K, .L, .M, .N, .O, .P, .R, .S, .T, .U, .W, .X],
                "V": [.C, .G, .I, .L, .M, .N, .P, .R, .S, .T, .U],
                "W": [.B, .D, .F, .G, .I, .K, .L, .M, .N, .R, .S, .T, .X, .Y],
                "WH": [.C, .M, .R, .T],
                "Y": [.C, .K, .M, .N, .P, .R, .W],      // YACHT, YAKS, YAMS, YANG, YAPS, YARD, YAWN
                "Z": [.G, .N]],
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
                    
                    // AE enders: ALGAE, MINUTAE
                    if pea.matchesSet(["ALG", "MINUT"]) {
                        followers += [.E]
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
    blendStart: allVowels,
    blendInto: allVowels,
    
    // Final consonant enders: BRED, COMPEL, THEM, THEN, STEP, WATER, SLEW, FLEX, THEY
    defFinal: [.D, .L, .M, .N, .P, .R, .S, .T, .W, .Y],
    followerTable: [
        "AH":[.E],                                      // AHEM
        "B": allLetters - [.K, .O, .Q, .U, .W, .X, .Z],
        "BL":[.A, .D, .E, .N, .S, .W],                  // BLEAK, BLED, BLEED, BLEND, BLESS/T, BLEW
        "CL":[.A, .F, .N, .R],                          // CLEAT, CLEF, CLENCH, CLERK
        "D": allLetters - [.H, .K, .Y, .Z],
        "F": [.A, .C, .D, .E, .I, .L, .M, .N, .R, .S, .T, .U, .W, .Y, .Z],
        "H": [.A, .C, .D, .E, .F, .I, .L, .M, .N, .R, .S, .T, .U, .W, .Y],
        "J": [.A, .E, .L, .R, .S, .T, .W],
        "KN":[.A, .E, .L, .W],                          // KNEAD, KNEE, KNELL, KNEW
        "N":[.A, .C, .E, .G, .M, .O, .P, .R, .S, .T, .U, .V, .W, .X],
                                        // NEAT, NECK, NEED, NEGATE, NEMATODE, NEON, NEPHEW, NERD, NEST, NETS, NEURAL, NEVER, NEWS
        "PH":[.N],                                      // PHENTONOL,
        "QU":[.A, .E, .L, .R, .S, .U],                  // QUEASY, QUEEN, QUELL, QUERY, QUEST(ION), QUEUE
        "RH":[.A],                                      // RHEA
        "SC":[.N],                                      // SCENE/T
        "SH":[.A, .D, .E, .I, .L, .R],                  // SHEAR, SHED, SHEET, SHEIK, SHELF/SHELL, SHERBERT
        "SM":[.G, .L],                                  // SMEGMA, SMELL/SMELTER
        "SN":[.A, .E],                                  // SNEAK, SNEER
        "SQU":[.A, .E],                                 // SQUEAL, SQUEEZE
        "WH": [.A, .E, .N, .R, .T, .Y],                 // WHEAT, WHEEL, WHEN/CE, WHERE, WHET, WHEY
        "Y": [.A, .G, .L, .N, .O, .P, .S, .T, .W]],     // YEAR, YEGG, YELL, YENS, YEOMAN, YEPS, YESTERDAY, YETI, YEWS
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = pea.lastElement()
        
        if pos == .positionLAST {
            
            // Final EA words: AREA, ASEA, FLEA, IDEA, PLEA, RHEA, UREA
            if pea.matchesSet(["AR", "AS", "FL", "ID", "PL", "RH", "UR"]) {
                followers += [.A]
            }
            
            // Final EE words...trying to cast a wide net here with many possibilities:
            if lastElement!.id == "G" ||                               // OGEE, APOGEE, PERIGEE
                lastElement!.id == "P" || lastElement!.id == "S" ||    // RUPEE, OVERSEE
                lastElement!.id == "KN" || lastElement!.id == "TH" ||  // KNEE, THEE
                lastElement!.id.contains("R") ||                       // FREE, AGREE/PEDIGREE, TREE, THREE, PUREE
                lastElement!.id.contains("L") {                        // GLEE, FLEE, ALEE
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
            
            // Approve EO ending for RODEO, VIDEO
            if pea.matchesSet(["ROD", "VID"]) {
                followers += [.O]
            }
            
            // X follower: need words like ANNEX, FLEX, CODEX, INDEX, ROLODEX, VORTEX, COMPLEX
            if pea.matchesSet(["ANN", "FL"]) || lastElement!.id == "D" || lastElement!.id == "RT" || lastElement!.id == "PL" {
                followers += [.X]
            }
        }
        return followers
    })

let I = Vowel( id: .I,
    blendStart: [.O],
    blendInto: [.A, .E, .O],
    
    // Final consonant enders: GENERIC, SQUID, UNTIL, MAXIM, SPIN, STIR, SPLIT, REMIX
    defFinal: [.C, .D, .L, .M, .N, .O, .P, .S, .T],
    followerTable: [
        "B": allLetters - [.F, .H, .I, .K, .M, .O, .P, .Q, .U, .W, .X, .Y, .Z],
        "BL":[.N, .P, .S, .T],              // BLIND/K, BLIP, BLISS, BLITHE
        "CL":[.C, .F, .N, .P, .Q, .T],      // CLICK, CLIFF, CLINCH, CLIP, CLIQUE
        "D": allLetters - [.H, .I, .J, .K, .Q, .U, .W, .Y],
        "F": [.A, .B, .C, .D, .E, .F, .G, .L, .M, .N, .O, .R, .S, .T, .V, .X, .Z],
        "J": [.B, .F, .G, .T, .V],          // JIBS, JIFFY, JIGS, JITNEY, JIVE
        "KN": [.C, .F, .S, .T, .V],         // KNICKER, KNIFE, KNISH, KNIT, KNIVES
        "N": [.B, .C, .E, .G, .L, .M, .N, .P, .T],
                                            // NIBS, NICHE, NIECE, NIGH, NILS, NIMBLE, NINE, NIPS, NITS
        "QU": [.B, .C, .D, .E, .F, .L, .N, .P, .R, .T, .V],
                                            // QUIBBLE, QUICK, QUID, QUIET, QUIFF, QUILL, QUINT, QUIP, QUIRE, QUIT, QUIVER
        "RH": [.N],                         // RHINO
        "SC": [.N, .O],                     // SCINTILLATE, SCION
        "SH": [.E, .L, .M, .N, .P, .R, .T, .V],  // SHIES, SHILL, SHIM, SHIN(E), SHIP, SHIRK, SHITE, SHIVER,
        "SM": [.L, .R, .T],                 // SMILE, SMIRK, SMITE/SMITH
        "SN": [.C, .D, .F, .P, .T],         // SNICKER, SNIDE, SNIFF, SNIP, SNIT(CH)
        "SQU": [.D, .R],                    // SQUID, SQUIRE/SQUIRM/SQUIRT
        "WH": [.F, .G, .L, .M, .N, .P, .R, .S, .T, .Z],     // WHIFF, WHIG, WHILE, WHIM, WHINE, WHIP, WHIRR, WHIST, WHIT, WHIZ
        "Y": [.E, .N, .P]],                 // YIELD, YING, YIPS
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = pea.lastElement()
        let penElement = pea.nextToLastElement()
        
        if pos == .positionLAST {
            
            // Trying to cover typical IA enders
            if (lastElement!.id == "D" && penElement!.id == "E") ||     // MEDIA, ENCYCLOPEDIA
                (lastElement!.id == "N" && penElement!.id == "A") ||    // MANIA, CRANIA
                (lastElement!.id == "M" && penElement!.id == "E") ||    // ANEMIA
                lastElement!.id == "GL" || lastElement!.id == "L" ||  // GLIA, GANGLIA, ILIA
                lastElement!.id == "NN" || lastElement!.id == "R" || lastElement!.id == "TR" ||   // ZINNIA, CRITERIA, ATRIA
                pea.matchesSet(["MAF", "TIB"]) {           // MAFIA, TIBIA
                followers += [.A]
            }

            // Final B enders: CRIB, DRIB, GLIB, SAHIB
            if pea.matchesSet(["CR", "DR", "GL", "SAH"]) {
                followers += [.B]
            }
            
            // Final IE words: AERIE, CADDIE, GENIE, STYMIE
            if pea.matchesSet(["AER", "CADD", "GEN", "STYM"]) {
                followers += [.E]
            }
            
            // Final G enders: BRIG, PRIG, SPRIG, STIG, SWIG, TRIG, TWIG, and any RIG ender (UNRIG)
            if pea.matchesSet(["BR", "PR", "SPR", "ST", "SW", "TR", "TW"]) ||
                lastElement!.id == "R" {
                followers += [.G]
            }
            
            // Only allow final R for EMIR, NADIR, STIR, TAPIR, ASTIR
            if pea.matchesSet(["EM", "NAD", "ST", "TAP", "AST"]) {
                followers += [.R]
            }
            
            // X followers: AFFIX, REMIX
            if lastElement!.id == "F" || lastElement!.id == "FF" || lastElement!.id == "M" {
                followers += [.X]
            }
            
            // Z followers: FRIZ
            if pea.matchesSet(["FR"]) {
                followers += [.Z]
            }
        }
        
        // I followers for SKI and TAXI gerunds
        if pea.matchesSet(["SK", "TAX"]) {
            followers += [.I]
        }

        return followers
    })

let O = Vowel( id: .O,
    blendStart: allVowels,
    blendInto: allVowels,
    
    // Final consonant enders: TROD, GROG, CAROL, PROM, VALOR, TROT, BROW, DECOY
    defFinal: [.D, .L, .M, .N, .R, .S, .T, .W, .Y],
    followerTable: [
        "AH":[.Y],                                  // AHOY
        "AW":[.K, .L],                              // AWOKE, AWOL
        "B": allLetters - [.E, .H, .J, .K, .Q, .Z],
        "BL":[.A, .B, .C, .G, .N, .O, .T, .V, .W],  // BLOAT, BLOB, BLOCK, BLOG, BLOND, BLOOD, BLOT, BLOVIATE, BLOW
        "CL":[.A, .B, .C, .D, .G, .N, .P, .S, .T, .U, .V, .W, .Y],
                                                // CLOAK, CLOBBER, CLOCK, CLOD, CLOG, CLONE, CLOP, CLOSE, CLOT, CLOUT, CLOWN, CLOY
        "D": allLetters - [.A, .H, .K, .Q],
        "F": [.A, .B, .C, .D, .E, .G, .I, .L, .N, .O, .P, .R, .S, .U, .W, .X],
        "GH":[.S],                              // GHOST
        "GN":[.C, .M],                          // GNOCCHI, GNOME
        "J": [.B, .C, .E, .G, .I, .K, .L, .S, .T, .U, .V, .W, .Y],
        "KN": [.B, .C, .L, .T, .W],             // KNOB, KNOCK, KNOLL, KNOT, KNOW
        "N":[.B, .C, .D, .E, .I, .M, .N, .O, .S, .T, .U, .V, .W, .Z],
                                                // NOBS, NOCTURNE, NODS, NOES, NOMINAL, NONE, NOON, NOUN, NOVEL, NOWS, NOZZLE
        "PH":[.E, .N, .O, .S],                  // PHOENIX, PHONE, PHOOEY, PHOSPHORUS
        "PS":[.R],                              // PSORIASIS
        "QU":[.T],                              // QUOTE
        "RH":[.M],                              // RHOMBUS/OID
        "SC":[.F, .L, .N, .O, .P, .R, .U, .W],  // SCOFF, SCOLL, SCONE, SCOOT, SCOPE, SCORE, SCOUT, SCOWL
        "SH":[.A, .B, .C, .D, .E, .N, .O, .P, .R, .T, .U, .V, .W],
                                                // SHOAL, SHOBBY, SHOCK, SHOD, SHOE, SHONE, SHOOT, SHOP, SHORE, SHOT, SHOUT, SHOVE, SHOW
        "SM":[.C, .G, .K, .O, .T],              // SMOCK, SMOG, SMOKE, SMOOTH, SMOTE/SMOTHER
        "SN":[.B, .O, .R, .T, .U, .W],          // SNOB, SNOOT, SNORE, SNOT, SNOUT, SNOW
        "THR":[.B, .E, .N, .U, .W],             // THROB, THROE, THRONE, THROUGH, THROW
        "WH": [.A, .L, .M, .R, .S],             // WHOA, WHOLE, WHOM, WHORE/WHORL, WHOSE
        "Y": [.D, .G, .L, .N, .R, .U, .W, .Y]], // YODEL, YOGA, YOLK, YON, YORE, YOUR, YOWS, YOYO
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
            
            // Final E for all words ending in HOE, NOE, SHOE, TOE and also FLOE, SLOE, OBOE
            // 3 letter OE enders: DOE, FOE, JOE, NOE, ROE, WOE (POE? ZOE?)
            if lastElement!.id == "H" || lastElement!.id == "SH" || lastElement!.id == "N" || lastElement!.id == "T" ||
                pea.matchesSet(["FL", "OB", "SL"]) {
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
            
            // Final P after O vowel for CHOP, CLOP, CROP, DROP, FLOP, PLOP, PROP, SHOP, SLOP, STOP, BISHOP, TABLETOP
            if lastElement!.id == "SH" || lastElement!.id == "ST" || lastElement!.id == "T" ||
                lastElement!.lastLetter().isLiquid() {
                followers += [.P]
            }
            
            // Only approve X follower for BOX words
            if lastElement!.id.contains("B") || lastElement!.id == "T" {
                followers += [.X]
            }
        }
        return followers
    })

let U = Vowel( id: .U,
    blendStart: [],
    blendInto: [.A, .E, .I, .O],
    
    // Final consonant enders: DRUB, THUD, PLUG, MOGUL, DRUM, STUN, BLUR, GLUT
    defFinal: [.E, .B, .D, .G, .L, .M, .N, .P, .S, .T],
    followerTable: [
        "B": allLetters - [.A, .E, .H, .J, .K, .O, .P, .Q, .V, .W],
        "BL": [.B, .E, .F, .I, .N, .R, .S],  // BLUBBER, BLUE, BLUFF, BLUISH, BLUNDER/BLUNT, BLUR, BLUSTER
        "CL": [.B, .C, .E, .M, .N, .S],      // CLUB, CLUCK, CLUE, CLUMSY, CLUNK, CLUSTER
        "D": allLetters - [.H, .I, .J, .Q, .U, .X, .Y, .Z],
        "F": [.C, .D, .E, .G, .L, .M, .N, .R, .S, .T, .Z],
        "H": [.B, .C, .D, .E, .F, .G, .L, .M, .N, .R, .S, .T, .U],
        "J": [.D, .G, .I, .N, .R, .S, .T, .V, .X],
        "KN": [.C],                     // KNUCKLES
        "N": [.B, .C, .D, .K, .L, .M, .N, .P, .R, .T],
                                        // NUBS, NUCLEAR, NUDE, NUKE, NULL, NUMBER, NUNS, NUPTIAL, NURSE, NUTS
        "GN":[.S],                      // GNUS
        "RH":[.M],                      // RHUMBA
        "SC":[.D, .F, .M, .R],          // SCUD, SCUFF, SCUM, SCURVY
        "SH":[.C, .N, .T],              // SHUCK, SHUN, SHUT
        "SM":[.G, .T],                  // SMUG, SMUT
        "SN":[.B, .C, .F, .G],          // SNUB, SNUCK, SNUFF, SNUG
        "WH":[.M, .R],                  // WHUMP, WHURL
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
            
            // Final X for FLUX
            if pea.matchesSet(["FL"]) {
                followers += [.X]
            }
        }
        
        // Allow blending into U only for VACUUM
        if pea.matchesString("VACU", matchFull: false) {
            followers += [.M]
        }
        
        return followers
    })

let vowelMap: [Letter:Vowel] = [.A:A, .E:E, .I:I, .O:O, .U:U]
