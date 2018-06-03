//
//  VowelBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class VowelBlend: LexicalBlend, PhoneticFollowers {
    let initCons: [Letter]
    let interCons: [Letter]
    let finalCons: [Letter]
    let blendInto: [Letter]
    var glottalStop: Bool
    let followerTable: [String:[Letter]]
    
    func initialFollowers(nRemain: Int) -> [Letter] {
        
        let initialFollowers = initCons
        return initialFollowers
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
        var midFollowers = interCons + blendInto
        if dynFollowers != nil {
            midFollowers += self.dynFollowers!(pea, .positionMIDDLE)
        }
        return midFollowers
    }
    
    func lastFollowers(pea: PhoneticElementArray) -> [Letter] {
        var lastFollowers = finalCons
        if canPlural {
            lastFollowers += [.S]
        }
        if dynFollowers != nil {
            lastFollowers += self.dynFollowers!(pea, .positionLAST)
        }
        return lastFollowers
    }
    
    init(first: Letter, second: Letter, third: Letter?,
        initCons: [Letter],     // Consonants which can follow immediately if this blend starts the word (empty if cannot start)
        interCons: [Letter],    // Consonants which follow when the blend occurs in the middle of a word
        finalCons: [Letter],      // Consonants which can follow if the blend immediately precedes the end of a word
        blendInto: [Letter],         // Vowels which can form a triple-letter blend (not many of these exist)
        canPlural: Bool,             // True if the blend accepts a singular S to make a plural
        glottal: Bool,               // True if a glottal stop always occurs on the second vowel (some blends are conditional)
        
        followerTable: [String:[Letter]],
        
        dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?)   // Callback for context-sensitive followers

    {
        self.initCons = initCons
        self.interCons = interCons
        self.finalCons = finalCons
        self.blendInto = blendInto
        self.glottalStop = glottal
        self.followerTable = followerTable
        
        super.init(first: first, second: second, third: third,
                   canStart: (initCons != []), canEnd: true, canPlural: canPlural,
                   dynFollowers: dynFollowers)
        
        self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
}

let AA = VowelBlend(first: .A, second: .A, third: nil,
                    initCons: [.R],        // Only for AARDVARK
                    interCons: [],
                    finalCons: [],
                    blendInto: [],
                    canPlural: false,
                    glottal: false,
                    followerTable: [
                        "B":[.S]],                  // BAAS
                    dynFollowers: nil)

let AE = VowelBlend(first: .A, second: .E, third: nil,
                    initCons: [.G, .R],      // AEGIS, AERIE
                    interCons: [],
                    finalCons: [],
                    blendInto: [],
                    canPlural: false,
                    glottal: false,
                    followerTable: [:],
                    dynFollowers: nil)

let AI = VowelBlend(first: .A, second: .I, third: nil,
                    initCons: [.D, .L, .M, .R, .S],       // AIDS, AILS, AIMS, AIRS, AISLE
                    interCons: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finalCons: [.C, .D, .F, .L, .M, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    glottal: false,
                    followerTable: [
                        "B":[.L, .T],             // BAIL, BAIT
                        "BL":[.N],                // BLAINE
                        "BR":[.D, .N, .S],        // BRAID, BRAIN, BRAISE
                        "C":[.N, .R],             // CAIN, CAIRN
                        "CH":[.N, .R, .S],        // CHAIN, CHAIR, CHAISE
                        "CL":[.M, .R],            // CLAIM, (E)CLAIR
                        "D":[.L, .N, .R, .S],     // DAILY, DAINTY, DAIRY, DAIS
                        "DR":[.N],                // DRAIN
                        "F":[.L, .N, .R],         // FAIL, FAINT, FAIR(Y)
                        "FL":[.L, .R],            // FLAIL, FLAIR
                        "FR":[.D, .L, .N],        // (A)FRAID, FRAIL, (RE)FRAIN
                        "G":[.L, .N, .T],         // GAIL, GAIN, GAIT
                        "GR":[.L, .N],            // GRAIL, GRAIN
                        "H":[.K, .L, .R],         // HAIKU, HAIL, HAIR(Y)
                        "J":[.L],                 // JAIL
                        "K":[.S],                 // KAISER
                        "L":[.C, .D, .N, .R],     // LAIC, LAID, LAIN, LAIR
                        "M":[.D, .L, .M, .N, .Z], // MAID, MAIL, MAIM, MAIN(TAIN), MAIZE
                        "N":[.F, .L, .R, .V],     // NAIF, NAIL, (DEBO)NAIR, NAIVE
                        "P":[.D, .L, .N, .R],     // PAID, PAIL, PAIN, PAIR
                        "PL":[.D, .N, .T],        // PLAID, PLAIN, PLAIT
                        "PR":[.R, .S],            // PRAIRIE, PRAISE
                        "QU":[.L],                // QUAIL
                        "R":[.D, .L, .N, .S],     // RAID, RAIL, RAIN, RAISE
                        "S":[.D, .L, .N],         // SAID, SAIL, SAINT
                        "SL":[.N],                // SLAIN
                        "SN":[.L],                // SNAIL
                        "SP":[.N, .R],            // SPAIN, (DE)SPAIR
                        "SPR":[.N],               // SPRAIN
                        "ST":[.D, .N, .R],        // STAID, STAIN, STAIR
                        "STR":[.G, .N, .T],       // STRAIGHT, STRAIN, STRAIT
                        "SW":[.N],                // SWAIN
                        "T":[.L, .N],             // TAIL, TAINT
                        "TR":[.L, .N, .T],        // TRAIL, TRAIN, TRAIT
                        "V":[.L, .N],             // VAIL, VAIN
                        "W":[.F, .L, .N, .S],     // WAIF, WAIL, WAIN, WAIST
                        "WR":[.T]],               // WRAITH
                    dynFollowers: nil)

let AO = VowelBlend(first: .A, second: .O, third: nil,
                    initCons: [.R],          // AORTA
                    interCons: [.S, .T],
                    finalCons: [],
                    blendInto: [],
                    canPlural: false,
                    glottal: true,          // but false for GAOL
                    followerTable: [
                        "B":[.B],           // BAOBAB
                        "CH":[.S, .T],      // CHAOS, CHAOTIC
                        "G":[.L]],          // GAOL
                    dynFollowers: nil)

let AU = VowelBlend(first: .A, second: .U, third: nil,
                    initCons: [.D, .G, .L, .R, .S, .T, .X],  // AUDIO, AUGUR, AURAL, AUSTRIAN, AUTO, AUXILIARY
                    interCons: [.B, .C, .D, .F, .G, .L, .N, .R, .S, .T, .V],
                    finalCons: [.D, .F, .L, .M, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    glottal: false,
                    followerTable: [
                        "B":[.B, .D],           // BAUBLE, BAUD
                        "C":[.C, .G, .L, .S],   // CAUCUS, CAUGHT, CAUL, CAUSE
                        "CL":[.S],              // CLAUSE
                        "D":[.N, .P],           // DAUNT, DAUPHIN
                        "DR":[.G],              // DRAUGHT
                        "F":[.N],               // FAUN
                        "FL":[.N],              // FLAUNT
                        "FR":[.D, .G],          // FRAUD, FRAUGHT
                        "G":[.D, .G],           // GAUDY, GAUGE
                        "H":[.G, .L, .N],       // HAUGHTY, HAUL, HAUNCH
                        "J":[.N],               // JAUNDICE
                        "L":[.D, .G, .N],       // LAUD, LAUGH, LAUNCH/LAUNDRY
                        "M":[.L, .S, .V],       // MAUL, MAUSOLEUM, MAUVE
                        "N":[.G, .T],           // NAUGHT, NAUTICAL
                        "P":[.N, .S],           // PAUNCH, PAUSE
                        "PL":[.S],              // PLAUSIBLE
                        "S":[.C, .N],           // SAUCE, SAUNTER
                        "SL":[.G],              // SLAUGHTER
                        "ST":[.N],              // STAUNCH
                        "STR":[.G],             // (DIS)TRAUGHT
                        "T":[.G, .N, .T],       // TAUGHT, TAUNT, TAUT
                        "V":[.L, .N]],          // VAULT, VAUNT
                    dynFollowers: nil)

let EA = VowelBlend(first: .E, second: .A, third: nil,
                    initCons: [.C, .R, .S, .T, .V],
                    interCons: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V],
                    finalCons: [.D, .F, .K, .L, .M, .N, .P, .R, .T],
                    blendInto: [],
                    canPlural: true,
                    glottal: false,
                    followerTable: [
                        "B":[.C, .D, .G, .K, .M, .N, .R, .S, .T, .U, .V],   // BEACH, BEAD, BEAGLE, BEAK, BEAL, BEAM,
                                                                            // BEAN, BEAR, BEAST, BEAT, BEAUTY, BEAVER
                        "BL":[.C, .K, .R, .T],                              // BLEACH, BLEAK, BLEARY, BLEAT
                        "BR":[.C, .D, .K, .M, .S],                          // BREACH, BREAD, BREAK, BREAM, BREAST
                        "C":[.S],                                           // CEASE
                        "CH":[.P, .T],                                      // CHEAP, CHEAT
                        "CL":[.N, .R, .T, .V],                              // CLEAN(SE), CLEAR, CLEAT, CLEAVE
                        "CR":[.K, .M, .T],                                  // CREAK, CREAM, CREATE
                        "D":[.D, .F, .L, .N, .R, .T],                       // DEAD, DEAF, DEAL, DEAN, DEAR(TH), DEATH
                        "DR":[.D, .M],                                      // DREAD, DREAM
                        "F":[.L, .R, .S, .T],                               // FEALTY, FEAR, FEAST, FEAT/HER
                        "FL":[.S],                                          // FLEAS
                        "G":[.R],                                           // GEAR
                        "GL":[.M, .N],                                      // GLEAM, GLEAN
                        "GR":[.S, .T],                                      // GREASE, GREAT
                        "H":[.D, .L, .P, .R, .T, .V],                       // HEAD, HEAL(TH), HEAP, HEAR(TH)/HEARSE, HEATH, HEAVE
                        "KN":[.D],                                          // KNEAD
                        "L":[.C, .D, .F, .G, .K, .N, .P, .R, .S, .V],       // LEACH, LEAD, LEAF, LEAGUE, LEAK, LEAN,
                                                                            // LEAP, LEAR(N), LEAS(E/H/T), LEAVE
                        "M":[.D, .L, .N, .T],                               // MEAD, MEAL, MEAN, MEAT
                        "N":[.P, .R, .T],                                   // NEAP, NEAR, NEAT
                        "P":[.C, .K, .L, .N, .R,. S, .T],                   // PEACH, PEAK, PEAL, PEAN, PEAR(L), PEAS, PEAT
                        "PL":[.D, .S, .T],                                  // PLEAD, PLEAS/E, PLEAT
                        "PR":[.C],                                          // PREACH
                        "QU":[.S],                                          // QUEASY
                        "R":[.C, .D, .L, .M, .P, .R],                       // REACH/REACT, READ, REAL, REAM, REAP, REAR
                        "RH":[.S],                                          // RHEAS
                        "S":[.L, .M, .N, .R, .S, .T],                       // SEAL, SEAM, SEAN, SEAR, SEAS, SEAT
                        "SCR":[.M],                                         // SCREAM
                        "SH":[.F, .R, .T, .V],                              // SHEAF, SHEAR, SHEATH, SHEAVE
                        "SM":[.R],                                          // SMEAR
                        "SP":[.K, .R],                                      // SPEAK, SPEAR
                        "SPR":[.D],                                         // SPREAD
                        "SQU":[.K, .L, .M],                                 // SQUEAK, SQUEAL, SQUEAMISH
                        "ST":[.D, .K, .L, .M],                              // STEAD, STEAK, STEAL, STEAM
                        "STR":[.K, .M],                                     // STREAK, STREAM
                        "SW":[.R, .T],                                      // SWEAR, SWEAT
                        "T":[.C, .K, .L, .M, .R, .S, .T],                   // TEACH, TEAK, TEAL, TEAM, TEAR, TEAS, TEAT
                        "THR":[.D, .T],                                     // THREAD, THREAT
                        "TR":[.T],                                          // TREAT
                        "V":[.L],                                           // VEAL
                        "W":[.K, .L, .N, .P, .R, .V],                       // WEAK, WEAL, WEAN, WEAPON, WEAR, WEAVE
                        "WH":[.T],                                          // WHEAT
                        "WR":[.T],                                          // WREATH
                        "Y":[.H, .R, .S],                                   // YEAH, YEAR, YEAS/T
                        "Z":[.L]],                                          // ZEAL
                    dynFollowers: { (phonemes:PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                        
                        // Allow for BEAU and all derivatives (BEAUTY, BEAUTIFUL, etc.)
                        if phonemes.matchesString("B", matchFull: true) {
                            return [.U]
                        }
                        else {
                            return []
                        }
                    })

let EAU = VowelBlend(first: .E, second: .A, third: .U,
                    initCons: [],
                    interCons: [.T],       // BEAUTIFUL
                    finalCons: [],
                    blendInto: [],
                    canPlural: true,
                    glottal: false,
                    followerTable: [
                        "B":[.T]],
                    dynFollowers: nil)

let EE = VowelBlend(first: .E, second: .E, third: nil,
                    initCons: [.L, .R],        // EELS, EERIE
                    interCons: [.C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finalCons: [.D, .F, .K, .L, .M, .N, .P, .R, .T],
                    blendInto: [.I],        // for gerunds like FLEEING
                    canPlural: true,
                    glottal: false,
                    followerTable: [
                        "B":[.C, .F, .N, .P, .R, .S, .T],   // BEECH, BEEF, BEEN, BEEP, BEER, BEES, BEET
                        "BL":[.D, .P],                      // BLEED, BLEEP,
                        "BR":[.D, .Z],                      // BREED, BREEZE
                        "CH":[.P, .R, .S, .T],              // CHEEP, CHEER, CHEESE, CHEETAH
                        "CR":[.D, .K, .L, .P, .S],          // CREED, CREEK, CREEL, CREEP, CREES
                        "D":[.D, .M, .P, .R],               // DEED, DEEM, DEEP, DEER
                        "F":[.D, .L, .S, .T],               // FEED, FEEL, FEES, FEET
                        "FL":[.C, .I, .R, .S, .T],          // FLEECE, FLEEING, FLEER, FLEES, FLEET
                        "FR":[.D, .I, .L, .S, .Z],          // FREED, FREEING, FREELY, FREES, FREEZE
                        "G":[.D, .K, .S],                   // GEED, GEEK, GEES
                        "GL":[.S],                          // GLEES?
                        "GR":[.D, .K, .N, .T],              // GREED, GREEK, GREEN, GREET
                        "H":[.D, .L],                       // HEED, HEEL
                        "J":[.P, .R],                       // JEEP, JEER
                        "K":[.L, .N, .P],                   // KEEL, KEEN, KEEP
                        "KN":[.D, .L, .S],                  // KNEED, KNEEL, KNEES
                        "L":[.C, .K, .R, .S],               // LEECH, LEEK, LEER, LEES
                        "M":[.L, .T],                       // MEELY
                        "N":[.D],                           // NEED
                        "P":[.D, .K, .L, .N, .P, .R, .S, .V], // PEED, PEEK, PEEL, PEEN, PEEP, PEER, PEES, PEEVE
                        "PR":[.N],                          // PREEN
                        "QU":[.N, .R],                      // QUEEN, QUEER
                        "R":[.D, .F, .K, .L, .S],           // REED, REEF, REEK, REEL, REES
                        "S":[.D, .I, .K, .M, .N, .P, .R, .S, .T],
                                                            // SEED, SEEING, SEEK, SEEM, SEEN, SEEP, SEER, SEES, SEETHE
                        "SCR":[.C, .D, .N, .S],             // SCREED, SCREECH, SCREEN, SCREES
                        "SH":[.N, .P, .R, .T],              // SHEEN, SHEEP, SHEER, SHEET
                        "SL":[.K, .P, .T, .V],              // SLEEK, SLEEP, SLEET, SLEEVE
                        "SK":[.T],                          // SKEET
                        "SN":[.R, .Z],                      // SNEER, SNEEZE
                        "SP":[.C, .D],                      // SPEECH, SPEED
                        "SPR":[.D, .S],                     // SPREED, SPREES
                        "SQU":[.G, .Z],                     // SQUEEGEE, SQUEEZE
                        "ST":[.D, .L, .P, .R],              // STEED, STEEL, STEEP, STEER
                        "STR":[.T],                         // STREET
                        "SW":[.P, .T],                      // SWEEP, SWEET
                        "T":[.D, .I, .M, .N, .S, .T],       // TEED, TEEING, TEEM, TEEN, TEES, TEETH
                        "TH":[.S],                          // THEES?
                        "THR":[.S],                         // THREES
                        "TR":[.D, .R, .S],                  // TREED, TREER, TREES
                        "V":[.R, .S],                       // VEER, VEES
                        "W":[.B, .D, .K, .P, .S],           // WEEBLE, WEED, WEEK, WEEP, WEES
                        "WH":[.L, .S, .Z]],                 // WHEEL, WHEES, WHEEZE
                    dynFollowers: nil)

let EI = VowelBlend(first: .E, second: .I, third: nil,
                    initCons: [.D, .G, .T],        // EIDER, EIGHT, EITHER
                    interCons: [.C, .G, .K, .L, .N, .R, .S, .T, .V, .Z],
                    finalCons: [.D, .K, .L, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    glottal: false,
                    followerTable: [
                        "B":[.G, .N],       // BEIGE, BEING
                        "C":[.L],           // CEILING
                        "D":[.C, .F, .G, .S, .T],   // DEICE, DEIFY, DEIGN, DEISM/ST, DEITY
                        "F":[.G, .N, .S],   // FEIGN, FEINT, FEISTY
                        "FR":[.G],          // FREIGHT
                        "H":[.G, .S],       // HEIGHT, HEIST
                        "L":[.G, .S],       // LEIGH(T), LEIS
                        "M":[.N],           // MEIN
                        "N":[.G],           // NEIGH(BOR)
                        "P":[.G, .N],       // PEIGNOIR, PEIN
                        "R":[.G, .M, .N],   // REIGN, REIMAGINE, REIN
                        "S":[.Z],           // SEIZE
                        "SH":[.K],          // SHEIK
                        "SK":[.N],          // SKEIN
                        "SL":[.G],          // SLEIGH
                        "SP":[.G],          // SPEIGHT
                        "ST":[.N],          // STEIN
                        "TH":[.S],          // THEISM/T
                        "V":[.G, .L, .N],   // (IN)VEIGH, VEIL, VEIN
                        "W":[.G, .R]],      // WEIGHT, WEIR(D)
                    dynFollowers: nil)

let EO = VowelBlend(first: .E, second: .O, third: nil,
                    initCons: [.N],        // EONS
                    interCons: [.D, .G, .L, .M, .N, .R, .S, .T],
                    finalCons: [.N, .R],        // NEON, METEOR
                    blendInto: [],
                    canPlural: false,
                    glottal: true,          // Could be false, ex. YEOMAN
                    followerTable: [
                        "FR":[.N],              // FREON
                        "G":[.D, .G, .L, .S],   // GEODE, GEOGRAPHY, GEOLOGY, GEOSPHERE
                        "L":[.N],               // LEON
                        "M":[.W],               // MEOW
                        "N":[.L, .N, .S],       // NEOLIBERAL, NEON, NEOS
                        "P":[.N, .P],           // PEON(S/Y), PEOPLE
                        "R":[.C, .P, .R],       // REOCCUR, REOPERATE, REORDER
                        "Y":[.M]],              // YEOMAN
                    dynFollowers: nil)

let EU = VowelBlend(first: .E, second: .U, third: nil,
                    initCons: [.R],       // EURO
                    interCons: [.C, .D, .R, .T],
                    finalCons: [.D, .M, .R],        // MUSEUM/MAUSOLEUM, AMATEUR/VOYEUR
                    blendInto: [],
                    canPlural: false,
                    glottal: false,
                    followerTable: [
                        "D":[.C],               // DEUCE
                        "F":[.D],               // FEUD
                        "H":[.R],               // HEURISTIC
                        "N":[.R, .S, .T],       // NEURAL, NEUSE, NEUTRAL
                        "QU":[.E],              // QUEUE
                        "R":[.N, .S, .T]],      // REUNITE, REUSE, REUTTER
                    dynFollowers: nil)

let IA = VowelBlend(first: .I, second: .A, third: nil,
                    initCons: [.M],        // IAMBS
                    interCons: [.B, .C, .D, .L, .M, .N, .P, .R, .S, .T],
                    finalCons: [.D, .L, .M, .N, .R, .T],
                    blendInto: [],
                    canPlural: true,
                    glottal: true,          // could be false in some cases?
                    followerTable: [
                        "B":[.N, .S],           // BIANNUAL, BIAS
                        "BR":[.R],              // BRIAR
                        "D":[.G, .L, .P, .R],   // DIAL, DIAPER, DIARY
                        "DR":[.D],              // DRIAD
                        "F":[.T],               // FIAT
                        "FR":[.R],              // FRIAR
                        "G":[.N],               // GIANT
                        "GL":[.L],              // GLIAL
                        "L":[.B, .R],           // LIABLE, LIAR
                        "P":[.N, .T],           // PIANO, (EX)PIATE
                        "PL":[.B],              // PLIABLE
                        "R":[.L],               // RIAL
                        "T":[.R],               // TIARA
                        "TR":[.D, .G, .L],      // TRIAD, TRIAGE, TRIAL
                        "V":[.B, .D, .L]],      // VIABLE, VIADUCT, VIAL
                    dynFollowers: nil)

let IE = VowelBlend(first: .I, second: .E, third: nil,
                    initCons: [],
                    interCons: [.C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .U, .V, .Z],
                    finalCons: [.D, .F, .L, .M, .N, .R, .T],
                    blendInto: [],
                    canPlural: true,
                    glottal: false,
                    followerTable: [
                        "B":[.N, .R],               // BIENNIAL, BIER
                        "BR":[.F, .R],              // BRIEF, BRIER
                        "CH":[.F],                  // CHIEF
                        "CR":[.D, .R, .S],          // CRIED, CRIER, CRIES
                        "D":[.D, .S, .T],           // DIED, DIES, DIET
                        "DR":[.D, .R, .S],          // DRIED, DRIER, DRIES
                        "F":[.F, .L, .R, .N, .S],   // FIEFDOM, FIELD, FIERY, FIEND, FIES
                        "FL":[.R, .S],              // FLIER, FLIES
                        "FR":[.D, .R, .N, .S],      // FRIED, FRIEND, FRIER, FRIES
                        "GR":[.F, .V],              // GRIEF, GRIEVE
                        "H":[.R],                   // HIERARCHY
                        "L":[.D, .G, .N, .S, .U],   // LIED, LIEGE, LIEN, LIES, LIEU
                        "M":[.N],                   // MIEN
                        "N":[.C],                   // NIECE
                        "P":[.C, .D, .R, .S, .T],   // PIECE, PIED, PIER(CE), PIES, PIETY
                        "PL":[.D, .R, .S],          // PLIED, PLIER, PLIES
                        "PR":[.D, .R, .S],          // PRIED, PRIER, PRIES
                        "QU":[.T],                  // QUIET
                        "S":[.G, .V],               // SIEGE, SIEVE
                        "SH":[.D, .L, .R, .S],      // SHIED, SHIELD, SHIER, SHIES
                        "SHR":[.K],                 // SHRIEK
                        "SK":[.R, .S],              // SKIER, SKIES
                        "SP":[.D, .L, .R, .S],      // SPIED, SPIEL, SPIER, SPIES
                        "SPR":[.R, .S],             // SPRIER, SPRIEST
                        "ST":[.S],                  // STIES
                        "T":[.D, .R, .S],           // TIED, TIER, TIES
                        "TH":[.F, .V],              // THIEF, THIEVES
                        "TR":[.D, .R, .S],          // TRIED, TRIER, TRIES
                        "V":[.D, .R, .S, .W],       // VIED, VIES, VIER, VIEW
                        "W":[.L],                   // WIELD
                        "Y":[.L]],                  // YIELD
                    dynFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                        var followers: [Letter] = []
                        let lastElement = phonemes.lastElement()
                        
                        // this allows for VIEW and related words (PREVIEW, REVIEW, OVERVIEW)
                        if lastElement != nil && lastElement!.id == "V" {
                            followers += [.W]
                        }
                            
                        // this allows for LIEU only at the end of a word
                        else if phonemes.matchesString("L", matchFull: true) {
                            followers += [.U]
                        }
                            
                        return followers
                    })

let IEU = VowelBlend(first: .I, second: .E, third: .U,
                     initCons: [],
                     interCons: [],
                     finalCons: [],
                     blendInto: [],
                     canPlural: false,
                     glottal: false,
                     followerTable: [:],
                     dynFollowers: nil)

let II = VowelBlend(first: .I, second: .I, third: nil,
                    initCons: [],
                    interCons: [],
                    finalCons: [],
                    blendInto: [],
                    canPlural: false,
                    glottal: true,
                    followerTable: [
                        "SK":[.N]],             // SKIING
                    dynFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) -> [Letter] in
                        let lastElement = phonemes.lastElement()
                        
                        // Double I words: SKIING, TAXIING
                        if phonemes.matchesSet(["SK", "TAX"]) {
                            return [.N]
                        }
                        else {
                            return []
                        }
                    })

let IO = VowelBlend(first: .I, second: .O, third: nil,
                    initCons: [.N, .T],        // IONS, IOTA
                    interCons: [.D, .M, .N, .R, .S, .T],
                    finalCons: [.D, .N, .R, .S, .T],
                    blendInto: [.U],        // xIOUS ending
                    canPlural: true,
                    glottal: true,
                    followerTable: [
                        "B":[.D, .G, .L, .S],   // BIODOME, BIOGRAPHY, BIOLOGY, BIOSPHERE
                        "BR":[.S],              // BRIOS
                        "D":[.D],               // DIODE
                        "F":[.R],               // FIORD
                        "L":[.N],               // LION
                        "P":[.U],               // PIOUS
                        "R":[.T],               // RIOT
                        "PR":[.R],              // PRIOR
                        "SC":[.N],              // SCION
                        "TR":[.S],              // TRIOS
                        "V":[.L]],              // VIOLENT
                    dynFollowers: nil)

let IU = VowelBlend(first: .I, second: .U, third: nil,
                    initCons: [],
                    interCons: [.M, .S],
                    finalCons: [.M],
                    blendInto: [],
                    canPlural: false,
                    glottal: false,
                    followerTable: [            // TRIUNE
                        "TR":[.N]],
                    dynFollowers: nil)

let OA = VowelBlend(first: .O, second: .A, third: nil,
                    initCons: [.F, .K, .R, .S, .T],        // OAFS, OAKS, OARS, OAST, OATS
                    interCons: [.C, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T, .V],
                    finalCons: [.D, .F, .K, .L, .M, .N, .P, .R, .S, .T],
                    blendInto: [],
                    canPlural: true,
                    glottal: false,
                    followerTable: [
                        "B":[.R, .S, .T],               // BOAR, BOAS(T), BOAT
                        "BL":[.T],                      // BLOAT
                        "BR":[.C, .D],                  // BROACH, BROAD
                        "C":[.C, .L, .S, .T],           // COACH, COAL, COAST, COAT
                        "CL":[.K],                      // CLOAK
                        "CR":[.K],                      // CROAK
                        "F":[.L, .M],                   // FOAL, FOAM
                        "FL":[.T],                      // FLOAT
                        "G":[.D, .L, .T],               // GOAD, GOAL, GOAT
                        "GL":[.T],                      // GLOAT
                        "GR":[.N],                      // GROAN
                        "H":[.R],                       // HOAR(D/Y)
                        "L":[.C, .D, .F, .M, .N, .T, .V],   // LOACH, LOAD, LOAF, LOAM, LOAN, LOATH(E), LOAVES
                        "M":[.N, .T],                   // MOAN, MOAT
                        "P":[.C],                       // POACH
                        "R":[.C, .D, .M, .N, .R, .S],   // ROACH, ROAD, ROAM, ROAN, ROAR, ROAST
                        "S":[.K, .P, .R],               // SOAK, SOAP, SOAR
                        "SH":[.L, .T],                  // SHOAL, SHOAT
                        "ST":[.T],                      // STOAT
                        "T":[.D, .S],                   // TOAD, TOAST
                        "THR":[.T],                     // THROAT
                        "W":[.D]],                      // WOAD
                    dynFollowers: nil)

let OE = VowelBlend(first: .O, second: .E, third: nil,
                    initCons: [.N],
                    interCons: [.D, .M, .R, .S, .T],
                    finalCons: [.D, .M, .R, .S, .T],
                    blendInto: [.I],
                    canPlural: true,
                    glottal: false,
                    followerTable: [
                        "C":[.D, .R, .S, .X],   // COED, COERCE, COES, COEXIST
                        "D":[.R, .S],           // DOER, DOES
                        "F":[.S],               // FOES
                        "FL":[.S],              // FLOES
                        "G":[.R, .S],           // GOER, GOES
                        "H":[.D, .I, .R, .S],   // HOED, HOEING, HOER, HOES
                        "J":[.S, .Y],           // JOES, JOEY
                        "N":[.L, .S],           // NOEL, NOES
                        "P":[.M, .T],           // POEM, POET(RY)
                        "PH":[.N],              // PHOENIX
                        "R":[.S],               // ROES
                        "SH":[.D, .R, .S],      // SHOED, SHOER, SHOES
                        "SL":[.S],              // SLOES
                        "T":[.D, .I, .S],       // TOED, TOEING, TOES
                        "THR":[.S],             // THROES
                        "W":[.S]],              // WOES
                    dynFollowers: nil)

let OI = VowelBlend(first: .O, second: .I, third: nil,
                    initCons: [.L],        // OILS
                    interCons: [.C, .D, .F, .L, .N, .R, .S, .T, .V],
                    finalCons: [.C, .D, .L, .N, .R],
                    blendInto: [],
                    canPlural: false,       // but KOI perhaps?
                    glottal: true,
                    followerTable: [
                        "B":[.L, .S],           // BOIL, BOISTEROUS
                        "BR":[.L],              // BROIL
                        "C":[.F, .L, .N, .T],   // COIFFURE, COIL, COIN, COITUS
                        "CH":[.C, .R],          // CHOICE, CHOIR
                        "CL":[.S],              // CLOISTER
                        "D":[.L, .N],           // DOILY, DOING
                        "F":[.L, .S],           // FOIL, FOIST
                        "G":[.L, .N],           // GOIL, GOING
                        "GR":[.N],              // GROIN
                        "H":[.S],               // HOIST
                        "J":[.N, .S],           // JOIN(T), JOIST
                        "L":[.N, .T],           // LOIN, LOITER
                        "M":[.L, .R, .S],       // MOIL, MOIRE, MOIST
                        "N":[.S],               // NOISE
                        "P":[.N, .S],           // POINT, POISE
                        "R":[.L],               // ROIL
                        "S":[.L, .R],           // SOIL, SOIREE
                        "SP":[.L],              // SPOIL
                        "ST":[.C],              // STOIC
                        "T":[.L],               // TOIL
                        "V":[.C, .D]],          // VOICE, VOID
                    dynFollowers: nil)

let OO = VowelBlend(first: .O, second: .O, third: nil,
                    initCons: [.Z],        // OOZE
                    interCons: [.B, .C, .D, .F, .G, .I, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finalCons: [.B, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T],
                    blendInto: [.E, .I],        // GOOEY, gerunds like WOOING
                    canPlural: true,
                    glottal: false,
                    followerTable: [
                        "B":[.B, .E, .G, .I, .K, .L, .M, .N, .R, .S, .T], // BOOB, BOOED, BOOING, BOOGER, BOOK, BOOLEAN,
                                                                          // BOOM, BOON, BOOR, BOOST, BOOT
                        "BL":[.D, .P],                          // BLOOD, BLOOP
                        "BR":[.C, .D, .M],                      // BROOCH, BROOD, BROOM
                        "C":[.C, .E, .I, .K, .L, .N, .P, .S, .T],   // COOCH, COOED, COOING, COOK, COOL, COON, COOP, COOS, COOT
                        "CH":[.S],                              // CHOOSE
                        "D":[.M, .R, .S],                       // DOOM, DOOR, DOOS
                        "DR":[.L, .P],                          // DROOL, DROOP
                        "F":[.L, .T],                           // FOOL
                        "FL":[.R],                              // FLOOR
                        "G":[.C, .E, .F, .G, .N, .P, .S],       // GOOCH, GOOEY, GOOF, GOOGLE, GOON, GOOP, GOOS(E)
                        "GL":[.M],                              // GLOOM
                        "GR":[.M, .V],                          // GROOM, GROOVE
                        "H":[.C, .D, .F, .K, .P, .S, .T, .V],   // HOOCH, HOOD, HOOF, HOOK, HOOP, HOOS, HOOT, HOOVES
                        "L":[.F, .K, .M, .N, .P, .S, .T],       // (A)LOOF, LOOK, LOOM, LOON, LOOP, LOOS(E), LOOT
                        "M":[.C, .E, .I, .N, .R, .S, .T],       // MOOCH, MOOED, MOOING, MOOR, MOOS(E), MOOT
                        "N":[.K, .N, .S],                       // NOOK, NOON, NOOSE
                        "P":[.C, .F, .L, .P, .R, .S, .T],       // POOCH, POOF, POOL, POOP, POOR, POOS, POOT
                        "PH":[.E],                              // PHOOEY
                        "PR":[.F],                              // PROOF
                        "R":[.F, .K, .M, .S, .T, .V],           // ROOF, ROOK, ROOM, ROOST, ROOT
                        "S":[.N, .T],                           // SOON, SOOT(HE)
                        "SC":[.P, .T],                          // SCOOP, SCOOT
                        "SCH":[.L, .N],                         // SCHOOL, SCHOONER
                        "SH":[.E, .I, .K, .S, .T],              // SHOOED, SHOOING, SHOOK, SHOOS, SHOOT
                        "SL":[.P],                              // SLOOP
                        "SM":[.C, .T],                          // SMOOCH, SMOOTH
                        "SN":[.K, .P, .T, .Z],                  // SNOOKER, SNOOP, SNOOT, SNOOZE
                        "SP":[.K, .L, .N],                      // SPOOK, SPOOL, SPOON
                        "ST":[.D, .L, .P],                      // STOOD, STOOL, STOOP
                        "SW":[.N, .P],                          // SWOON, SWOOP
                        "T":[.K, .L],                           // TOOK, TOOL
                        "TR":[.P],                              // TROOP
                        "W":[.D, .E, .F, .I, .L, .S],           // WOOD, WOOED, WOOF, WOOING, WOOL, WOOS
                        "WH":[.P, .S],                          // WHOOP, WHOOSH
                        "V":[.D],                               // VOODOO
                        "Z":[.M, .S]],                          // ZOOM, ZOOS
                    dynFollowers: nil)

let OU = VowelBlend(first: .O, second: .U, third: nil,
                    initCons: [.N, .R, .S, .T],    // OUNCE, OURS, OUST, OUTS
                    interCons: [.B, .C, .D, .F, .G, .L, .N, .P, .Q, .R, .S, .T, .V, .Z],
                    finalCons: [.D, .L, .N, .P, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    glottal: false,
                    followerTable: [
                        "B":[.D, .G, .L, .N, .Q, .T],   // BOUDOIR, BOUGHT, BOULDER, BOUNCE/BOUND/BOUNTY, BOUQUET, BOUT
                        "BL":[.S],                      // BLOUSE
                        "BR":[.G],                      // BROUGHT
                        "C":[.C, .L, .N, .R],           // COUCH, COULE/COULD, COUNT, COURAGE/COURT
                        "CL":[.T],                      // CLOUT
                        "CR":[.C, .T],                  // CROUCH, CROUTON
                        "D":[.B, .G, .R],               // DOUBT, DOUGH, DOUR
                        "F":[.G, .L, .N, .R],           // FOUGHT, FOUL, FOUND/FOUNT, FOUR(TH)
                        "FL":[.C, .N, .R],              // FLOUNCE, FLOUNDER, FLOUR
                        "G":[.G, .R, .T],               // GOUGE, GOURD, GOUT
                        "GR":[.N, .P, .S, .T],          // GROUND, GROUP, GROUSE, GROUT
                        "H":[.N, .R, .S],               // HOUND, HOUR, HOUSE
                        "J":[.L, .R, .S],               // JOULE, JOURNEY, JOUST
                        "L":[.D, .S, .T],               // LOUD, LOUSE, LOUT
                        "M":[.N, .R, .S, .T],           // MOUND, MOURN, MOUSE, MOUTH
                        "N":[.N],                       // NOUN
                        "P":[.C, .L, .N, .R, .T],       // POUCH, POULTRY, POUNCE/POUND, POUR, POUT
                        "PL":[.G],                      // PLOUGH
                        "R":[.G, .L, .N, .S, .T],       // ROUGE/ROUGH, ROULETTE, ROUND, ROUST, ROUT
                        "S":[.G, .L, .N, .P, .R, .S, .T],   // SOUGHT, SOUL, SOUND, SOUP, SOUR, SOUSE, SOUTH
                        "SC":[.R, .T],                  // SCOUR(GE), SCOUT
                        "SH":[.L, .T],                  // SHOULD, SHOUT
                        "SHR":[.D],                     // SHROUD
                        "SL":[.C, .G],                  // SLOUCH, SLOUGH
                        "SN":[.T],                      // SNOUT
                        "SP":[.T],                      // SPOUT
                        "SPR":[.T],                     // SPROUT
                        "ST":[.T],                      // STOUT
                        "T":[.C, .G, .R, .T],           // TOUCH, TOUGH, TOUR, TOUT
                        "TH":[.G],                      // THOUGHT
                        "TR":[.G, .N, .P, .S, .T],      // TROUGH, TROUNCE, TROUPE, TROUSERS, TROUT
                        "V":[.C],                       // VOUCH
                        "W":[.L, .N],                   // WOULD, WOUND
                        "WR":[.G],                      // WROUGHT
                        "Y":[.N, .R, .T]],              // YOUNG, YOUR, YOUTH
                    dynFollowers: nil)

let UA = VowelBlend(first: .U, second: .A, third: nil,
                    initCons: [],
                    interCons: [.B, .C, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finalCons: [.D, .F, .L, .M, .N, .R, .T],        // QUAY?
                    blendInto: [.U],
                    canPlural: false,
                    glottal: true,
                    followerTable: [
                        "D":[.L],           // DUAL
                        "L":[.U],           // LUAU
                        "N":[.N]],          // NUANCE
                    dynFollowers: nil)

let UE = VowelBlend(first: .U, second: .E, third: nil,
                    initCons: [],
                    interCons: [.D, .L, .N, .R, .S, .T],
                    finalCons: [.D, .L, .R, .T],
                    blendInto: [],
                    canPlural: true,
                    glottal: false,
                    followerTable: [
                        "BL":[.D, .R, .S, .Y],      // BLUED, BLUER, BLUES, BLUEY
                        "C":[.D, .I, .R, .S],       // CUED, CUEING, CUER, CUES
                        "CL":[.D, .I, .R, .S],      // CLUED, CLUEING, CLUER, CLUES
                        "CR":[.L],                  // CRUEL
                        "D":[.L, .S, .T],           // DUEL, DUES, DUET
                        "F":[.L],                   // FUEL(S)
                        "FL":[.N, .S],              // FLUENT, FLUES
                        "G":[.S],                   // GUESS & GUEST
                        "GL":[.D, .I, .R, .S],      // GLUED, GLUEING, GLUER, GLUES
                        "GR":[.L],                  // GRUEL
                        "H":[.D, .R, .S],           // HUED, HUER, HUES
                        "R":[.D, .I, .R, .S],       // RUED, RUEING, RUER, RUES
                        "S":[.D, .R, .S, .T],       // SUED(E), SUER, SUES, SUET
                        "SL":[.S],                  // SLUES
                        "TR":[.D, .R]],             // TRUED, TRUER
                    dynFollowers: nil)

let UI = VowelBlend(first: .U, second: .I, third: nil,
                    initCons: [],
                    interCons: [.C, .D, .L, .N, .R, .S, .T],
                    finalCons: [.D, .L, .N, .R, .T],
                    blendInto: [],
                    canPlural: false,
                    glottal: false,              // but true for RUIN, SUICIDE, TRUISM
                    followerTable: [
                        "B":[.L],               // BUILD/T
                        "BR":[.N],              // BRUIN
                        "DR":[.D],              // DRUID
                        "FL":[.D],              // FLUID
                        "G":[.D, .L, .R, .S],   // GUIDE, GUILD/GUILT, GUIRO, GUISE
                        "J":[.C],               // JUICE
                        "R":[.N],               // RUIN
                        "S":[.C, .N, .T],       // SUICIDE, SUING, SUIT(E)
                        "SL":[.C],              // SLUICE
                        "TR":[.N, .S]],         // TRUING, TRUISM
                    dynFollowers: nil)

let UO = VowelBlend(first: .U, second: .O, third: nil,
                    initCons: [],
                    interCons: [.R, .S],
                    finalCons: [.R, .Y],
                    blendInto: [.U],        // VIRTUOUS
                    canPlural: true,
                    glottal: true,
                    followerTable: [
                        "B":[.Y],           // BUOY
                        "D":[.S],           // DUOS
                        "M":[.N]],          // MUON
                    dynFollowers: nil)

let UU = VowelBlend(first: .U, second: .U, third: nil,
                    initCons: [],
                    interCons: [.M],       // VACUUM
                    finalCons: [.M],
                    blendInto: [],
                    canPlural: false,
                    glottal: false,
                    followerTable: [:],
                    dynFollowers: nil)

let vowelBlendMap = ["AA":AA, "AE":AE, "AI":AI, "AO":AO, "AU":AU,
    "EA":EA, "EE":EE, "EI":EI, "EO":EO, "EU":EU, "EAU":EAU,
    "IA":IA, "IE":IE, "II":II, "IO":IO, "IU":IU, "IEU":IEU,
    "OA":OA, "OE":OE, "OI":OI, "OO":OO, "OU":OU,
    "UA":UA, "UE":UE, "UI":UI, "UO":UO, "UU":UU ]
