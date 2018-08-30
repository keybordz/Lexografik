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
    
    func secondFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter] {
        let firstElement = syll.firstElement()               // Should only be one element
        var secondFollowers: [Letter] = []
        
        if nRemain > 2 {
            secondFollowers += blendInto
        }
        
        if let tableFollowers = followerTable[firstElement!.id] {
            secondFollowers += tableFollowers
        }
        return secondFollowers
    }
    
    func midFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter] {
        var midFollowers = blendInto + allConsonants
        if dynFollowers != nil {
            midFollowers += self.dynFollowers!(syll, nRemain)
        }
        return midFollowers
    }
    
    func lastFollowers(syll: SyllabicArray) -> [Letter] {
        var lastFollowers = defFinal
        if dynFollowers != nil {
            lastFollowers += self.dynFollowers!(syll, 2)
        }
        return lastFollowers
    }
    
    init(id: Letter, blendStart: [Letter], blendInto: [Letter], defFinal: [Letter],
         followerTable: [String:[Letter]],
         dynFollowers: ((SyllabicArray, Int) -> [Letter])?) {
        
        self.blendStart = blendStart
        self.blendInto = blendInto
        self.defFinal = defFinal
        self.followerTable = followerTable
        
        super.init(first: id, second: nil, third: nil,
                   canStart: true, canEnd: true, canPlural: true,
                   dynFollowers: dynFollowers)
    }
}

// VOWELS
let A = Vowel(id: .A,
              blendStart: allVowels,
              blendInto: [.I, .O, .U],
    
              // Final consonant enders: GRAD, FLAG, FLAK, MORAL, TRAM, BRAN, SCRAP, AJAR, FLAT, FLAW, RELAX, TRAY
              defFinal: [.D, .G, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y],
              followerTable: [
                "AW":[.R, .S, .Y],                      // AWARE, AWASH, AWAY
                "B": [.A, .B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .W, .X, .Y],  // **BAAS
                "BL": [.B, .C, .D, .H, .M, .N, .R, .S, .T, .Z], // BLAB, BLACK, BLADE, BLAME,
                                                                // BLAND/BLANCHE, BLARE, BLAST, BLATHER, BLAZE
                "BR": [.C, .D, .G, .K, .N, .S, .T, .V, .W, .Y, .Z],
                "C": [.B, .C, .D, .F, .G, .J, .K, .L, .M, .N, .P, .R, .S, .T, .V, .W, .Y],
                "CH": [.D, .F, .L, .M, .N, .P, .R, .S, .T, .V, .W],
                "CL": [.C, .D, .M, .N, .P, .R, .S, .T, .V, .W, .Y],
                                                        // CLACK, CLAD, CLAIM, CLAM, CLAN, CLAP, CLASP, CLAVE, CLAW
                "CR": [.B, .C, .D, .F, .G, .M, .N, .P, .S, .T, .V, .W, .Z],
                "D": allConsonants - [.J, .K],
                "DR": [.B, .C, .F, .G, .K, .M, .N, .P, .S, .T, .W, .Y],
                "DW": [.R],                             // DWARF/DWARVES
                "F": allConsonants - [.H, .J, .K, .Q, .P],
                "FL": [.B, .C, .G, .K, .M, .N, .P, .R, .S, .T, .V, .W, .X, .Y],
                "FR": [.C, .G, .M, .N, .T, .Y],
                "G": allConsonants - [.C, .J, .K, .Q, .X],
                "GH":[.S],                              // GHASTLY
                "GL": [.C, .D, .M, .N, .R, .Z],
                "GR": [.B, .C, .D, .F, .M, .N, .P, .S, .T, .V, .Y, .Z],
                "GN":[.R, .S, .T, .W],                  // GNARL, GNASH, GNAT, GNAW
                "H": [.B, .C, .D, .F, .G, .J, .K, .L, .M, .N, .P, .R, .S, .T, .V, .W, .Y, .Z],
                "J": [.B, .C, .D, .G, .M, .N, .R, .V, .W, .Y, .Z],
                "K": [.L, .N, .R, .T, .Y],              // KALE, KANT, KARAT, KATYDID, KAYS
                "KL": [.X],                             // KLAXON
                "KN": [.C, .P, .V],                     // KNACK, KNAPSACK, KNAVE
                "L": [.B, .C, .D, .G, .K, .M, .N, .P, .Q, .R, .S, .T, .V, .W, .X, .Y, .Z],
                "M": [.C, .D, .F, .G, .H, .K, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y, .Z],
                "N": [.B, .D, .F, .G, .K, .M, .N, .P, .S, .T, .V, .Y], // NABS, NADIR, NAGS, NAKED, NAME,
                                                        // NANO, NAPS, NASTY, NAVY, NAYS
                "P": [.C, .D, .G, .L, .M, .N, .P, .R, .S, .T, .V, .W, .Y],
                "PH": [.L, .N, .R, .S],                 // PHALANX, PHANTOM, PHARISEE, PHASE
                "PHR": [.S],                            // PHRASE
                "PL": [.C, .N, .Q, .T, .Y],             // PLACE, PLAN, PLAQUE, PLATFORM, PLAY
                "PR": [.M, .N, .T, .W, .Y],             // PRAM, PRANK, PRATFALL, PRAWN, PRAY
                "QU": [.C, .D, .F, .G, .K, .L, .N, .R, .S, .V, .Y], // QUACK, QUAD, QUAFF, QUAGMIRE, QUAKE, QUALITY,
                                                        // QUANT(ITY), QUARTER/QUARRY, QUASH, QUAVER, QUAY
                "R": [.B, .C, .D, .F, .G, .J, .K, .L, .M, .N, .P, .R, .S, .T, .V, .W, .Y, .Z],
                "RH": [.P],                             // RHAPSODY
                "S": [.B, .C, .D, .F, .G, .H, .K, .L, .M, .N, .P, .R, .S, .T, .V, .W, .X, .Y],
                "SC": [.B, .D, .F, .G, .L, .M, .N, .P, .R, .T],  // SCAB, SCAD, SCAFFOLD, SCALE/SCALD,
                                                          // SCAM, SCAN, SCARF, SCAPULA, SCAT
                "SCR": [.G, .M, .P, .W],                  // SCRAG, SCRAM, SCRAPE, SCRAWL
                "SH": [.B, .C, .D, .F, .G, .H, .K, .L, .M, .N, .P, .R, .S, .T, .V, .W, .Y],
                "SK": [.N, .T],                           // (A)SKANCE/SKANK, SKATE
                "SL": [.B, .C, .D, .G, .K, .M, .N, .P, .Q, .T, .V, .Y], // SLAB, SLACK, SLADE, SLAG, SLAKE, SLAM,
                                                                        // SLANDER, SLAQUE, SLAT, SLAVE, SLAY
                "SM": [.C, .L, .R, .S, .T],              // SMACK, SMALL, SMART, SMASH, SMATTER
                "SN": [.C, .F, .G, .P, .R, .T],          // SNACK, SNAFU, SNAG, SNAP, SNARE, SNATCH
                "SP": [.C, .D, .K, .M, .N, .R, .S, .T, .Y], // SPACE, SPADE, SPAKE, SPAM, SPAN, SPAR, SPASTIC, SPAT, SPAY
                "SPL": [.T, .Y],                         // SPLAT, SPLAY
                "SPR": [.T, .W, .Y],                     // SPRAT, SPRAWL, SPRAY
                "SQU": [.B, .D, .L, .N, .R, .S, .T, .W], // SQUABBLE, SQUAD, SQUALOR, SQUANDER, SQUARE, SQUASH, SQUAT, SQUAWK
                "ST": [.B, .C, .D, .F, .G, .K, .L, .M, .N, .R, .S, .T, .V, .Y],
                "STR": [.D, .F, .N, .P, .T, .W, .Y],     // STRAD, STRAFE, STRAND, STRAP, STRATA, STRAW, STRAY
                "SW":[.B, .D, .G, .L, .M, .N, .P, .R, .S, .T, .Y],
                                                         // SWAB, SWADDLE, SWAG, SWALLOW, SWAM, SWAN, SWAP, SWARM, SWAT
                "T": [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .W, .X],
                "TH": [.N, .T, .W],                      // THAN, THAT, THAW
                "THR": [.S],                             // THRASH
                "TR": [.C, .D, .F, .M, .N, .P, .S, .T, .V, .W, .Y], // TRACK, TRADE, TRAFFIC, TRAL, TRAM, TRANS, TRAP,
                                                                    // TRASH, TRATTORIA, TRAVEL, TRAWL, TRAY
                "TS": [.R],                              // TSAR
                "TW":[.D],                               // TWADDLE
                "V": [.C, .G, .L, .M, .N, .P, .R, .S, .T],
                "W": [.B, .D, .F, .G, .K, .L, .M, .N, .R, .S, .T, .X, .Y],
                "WH": [.C, .L, .M, .R, .T],              // WHACK, WHALE, WHAM, WHARTON, WHAT
                "WR": [.C, .N, .P, .T],                  // WRACK, WRANGLE, WRAP, WRATH
                "Y": [.C, .K, .M, .N, .P, .R, .W],       // YACHT, YAKS, YAMS, YANG, YAPS, YARD, YAWN
                "Z": [.G, .N]],
              dynFollowers: {(syll: SyllabicArray, nRemain: Int) -> [Letter] in
                var followers: [Letter] = []
                    
                if nRemain == 2 {
                        
                    // Final B enders: BLAB, CRAB, DRAB, FLAB, GRAB, REHAB, SCAB, SLAB, SQUAB, STAB, SWAB
                    if syll.matchesSet(["BL", "CR", "DR", "FL", "GR", "REH", "SC", "SL", "SQU", "ST", "SW"]) {
                        followers += [.B]
                    }
                    
                    // C enders: COGNAC, LILAC, TARMAC, SUMAC
                    if syll.matchesSet(["COGN", "LIL", "SUM", "TARM"]) {
                        followers += [.C]
                    }
                    
                    // AE enders: ALGAE, MINUTAE
                    if syll.matchesSet(["ALG", "MINUT"]) {
                        followers += [.E]
                    }
                    
                    // AH enders: BLAH, SHAH
                    if syll.matchesSet(["BL", "SH"]) {
                        followers += [.H]
                    }
                    
                    // Only K ender is FLAK
                    if syll.matchesString("FL", matchFull: true) {
                        followers += [.K]
                    }
                    
                    // All AO enders here: CACAO
                    if syll.matchesString("CAC", matchFull: true) {
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
        "AH":[.M],                                      // AHEM
        "AY":[.S],                                      // AYES
        "B": allConsonants - [.K, .W, .X],
        "BL":[.D, .N, .S, .W],                  // BLEAK, BLED, BLEED, BLEND, BLESS/T, BLEW
        "BR":[.D, .T, .V, .W],                  // BREAK, BRED, BREED, BRETHREN, BREVE, BREW
        "C": [.D, .L, .N, .R],                  // CEASE, CEDAR, CEILING, CELL, CENT, CERTIFY
        "CH":[.C, .D, .Q, .S, .V, .W],          // CHEAT, CHECK, CHEDDAR, CHEESE, CHEQUE, CHEST, CHEVRON, CHEW
        "CL":[.F, .N, .R, .V],                      // CLEAT, CLEF, CLENCH, CLERK, CLEVER
        "CR":[.D, .P, .S, .T, .V, .W],          // CREAK, CREDIT, CREEP, CREPT, CREST, CRETIN, CREVICE, CREW
        "D": allConsonants - [.H, .K, .Y, .Z],
        "DR":[.C, .D, .G, .S, .W],                  // DREAM, DRECK, DREDGE, DREG, DRESS, DREW
        "DW": [.L],                                 // DWEEB, DWELL
        "EW":[.R, .S],
        "F": [.C, .D, .L, .M, .N, .R, .S, .T, .W, .Y, .Z],
        "FL":[.C, .D, .S, .W, .X],              // FLEA, FLECK, FLED, FLEE, FLESH, FLEW, FLEX
        "FR":[.C, .N, .T],                      // FREAK, FRECKLE, FREE, FRENETIC, FRET
        "G": [.C, .L, .M, .N, .R, .S, .T],
        "GL":[.N],
        "GR":[.W, .Y],
        "H": [.C, .D, .F, .L, .M, .N, .R, .S, .W, .X, .Y],
        "J": [.L, .R, .S, .T, .W],
        "K": [.G, .M, .N, .R, .S, .T, .V, .Y],
        "KN":[.L, .W],                          // KNEAD, KNEE, KNELL, KNEW
        // no KL, KR
        "L": [.C, .D, .F, .G, .N, .P, .R, .S, .T, .V, .W, .X],
        "M": [.C, .D, .G, .L, .M, .N, .R, .S, .T, .W],
        "N":[.C, .G, .M, .P, .R, .S, .T, .V, .W, .X],
                                        // NEAT, NECK, NEED, NEGATE, NEMATODE, NEON, NEPHEW, NERD, NEST, NETS, NEURAL, NEVER, NEWS
        "OW":[.D, .S],                                  // OWED, OWES
        "P": [.B, .C, .D, .G, .L, .M, .N, .P, .R, .S, .T, .W, .Z],
        "PL": [.B, .D, .N],                 // PLEAT, PLEB, PLEDGE, PLEE, PLEIN, PLENTY
        "PH":[.N],                                      // PHENOM
        "PR":[.D, .F, .P, .S, .T, .V, .Y],      // PREACH, PREDICATE, PREEN, PREFER, PREP, PRESS, PREVALENT, PREY
        "QU":[.L, .R, .S],                  // QUEASY, QUEEN, QUELL, QUERY, QUEST(ION), QUEUE
        "R": allConsonants,
        "RH":[.A],                                      // RHEA
        "S": [.C, .D, .G, .L, .M, .N, .P, .Q, .R, .S, .T, .V, .W, .X],
        "SC":[.N, .P],                                  // SCENE/T, (SU)SCEPTIBLE
        "SCH":[.D, .M, .W],                             // SCHEDULE, SCHEME, (E)SCHEW
        "SCR":[.W],                             // SCREAM, SCREECH, SCREW
        "SH":[.D, .L, .R, .W],              // SHEAR, SHED, SHEET, SHEIK, SHELF/SHELL, SHERBERT, SHEW
        "SK":[.P, .W],                          // SKEET, SKEIN, SKEPTIC, SKEW
        "SL":[.D, .N, .P, .W],                  // SLED, SLEET, SLEIGH, SLENDER, SLEPT, SLEW
        "SM":[.G, .L],                                  // SMEGMA, SMELL/SMELTER
        "SN":[.E],                                  // SNEAK, SNEER
        "SP":[.C, .D, .L, .N, .W],              // SPEAK, SPECK, SPED, SPEED, SPELL, SPENT, SPEW
        "SPH":[.R],                                     // SPHERE
        "SPL":[.N],                                 // SPLEEN, SPLENDID
        // no SPR
        "SQU":[.L],                             // SQUEAL, SQUEEZE, SQUELCH
        "ST":[.M, .N, .P, .R, .T, .V, .W],  // STEAK, STEED, STEIN, STEM, STENT, STEP, STERN, STET, STEVEDORE, STEW
        "STR":[.N, .P, .S, .W],                 // STREAM, STREET, STRENGTH, STREP, STRESS, STREWN
        "SW":[.L, .P, .R],                      // SWEAT, SWEET, SWELL, SWEPT, SWERVE
        "T":[.C, .F, .L, .M, .N, .P, .R, .S, .T, .X],
                                                        // TEAS, TECH, TEEM, TEFLON, TELL, TEMPLE, TENT, TEPEE, TERSE, TEST, TETHER
        "TH":[.M, .N, .R, .S, .W, .Y],          // THEE, THEIR, THEM, THEN, THERE, THESE, THEW, THEY
        "THR":[.N],                             // THREAT, THREE, THRENODY
        "TR":[.B, .K, .L, .P, .S, .Y],          // TREAD, TREBLE, TRELLIS, TREPIDATE, TRESTLE, TREY
        "TS":[.T],                                      // TSETSE
        "TW":[.L, .N],                                  // TWELVE, (BE)TWEEN
        "V":[.C, .G, .H, .L, .N, .R, .S, .T, .X],  // VEAL, VECTOR, VEEP, VEGETATE, VEHEMENT, VEIL,
                                                               // VELD, VENTURE, VERTICAL, VEST, VETS, VEXES
        "W":[.B, .C, .D, .L, .N, .P, .R, .S, .T],
        "WH":[.N, .R, .T, .Y],                  // WHEAT, WHEEL, WHEN/CE, WHERE, WHET, WHEY
        "WR":[.C, .N, .S],                              // WRECK, WREN, WRESTLE
        "X":[.N],                                       // XENOPHOBE
        "Y":[.G, .L, .N, .P, .S, .T, .W],       // YEAR, YEGG, YELL, YENS, YEOMAN, YEPS, YESTERDAY, YETI, YEWS
        "Z":[.B, .N, .R, .S]],                          // ZEBRA, ZEN, ZERO, ZEST
    dynFollowers: {(syll: SyllabicArray, nRemain: Int) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = syll.lastElement()
        
        if nRemain == 2 {
            
            // Final EA words: AREA, ASEA, FLEA, IDEA, PLEA, RHEA, UREA or any PEAs (like CHICKPEAS)
            if syll.matchesSet(["AR", "AS", "FL", "ID", "PL", "RH", "UR"]) || lastElement!.id == "P" {
                followers += [.A]
            }
            
            // Final EE words...trying to cast a wide net here with many possibilities:
            if lastElement!.id == "G" || lastElement!.id == "GR" ||    // OGEE, APOGEE, PERIGEE, DEGREE, PEDIGREE
                lastElement!.id == "P" || lastElement!.id == "S" ||    // RUPEE, OVERSEE
                lastElement!.id == "KN" || lastElement!.id == "TH" ||  // KNEE, THEE
                lastElement!.id == "Y" || lastElement!.id == "SS" ||   // PAYEE, EMPLOYEE, ADDRESSEE
                lastElement!.id.contains("R") ||                       // FREE, AGREE/PEDIGREE, TREE, THREE, PUREE
                lastElement!.id.contains("L") {                        // GLEE, FLEE, ALEE
                followers += [.E]
            }
            
            // Only allow final F for CLEF
            if syll.matchesString("CL", matchFull: true) {
                followers += [.F]
            }
            
            // Only allow final G for DREG
            if syll.matchesString("DR", matchFull: true) {
                followers += [.G]
            }
                
            // Only allow final K for TREK
            if syll.matchesString("TR", matchFull: true) {
                followers += [.K]
            }
            
            // Approve EO ending for RODEO, VIDEO
            if syll.matchesSet(["ROD", "VID"]) {
                followers += [.O]
            }
            
            // X follower: need words like ANNEX, FLEX, CODEX, INDEX, ROLODEX, VORTEX, COMPLEX
            if syll.matchesSet(["ANN", "FL"]) || lastElement!.id == "D" || lastElement!.id == "RT" || lastElement!.id == "PL" {
                followers += [.X]
            }
        }
        return followers
    })

let I = Vowel( id: .I,
    blendStart: [.O],
    blendInto: [.A, .E, .O],
    
    // Final consonant enders: GENERIC, SQUID, UNTIL, MAXIM, SPIN, STIR, SPLIT, REMIX
    defFinal: [.C, .D, .L, .M, .N, .P, .S, .T],
    followerTable: [
        "AW": [.N],                                     // AWING
        "B": allConsonants - [.F, .H, .M, .P, .Q, .W, .X, .Y, .Z],
        "BL":[.N, .P, .S, .T],                          // BLIND/K, BLIP, BLISS, BLITHE
        "BR":[.B, .C, .D, .G, .L, .M, .N, .S, .T],      // BRIBE, BRICK, BRID(G)E, BRIG(HT), BRILL, BRIM, BRING, BRIS, BRIT
        "C": [.D, .G, .L, .P, .R, .S, .T, .V],          // CIDER, CIGAR, CIPHER, CIRCUIT/CIRCLE, CISTERN, CITY, CIVIL
        "CH":[.C, .D, .F, .L, .M, .N, .P, .R, .T, .V],  // CHICK, CHIDE, CHIFFON, CHILD/CHILL, CHIMNEY,
                                                        // CHIN, CHIP, CHIRP, CHIT, CHIVES
        "CL":[.C, .F, .N, .P, .Q, .T],                  // CLICK, CLIENT, CLIFF, CLINCH, CLIP, CLIQUE
        "CR":[.B, .C, .M, .N, .P, .S, .T],              // CRIB, CRICK(ET), CRIME, CRINGE, CRIPPLE, CRIST, CRITERIA
        "D": allConsonants - [.H, .J, .K, .Q, .W, .Y],
        "DR": [.B, .F, .L, .P, .V, .Z],                 // DRIB, DRIFT, DRILL, DRIP, DRIVEL, DRIZZLE
        "DW": [.N],                                     // DWINDLE
        "F": [.B, .C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .V, .X, .Z],
        "FL": [.C, .G, .M, .N, .R, .P, .T],             // FLICK, FLIGHT, FLIMSEY, FLING, FLIP, FLIRT, FLIT
        "FR": [.L, .M, .N, .S, .T, .Z],                 // FRILL, FRIM, FRINGE, FRISK, FRITTER, FRIZZY
        "G": [.B, .D, .F, .G, .L, .N, .P, .R, .S, .T, .V],
        "GL":[.B, .D, .M, .N, .T],
        "GR":[.D, .F, .L, .M, .N, .P, .S, .T, .Z],
        "H": [.C, .D, .K, .L, .N, .P, .R, .S, .T, .V],
                                                        // HICK, HIDE, HIKE, HILL, HIND, HIPS, HIRSUTE, HISS, HITS, HIVES
        "J": [.B, .F, .G, .M, .N, .T, .V],              // JIBS, JIFFY, JIGS, JIMMY, JINX, JITNEY, JIVE
        "K": [.B, .C, .D, .L, .N, .P, .R, .S, .T, .W],
        // No KL
        "KN": [.C, .F, .S, .T, .V],                     // KNICKER, KNIFE, KNISH, KNIT, KNIVES
        "L": [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .Q, .S, .T, .V],
        "M": [.C, .D, .F, .G, .K, .L, .M, .N, .R, .S, .T, .X],
        "N": [.B, .C, .F, .G, .L, .M, .N, .P, .T],      // NIBS, NICHE, NIFTY, NIGH, NILS, NIMBLE, NINE, NIPS, NITS
        "OW":[.N],                                      // OWING
        "P":[.C, .D, .F, .G, .K, .L, .N, .P, .Q, .R, .S, .T, .X, .Z],
        "PL":[.N],                                      // PLINTHE
        "PR":[.C, .D, .G, .M, .N, .S, .V, .Z],          // PRICK, PRIDE, PRIG, PRIM, PRINT, PRISTINE, PRIVY, PRIZE
        "QU": [.B, .C, .D, .F, .L, .N, .P, .R, .T, .V], // QUIBBLE, QUICK, QUID, QUIFF, QUILL, QUINT,
                                                        // QUIP, QUIRE, QUIT, QUIVER
        "R": [.B, .C, .D, .F, .G, .L, .M, .N, .P, .S, .T, .V],
        "RH": [.N],                                     // RHINO
        "S": [.B, .C, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T, .X, .Z],
        "SC": [.N],                                     // SCINTILLATE
        "SCH":[.S],                                     // SCHISM
        "SCR":[.B, .M, .P],                             // SCRIBE, SCRIM(P), SCRIPT
        "SH": [.L, .M, .N, .P, .R, .T, .V],             // SHILL, SHIM, SHIN(E), SHIP, SHIRK, SHITE, SHIVER,
        "SHR":[.L, .M, .N],                             // SHRILL, SHRIMP, SHRINE
        "SK": [.D, .F, .L, .M, .N, .P, .R, .T, .V],     // SKID, SKIFF, SKIING, SKILL, SKIM, SKIN, SKIP, SKIRT, SKIT, SKIVVY
        "SL": [.C, .D, .G, .M, .N, .P, .T, .V],         // SLICE, SLID, SLIGHT, SLIM, SLING, SLIP, SLIT, SLIVER
        "SM": [.L, .R, .T],                             // SMILE, SMIRK, SMITE/SMITH
        "SN": [.C, .D, .F, .P, .T, .V],                 // SNICKER, SNIDE, SNIFF, SNIP, SNIT(CH), SNIVEL
        "SQU":[.D, .R],                                 // SQUID, SQUIRE/SQUIRM/SQUIRT
        "SP":[.C, .D, .F, .K, .L, .N, .R, .T],          // SPIC, SPIDER, SPIFFY, SPIKE, SPILL, SPIN, SPIRIT, SPIT
        "SPH":[.N],                                     // SPHINCTER/SPHINX
        "SPL":[.N, .T],                                 // SPLINTER, SPLIT
        "SPR":[.G, .N, .T],                             // SPRIG(HT), SPRING/T, SPRITE/TZ
        "ST":[.C, .F, .L, .M, .N, .P, .R, .T],          // STICK, STIFF, STILL/T, STIM, STINT, STIPPLE, STIR, STITCH
        "STR":[.C, .D, .F, .K, .N, .P, .V],             // STRICKEN, STRIDE, STRIFE, STRIKE, STRING, STRIP, STRIVE
        "SW":[.G, .L, .M, .N, .S, .V, .Z],              // SWIG, SWILL, SWIM, SWING, SWISH, SWIVEL, SWIZZLE
        "T": [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .T, .Z],
        "TH":[.C, .M, .N, .R, .S],                      // THICK, THIMBLE, THIN(K), THIRST, THIS
        "TR":[.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .S, .T, .V, .U, .X], // **TRIUNE
        "TW":[.D, .G, .N, .S, .Z],                      // TWIDDLE, TWIG, TWIN, TWIST, TWIZZLE
        "V": [.C, .D, .G, .L, .M, .N, .P, .R, .S, .T, .V, .X],
        "W": [.C, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T, .V],
        "WH":[.F, .G, .L, .M, .N, .P, .R, .S, .T, .Z],  // WHIFF, WHIG, WHILE, WHIM, WHINE, WHIP, WHIRR, WHIST, WHIT, WHIZ
        "WR":[.N, .S, .T],                              // WRING, WRIST, WRITHE
        "Y": [.N, .P],                                  // YING, YIPS
        "Z": [.G, .L, .N, .P, .T]],
    dynFollowers: {(syll: SyllabicArray, nRemain: Int) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = syll.lastElement()
        let penElement = syll.nextToLastElement()
        
        if nRemain == 2 {
            
            // Trying to cover typical IA enders
            if (lastElement!.id == "D" && penElement!.id == "E") ||     // MEDIA, ENCYCLOPEDIA
                (lastElement!.id == "N" && penElement!.id == "A") ||    // MANIA, CRANIA
                (lastElement!.id == "M" && penElement!.id == "E") ||    // ANEMIA
                lastElement!.id == "GL" || lastElement!.id == "L" ||  // GLIA, GANGLIA, ILIA
                lastElement!.id == "NN" || lastElement!.id == "R" || lastElement!.id == "TR" ||   // ZINNIA, CRITERIA, ATRIA
                syll.matchesSet(["MAF", "TIB"]) {           // MAFIA, TIBIA
                followers += [.A]
            }

            // Final B enders: CRIB, DRIB, GLIB, SAHIB
            if syll.matchesSet(["CR", "DR", "GL", "SAH"]) {
                followers += [.B]
            }
            
            // Final IE words: AERIE, CADDIE, GENIE, STYMIE, UNTIE
            if syll.matchesSet(["AER", "CADD", "GEN", "STYM", "UNT"]) {
                followers += [.E]
            }
            
            // Final G enders: BRIG, PRIG, SPRIG, STIG, SWIG, TRIG, TWIG, and any RIG ender (UNRIG)
            if syll.matchesSet(["BR", "PR", "SPR", "ST", "SW", "TR", "TW"]) ||
                lastElement!.id == "R" {
                followers += [.G]
            }
            
            // Final K for SPIK
            if syll.matchesString("SP", matchFull: true) {
                followers += [.K]
            }
            
            // Final IO workds: AUDIO, CRIO, RADIO, TRIO, OLIO/FOLIO, RATIO/PATIO
            if syll.matchesSet(["AUD", "CUR", "RAD", "TR"]) || lastElement!.id == "L" || lastElement!.id == "T" {
                followers += [.O]
            }
            
            // Only allow final R for EMIR, NADIR, STIR, TAPIR, ASTIR
            if syll.matchesSet(["EM", "NAD", "ST", "TAP", "AST"]) {
                followers += [.R]
            }
            
            // X followers: AFFIX, REMIX
            if lastElement!.id == "F" || lastElement!.id == "FF" || lastElement!.id == "M" {
                followers += [.X]
            }
            
            // Z followers: FRIZ
            if syll.matchesSet(["FR"]) {
                followers += [.Z]
            }
        }
        
        // I followers for SKI and TAXI gerunds
        if syll.matchesSet(["SK", "TAX"]) {
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
        "B": allConsonants - [.H, .J, .K, .Q, .Z],
        "BL":[.B, .C, .G, .N, .T, .V, .W],          // BLOB, BLOCK, BLOG, BLOND, BLOT, BLOVIATE, BLOW
        "BR":[.T, .W],                              // BROTHER, BROW
        "C": allConsonants,
        "CH":[.C, .K, .M, .P, .R, .W],              // CHOCK, CHOKE, CHOMP, CHOP, CHORTLE, CHOW
        "CHL":[.R],                                 // CHLORINE
        "CHR":[.M, .N],                             // CHROME, CHRONIC
        "CL":[.B, .C, .D, .G, .N, .P, .S, .T, .V, .W, .Y],
                                                    // CLOBBER, CLOCK, CLOD, CLOG, CLONE, CLOP, CLOSE, CLOT, CLOWN, CLOY
        "CR":[.C, .F, .N, .P, .Q, .T, .W],          // CROCK, CROFT, CRONY, CROP, CROQUET, CROTCH, CROW(N)
        "D": allConsonants - [.H, .K, .Q],
        "DR": [.L, .N, .P, .W],                     // DROLL, DRONE, DROP, DROWSY
        // no DW
        "F": [.B, .C, .D, .G, .L, .M, .N, .P, .R, .S, .W, .X],
        "FL": [.C, .G, .P, .R, .S, .T, .W],         // FLOCK, FLOG, FLOP, FLORAL, FLOSS, FLOT, FLOUT, FLOW
        "FR": [.C, .G, .M, .N, .S, .T, .W],         // FROCK, FROG, FROM, FRONT, FROST, FROT, FROW
        "G": [.B, .D, .F, .G, .L, .N, .P, .R, .S, .T, .V, .W, .Y],
        "GH":[.S],                                  // GHOST
        "GL":[.B, .M, .R, .S, .T, .V, .W],          // GLOB(E), GLOMB, GLORY, GLOSS, GLOTTAL, GLOVE, GLOW
        "GN":[.C, .M],                              // GNOCCHI, GNOME
        "GR":[.P, .S, .T, .V, .W],                  // GROPE, GROSS, GROTTO, GROVE, GROW
        "H": [.B, .C, .D, .G, .L, .M, .N, .P, .R, .S, .T, .V, .W],
        "J": [.B, .C, .G, .K, .L, .S, .T, .V, .W, .Y],
        "K": [.N, .P, .R, .S, .T, .W],
        "KN": [.B, .C, .L, .T, .W],                 // KNOB, KNOCK, KNOLL, KNOT, KNOW
        "KR":[.N],                                  // KRONER
        "L": [.B, .C, .D, .F, .G, .M, .N, .P, .R, .S, .T, .V, .W, .X],
        "M": [.B, .C, .D, .L, .M, .N, .P, .R, .S, .T, .V, .W, .X],
        "N":[.B, .C, .D, .M, .N, .R, .S, .T, .V, .W, .Z],
                                                    // NOBS, NOCTURNE, NODS, NOMINAL, NONE, NORM, NOVEL, NOWS, NOZZLE
        "P": [.C, .D, .G, .K, .L, .M, .N, .P, .R, .S, .T, .W, .X],
        "PH":[.N, .S],                              // PHONE, PHOSPHORUS
        "PL":[.D, .P, .T, .V, .W, .Y],              // PLOD, PLOP, PLOT, PLOVER, PLOW, PLOY
        "PR":[.B, .C, .D, .F, .G, .H, .J, .L, .M, .N, .P, .R, .S, .T, .V, .W, .X],
                                                    // PROBE, PROCEED, PROD, PROFESS, PROGRAM, PROHIBIT, PROJECT, PROLONG,
                                                    // PROM, PRONE, PROP, PRORATE, PROSE, PROTECT, PROVE, PROW, PROXY
        "PS":[.R],                                  // PSORIASIS
        "QU":[.R, .T],                              // QUORUM, QUOTE
        "R": [.B, .C, .D, .G, .L, .M, .N, .P, .Q, .S, .T, .V, .W, .Y],
        "RH":[.M, .S],                              // RHOMBUS/OID, RHOS
        "S": [.B, .C, .D, .F, .G, .L, .M, .N, .P, .R, .T, .W, .Y],
        "SC":[.F, .L, .N, .P, .R, .W],              // SCOFF, SCOLL, SCONE, SCOPE, SCORE, SCOW(L)
        // no SCH
        "SCR":[.L, .T],                             // SCROLL, SCROTUM
        "SH":[.B, .C, .D, .N, .P, .R, .T, .V, .W],  // SHOBBY, SHOCK, SHOD, SHONE, SHOP, SHORE, SHOT, SHOVE, SHOW
        "SHR":[.V],                                 // SHROVE
        // no SK
        "SL":[.B, .G, .P, .T, .W],                  // SLOB, SLOG, SLOPPY, SLOT, SLOW
        "SM":[.C, .G, .K, .L, .T],                  // SMOCK, SMOG, SMOKE, SMOLDER, SMOTE/SMOTHER
        "SN":[.B, .R, .T, .W],                      // SNOB, SNORE, SNOT, SNOW
        "SP":[.K, .N, .R, .T],                      // SPOKE, SPONSOR, SPORE, SPOT
        // no SPH, SPL
        "SPR":[.C],                                 // SPROCKET, SPROUT
        "SQU":[.N],                                 // SQUONK
        "ST":[.C, .D, .K, .L, .M, .N, .P, .R, .V, .W], // STOCK, STODGE, STOKE, STOLE, STOMA, STONE, STOP, STORK, STOVE, STOW
        "STR":[.L, .M, .N, .P, .V, .Y],             // STROLL, STROMBOLI, STRONG, STROP, STROVE, (DE)STROY
        "SW":[.B, .L, .P, .R, .T],                  // SWOB, SWOLLEN, SWOP, SWORE, SWOT
        "T": [.C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .W, .X, .Y], // TOCK, TODAY, TOFU, TOGS, TOKE, TOLD, TOMB,
                                                    // TONE, TOPS, TORUS, TOSH, TOTAL, TOWS, TOXIC, TOYS
        "TH":[.N, .R, .S],                          // THONG, THORN, THOSE
        "THR":[.B, .N, .W],                         // THROB, THROE, THRONE/G, THROW
        "TR":[.D, .G, .L, .M, .P, .T, .V, .W, .Y],  // TROD, TROGLODYTE, TROLL, TROMPTROPE, TROT, TROVE, TROWEL, TROY
        "TW":[.S],                                  // TWOS
        "V":[.C, .L, .M, .R, .T, .W, .Y],           // VOCAL, VOLE, VOMS, VORTEX, VOTE, VOWS, VOYAGE
        "W":[.B, .K, .L, .M, .N, .R, .V, .W],       // WOBBLE, WOKE, WOLF, WOMAN, WONDER, WORST, WOUND, WOVE, WOWS
        "WH":[.L, .M, .R, .S],                      // WHOLE, WHOM, WHORE/WHORL, WHOSE
        "WR":[.N, .T],                              // WRONG, WROTE
        "Y": [.D, .G, .L, .N, .R, .W, .Y],          // YODEL, YOGA, YOLK, YONDER, YORE, YOWS, YOYO
        "Z": [.N]],                                 // ZONE
    dynFollowers: {(syll: SyllabicArray, nRemain: Int) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = syll.lastElement()
        
        if nRemain == 2 {
            
            // Words ending in OA: BOA, COCOA, STOA, WHOA
            if syll.matchesSet(["B", "COC", "ST", "WH"]) {
                followers += [.A]
            }
            
            // Final B enders: BLOB, GLOB, SLOB, SNOB
            if syll.matchesSet(["BL", "GL", "SL", "SN", "SW"]) {
                followers += [.B]
            }
            
            // Only allow final C for BLOC, CHOC, CROC
            if syll.matchesSet(["BL", "CH", "CR"]) {
                followers += [.C]
            }
            
            // Final E for all words ending in HOE, NOE, SHOE, TOE and also FLOE, SLOE, OBOE, THROE
            // 3 letter OE enders: DOE, FOE, JOE, NOE, ROE, WOE (POE? ZOE?)
            if lastElement!.id == "H" || lastElement!.id == "SH" || lastElement!.id == "N" || lastElement!.id == "T" ||
                syll.matchesSet(["FL", "OB", "SL", "THR"]) {
                followers += [.E]
            }
            
            // Final G goes for any word ending in LOG (CATALOG) or NOG (EGGNOG)
            // plus AGOG, BLOG, CLOG, FLOG, FROG, GROG, PROG, SLOG, SMOG
            if lastElement!.id == "L" || lastElement!.id == "N" || lastElement!.id == "CL" ||
                syll.matchesSet(["AG", "BL", "FL", "FR", "GR", "PR", "SL", "SM"]) {
                followers += [.G]
            }
                
            // Only allow final K for AMOK
            if syll.matchesString("AM", matchFull: true) {
                followers += [.K]
            }
            
            // Final OO words: SHOO, IGLOO, TABOO, VOODOO
            if syll.matchesSet(["SH", "IGL", "TAB", "VOOD"]) {
                followers += [.O]
            }
            
            // Final P after O vowel for CHOP, CLOP, CROP, DROP, FLOP, PLOP, PROP, SHOP, SLOP, STOP, SWOP, BISHOP, TABLETOP
            if lastElement!.id == "CH" || lastElement!.id == "SH" || lastElement!.id == "ST" || lastElement!.id == "T" ||
                lastElement!.id == "SW" || lastElement!.lastLetter().isLiquid() {
                followers += [.P]
            }
            
            // Only allow final U for THOU
            if syll.matchesString("TH", matchFull: true) {
                followers += [.U]
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
        "B": [.B, .C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .X, .Y, .Z],
        "BL":[.B, .F, .N, .R, .S],              // BLUBBER, BLUFF, BLUNDER/BLUNT, BLUR, BLUSTER
        "BR":[.N, .S, .T],                      // BRUNT, BRUSH, BRUTE
        "C": [.B, .C, .D, .F, .L, .M, .N, .P, .R, .S, .T, .X],
        "CH":[.B, .C, .G, .M, .R, .T],          // CHUBBY, CHUCK, CHUG, CHUM, CHURN, CHUTE
        // no CHR
        "CL":[.B, .C, .M, .N, .S],              // CLUB, CLUCK, CLUMSY, CLUNK, CLUSTER
        "CR":[.D, .L, .M, .S],                  // CRUD, CRULLER, CRUMB, CRUSH/T
        "D": [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V],
        "DR":[.B, .G, .M, .N],                  // DRUB, DRUG, DRUID, DRUM, DRUNK
        // no DW
        "F": [.C, .D, .G, .L, .M, .N, .R, .S, .T, .Z],
        "FL":[.B, .F, .N, .S, .T, .X],          // FLUB, FLUFF, FLUNG, FLUSTER, FLUTE, FLUX
        "FR":[.M, .S],                          // FRUMP, FRUSTRATE
        "G": [.F, .L, .M, .N, .R, .S, .T, .Y, .Z],
        "GL":[.M, .T],                          // GLUE, GLUM, GLUT
        "GR":[.B, .D, .F, .M, .N],              // GRUB, GRUDGE, GRUEL, GRUFF, GRUMP, GRUNT
        "GN":[.S],                              // GNUS
        "H": [.B, .C, .D, .F, .G, .L, .M, .N, .R, .S, .T],
        "J": [.D, .G, .M, .N, .R, .S, .T, .V, .X],
        "K": [.N, .R, .S],
        "KN":[.C],                              // KNUCKLES
        "L": [.B, .C, .D, .G, .M, .N, .R, .S, .T, .X],
        "M": [.C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .Z],
        "N": [.B, .C, .D, .K, .L, .M, .N, .P, .R, .T, .Z], // NUBS, NUCLEAR, NUDE, NUKE, NULL, NUMBER,
                                                // NUNS, NUPTIAL, NURSE, NUTS, NUZZLE
        "P": [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .Z],
        // no PH, PHR
        "PL":[.C, .G, .M, .N, .T],              // PLUCK, PLUG, PLUM(B), PLUNDER, PLUTO
        "PR":[.D, .N],                          // PRUDE, PRUNE
        "R": [.B, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T],
        "RH":[.M],                              // RHUMBA
        "S": [.B, .C, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T],
        "SC":[.D, .F, .M, .R, .Z],              // SCUD, SCUFF, SCUM, SCURVY, SCUZZY
        "SCR":[.B, .M, .P, .T],                 // SCRUB, SCRUM, SCRUPLE, SCRUTINY
        // no SCH
        "SH":[.C, .N, .T],                      // SHUCK, SHUN, SHUT
        "SHR":[.B, .G, .N],                     // SHRUB, SHRUG, SHRUNK
        "SK":[.L, .N],                          // SKULL/K, SKUNK
        "SL":[.F, .G, .M, .R, .T],              // SLUFF, SLUG, SLUM, SLUR, SLUT
        "SM":[.G, .T],                          // SMUG, SMUT
        "SN":[.B, .C, .F, .G],                  // SNUB, SNUCK, SNUFF, SNUG
        "SP":[.D, .N, .R],                      // SPUD, SPUN(K), SPUR(N/T)
        // no SPH
        "SPL":[.R],                             // SPLURGE
        "SPR":[.N],                             // SPRUNG
        "ST":[.B, .C, .D, .F, .M, .N, .R],      // STUB, STUCK, STUD, STUFF, STUMP, STUN(G/K), STURDY
        "STR":[.C, .G, .M, .N, .T],             // STRUCK, STRUGGLE, STRUM(PET), STRUNG, STRUT
        "SW": [.N],                             // SWUNG
        "T": [.B, .C, .F, .G, .L, .M, .N, .P, .Q, .R, .S, .T, .X],
        "TH":[.D, .G, .M, .N, .S],              // THUD, THUG, THUMB/P, THUNK/THUNDER, THUS
        "THR":[.S],                             // THRUSH/T
        "TR":[.A, .C, .F, .L, .M, .N, .S, .T],  // TRUANT, TRUCK, TRUE, TRUING, TRULY, TRUFFLE,
                                                // TRUMPET, TRUNK, TRUSS/T, TRUTH
        // no TW
        "W": [.R],                              // WURST
        "WH":[.M, .R],                          // WHUMP, WHURL
        // no WR
        "Y": [.C, .L, .M, .R],                  // YUCCA, YULE, YUMMY, YURT
        "Z": [.R]],                             // (A)ZURE
    dynFollowers: {(syll: SyllabicArray, nRemain: Int) -> [Letter] in
        var followers: [Letter] = []
        let lastElement = syll.lastElement()

        if nRemain == 2 {
            
            // Final I for ENNUI
            if syll.matchesString("ENN", matchFull: true) {
                followers += [.I]
            }
            
            // Final UR restricted words: BLUR, INCUR, SLUR
            if syll.matchesSet(["BL", "INC", "SL"]) {
                followers += [.R]
            }
            
            // Final X for FLUX
            if syll.matchesString("FL", matchFull: true) {
                followers += [.X]
            }
        }
        
        // Approve double U for VACUUM
        if syll.matchesString("VAC", matchFull: true) {
            followers += [.U]
        }

        return followers
    })

let vowelMap: [Letter:Vowel] = [.A:A, .E:E, .I:I, .O:O, .U:U]
