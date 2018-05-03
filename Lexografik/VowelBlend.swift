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
        var lastFollowers = finalCons + blendInto
        if canPlural {
            lastFollowers += [.S]
        }
        if dynFollowers != nil {
            lastFollowers += self.dynFollowers!(pea, .positionLAST)
        }
        return lastFollowers
    }
    
    func verifyFinal(pea: PhoneticElementArray) -> Bool {
        return true;
    }
    
    init(first: Letter, second: Letter, third: Letter?,
        initCons: [Letter],     // Consonants which can follow immediately if this blend starts the word (empty if cannot start)
        interCons: [Letter],    // Consonants which follow when the blend occurs in the middle of a word
        finalCons: [Letter],      // Consonants which can follow if the blend immediately precedes the end of a word
        blendInto: [Letter],         // Vowels which can form a triple-letter blend (not many of these exist)
        canPlural: Bool,             // True if the blend accepts a singular S to make a plural
        endOfWord: Bool,             // True if the blend can appear at the end of a word
        glottal: Bool,               // True if a glottal stop always occurs on the second vowel (some blends are conditional)
        
        followerTable: [String:[Letter]],
        
        dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?,   // Callback for context-sensitive followers
        
        verifyEnd: ((PhoneticElementArray) -> Bool)? )       // Callback for context checking at the end of a word
    {
        self.initCons = initCons
        self.interCons = interCons
        self.finalCons = finalCons
        self.blendInto = blendInto
        self.glottalStop = glottal
        self.followerTable = followerTable
        
        super.init(first: first, second: second, third: third,
                   canStart: (initCons != []), canEnd: endOfWord, canPlural: canPlural,
                   dynFollowers: dynFollowers)
        
        if endOfWord {
            if verifyEnd == nil {
                self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
            }
            else {
                self.verifyEndOfWord = verifyEnd
            }
        }
        else {
            self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        
        self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return canPlural }
    }
}

let AA = VowelBlend(first: .A, second: .A, third: nil,
                    initCons: [.R],        // Only for AARDVARK
                    interCons: [],
                    finalCons: [],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    followerTable: [:],
                    dynFollowers: nil,
                    verifyEnd: nil)

let AE = VowelBlend(first: .A, second: .E, third: nil,
                    initCons: [.G, .R],      // AEGIS, AERIE
                    interCons: [],
                    finalCons: [],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: true,            // ALGAE, MINUTAE
                    glottal: false,
                    followerTable: [:],
                    dynFollowers: nil,
                    verifyEnd: nil)

let AI = VowelBlend(first: .A, second: .I, third: nil,
                    initCons: [.D, .L, .M, .R, .S],       // AIDS, AILS, AIMS, AIRS, AISLE
                    interCons: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finalCons: [.C, .D, .F, .L, .M, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    followerTable: [
                        "B":[.L, .T],           // BAIL, BAIT
                        "BL":[.N],              // BLAINE
                        "BR":[.N],              // BRAIN
                        "C":[.N],               // CAIN
                        "CH":[.N, .R, .S],      // CHAIN, CHAIR, CHAISE
                        "D":[.N],               // DAINTY
                        "DR":[.N],              // DRAIN
                        "F":[.L, .N, .R],       // FAIL, FAINT, FAIR
                        "G":[.L, .N, .T],       // GAIL, GAIN, GAIT
                        "GR":[.L, .N],          // GRAIL, GRAIN
                        "H":[.K, .L, .R],       // HAIKU, HAIL, HAIR
                        "K":[.S],               // KAISER
                        "L":[.C, .D, .N, .R],   // LAIC, LAID, LAIN, LAIR
                        "M":[.D, .L, .M, .N, .Z], // MAID, MAIL, MAIM, MAINTAIN, MAIZE
                        "N":[.L, .V],           // NAIL, NAIVE
                        "P":[.L, .N, .R],       // PAIL, PAIN, PAIR
                        "PL":[.N, .T],          // PLAIN, PLAIT
                        "PR":[.S],              // PRAISE
                        "QU":[.L],              // QUAIL
                        "R":[.L, .N, .S],       // RAIL, RAIN, RAISE
                        "S":[.L],               // SAIL
                        "SL":[.N],              // SLAIN
                        "SPR":[.N],             // SPRAIN
                        "STR":[.G, .N],         // STRAIGHT, STRAIN
                        "SW":[.N],              // SWAIN
                        "T":[.L],               // TAIL
                        "TR":[.L, .N],          // TRAIL, TRAIN
                        "V":[.L, .N],           // VAIL, VAIN
                        "W":[.F, .L, .N, .S],   // WAIF, WAIL, WAIN, WAIST
                        "WR":[.T]],             // WRAITH
                    dynFollowers: nil,
                    verifyEnd: nil)

let AO = VowelBlend(first: .A, second: .O, third: nil,
                    initCons: [.R],          // AORTA
                    interCons: [.S, .T],
                    finalCons: [],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: true,        
                    glottal: true,          // but false for GAOL
                    followerTable: [
                        "B":[.B],           // BAOBAB
                        "CH":[.S, .T],      // CHAOS, CHAOTIC
                        "G":[.L],           // GAOL
                        "L":[.S, .T],       // LAOS, LAOTIAN
                        "T":[.S]],          // TAOS
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        
                        // Words ending in AO: CACAO
                        if phonemes.matchesString("CAC", matchFull: true) {
                            return true
                        }
                        else {
                            return false
                        }
                    })

let AU = VowelBlend(first: .A, second: .U, third: nil,
                    initCons: [.D, .G, .L, .R, .S, .T, .X],  // AUDIO, AUGUR, AURAL, AUSTRIAN, AUTO, AUXILIARY
                    interCons: [.B, .C, .D, .F, .G, .L, .N, .R, .S, .T, .V],
                    finalCons: [.D, .F, .L, .M, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    followerTable: [
                        "B":[.B, .D],           // BAUBLE, BAUD
                        "C":[.C, .G, .L, .S],   // CAUCUS, CAUGHT, CAUL, CAUSE
                        "CL":[.S],              // CLAUSE
                        "D":[.N, .P],           // DAUNT, DAUPHIN
                        "DR":[.G],              // DRAUGHT
                        "F":[.N],               // FAUN
                        "FL":[.N],              // FLAUNT
                        "FR":[.G],              // FRAUGHT
                        "H":[.G, .L],           // HAUGHTY, HAUL
                        "L":[.G, .N],           // LAUGH, LAUNCH/LAUNDRY
                        "M":[.L, .V],           // MAUL, MAUVE
                        "N":[.G, .T],           // NAUGHT, NAUTICAL
                        "P":[.L, .N, .S],       // PAUL, PAUNCH, PAUSE
                        "PL":[.S],              // PLAUSIBLE
                        "S":[.C, .N],           // SAUCE, SAUNTER
                        "SH":[.N],              // SHAUN
                        "T":[.G, .T],           // TAUGHT, TAUT
                        "V":[.L]],              // VAULT
                    dynFollowers: nil,
                    verifyEnd: nil)

let EA = VowelBlend(first: .E, second: .A, third: nil,
                    initCons: [.C, .R, .S, .T, .V],
                    interCons: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V],
                    finalCons: [.D, .F, .K, .L, .M, .N, .P, .R, .T],
                    blendInto: [.U],
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    followerTable: [
                        "B":[.C, .D, .G, .K, .M, .N, .R, .S, .T, .U, .V],   // BEACH, BEAD, BEAGLE, BEAK, BEAL, BEAM,
                                                                            // BEAN, BEAR, BEAST, BEAT, BEAUTY, BEAVER
                        "BL":[.C, .R],                                      // BLEACH, BLEARY
                        "BR":[.C, .D, .K, .S],                              // BREACH, BREAD, BREAK, BREAST
                        "CH":[.P, .T],                                      // CHEAP, CHEAT
                        "CL":[.N, .R, .T, .V],                              // CLEAN, CLEAR, CLEAT, CLEAVE
                        "CR":[.K, .T],                                      // CREAK, CREATE
                        "D":[.D, .F, .L, .N, .R, .T],                       // DEAD, DEAF, DEAL, DEAN, DEAR, DEATH
                        "DR":[.D],                                          // DREAD
                        "F":[.L, .R, .S, .T],                               // FEALTY, FEAR, FEAST, FEAT/HER
                        "FL":[.S],                                          // FLEAS
                        "G":[.R],                                           // GEAR
                        "GL":[.N],
                        "GR":[.T],                                          // GREAT
                        "H":[.D, .L, .P, .R, .T],                           // HEAD, HEALTH, HEAP, HEAR, HEATH
                        "KN":[.D],                                          // KNEAD
                        "L":[.C, .D, .F, .G, .K, .N, .P, .R, .S, .V],       // LEACH, LEAD, LEAF, LEAGUE, LEAK, LEAN,
                                                                            // LEAP, LEAR(N), LEAS(H/T), LEAVE
                        "M":[.D, .L, .N, .T],                               // MEAD, MEAL, MEAN, MEAT
                        "N":[.P, .R, .T],                                   // NEAP, NEAR, NEAT
                        "P":[.C, .K, .L, .R,. S, .T],                       // PEACH, PEAK, PEAL, PEAR, PEAS, PEAT
                        "PL":[.S, .T],                                      // PLEAS/E, PLEAT
                        "PR":[.C],                                          // PREACH
                        "QU":[.S],                                          // QUEASY
                        "R":[.C, .D, .L, .M, .P, .R],                       // REACH, READ, REAL, REAM, REAP, REAR
                        "S":[.L, .M, .N, .R, .S, .T],                       // SEAL, SEAM, SEAN, SEAR, SEAS, SEAT
                        "SH":[.F, .R, .T, .V],                              // SHEAF, SHEAR, SHEATH, SHEAVE
                        "SM":[.R],                                          // SMEAR
                        "SP":[.K, .R],                                      // SPEAK, SPEAR
                        "SPR":[.D],                                         // SPREAD
                        "SQU":[.L],                                         // SQUEAL
                        "ST":[.D, .K, .L, .M, .R],                          // STEAD, STEAK, STEAL, STEAM, STEAR
                        "STR":[.K, .M],                                     // STREAK, STREAM
                        "T":[.C, .K, .L, .M, .R, .S, .T],                   // TEACH, TEAK, TEAL, TEAM, TEAR, TEAS, TEAT
                        "THR":[.D, .T],                                     // THREAD, THREAT
                        "W":[.K, .L, .N, .R, .V],                           // WEAK, WEAL, WEAN, WEAR, WEAVE
                        "WR":[.T],                                          // WREATH
                        "Y":[.H, .R, .S],                                   // YEAH, YEAR, YEAS/T
                        "Z":[.L]],                                          // ZEAL
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        
                        // FLEA, LEA, PEA, PLEA, RHEA, SEA, TEA, UREA, YEA
                        if phonemes.matchesSet(["FL", "L", "P", "PL", "RH", "S", "T", "UR", "Y"]) {
                            return true
                        }
                        else {
                            return false
                        }
                    })

let EAU = VowelBlend(first: .E, second: .A, third: .U,
                    initCons: [],
                    interCons: [.T],       // BEAUTIFUL
                    finalCons: [],
                    blendInto: [],
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    followerTable: [:],
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                    
                        // Restrict ending only to BEAU
                        if phonemes.matchesString("B", matchFull: true) {
                            return true
                        }
                        else {
                            return false
                        }
                    })

let EE = VowelBlend(first: .E, second: .E, third: nil,
                    initCons: [.L, .R],        // EELS, EERIE
                    interCons: [.C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finalCons: [.D, .F, .K, .L, .M, .N, .P, .R, .T],
                    blendInto: [.I],        // for gerunds like FLEEING
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    followerTable: [
                        "B":[.C, .N, .R, .S, .T],           // BEECH, BEEN, BEER, BEES, BEET
                        "BL":[.D, .P],                      // BLEED, BLEEP,
                        "BR":[.D, .Z],                      // BREED, BREEZE
                        "CH":[.P, .R, .S, .T],              // CHEEP, CHEER, CHEESE, CHEETAH
                        "CR":[.D, .K, .L, .S],              // CREED, CREEK, CREEL, CREES
                        "D":[.D, .M, .R],                   // DEED, DEEM, DEER
                        "F":[.D, .L, .S, .T],               // FEED, FEEL, FEES, FEET
                        "FL":[.C, .I, .R, .S, .T],          // FLEECE, FLEEING, FLEER, FLEES, FLEET
                        "FR":[.D, .I, .L, .S, .Z],          // FREED, FREEING, FREELY, FREES, FREEZE
                        "G":[.K, .S],                       // GEEK, GEES
                        "GR":[.D, .K, .N, .T],              // GREED, GREEK, GREEN, GREET
                        "H":[.D, .L],                       // HEED, HEEL
                        "J":[.P, .R],                       // JEEP, JEER
                        "K":[.L, .N, .P],                   // KEEL, KEEN, KEEP
                        "KN":[.D, .L, .S],                  // KNEED, KNEEL, KNEES
                        "L":[.C, .K, .R, .S],               // LEECH, LEEK, LEER, LEES
                        "M":[.L],                           // MEELY
                        "N":[.D],                           // NEED
                        "P":[.D, .K, .L, .N, .R, .S],       // PEED, PEEK, PEEL, PEEN, PEER, PEES
                        "PR":[.N],                          // PREEN
                        "QU":[.N, .R],                      // QUEEN, QUEER
                        "R":[.D, .F, .K, .L, .S],           // REED, REEF, REEK, REEL, REES
                        "S":[.D, .I, .K, .M, .N, .P, .R, .T],  // SEED, SEEING, SEEK, SEEM, SEEN, SEEP, SEER, SEETHE
                        "SH":[.N, .P, .R, .T],              // SHEEN, SHEEP, SHEER, SHEET
                        "SL":[.K, .P, .T],                  // SLEEK, SLEEP, SLEET
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
                        "WH":[.L, .S]],                     // WHEEL, WHEES
                    dynFollowers: nil,
                    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                        let lastElement = phonemes.lastElement()
                        
                        // Trying to cast a wide net here with many possibilities:
                        // APOGEE, OVERSEE, FLEE, CAREFREE, AGREE & PEDIGREE, KNEE, THEE, TREE & THREE
                        if lastElement!.id == "G" || lastElement!.id == "S" || lastElement!.id == "FL" ||
                            lastElement!.id == "FR" || lastElement!.id == "GR" || lastElement!.id == "KN" ||
                            lastElement!.id == "TH" || lastElement!.id == "TR" || lastElement!.id == "THR" {
                            return true
                        }
                        else {
                            return false
                        }
                    })

let EI = VowelBlend(first: .E, second: .I, third: nil,
                    initCons: [.G, .T],        // EIGHT, EITHER
                    interCons: [.C, .G, .K, .L, .N, .R, .S, .T, .V, .Z],
                    finalCons: [.C, .D, .K, .L, .N, .R, .S],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    followerTable: [
                        "B":[.G, .N],       // BEIGE, BEING
                        "C":[.L],           // CEILING
                        "D":[.C, .F, .G, .S, .T],   // DEICE, DEIFY, DEIGN, DEISM/ST, DEITY
                        "F":[.G, .S],       // FEIGN, FEISTY
                        "FR":[.G],          // FREIGHT
                        "H":[.G, .S],       // HEIGHT, HEIST
                        "L":[.G, .S],       // LEIGH(T), LEIS
                        "M":[.N],           // MEIN
                        "N":[.G],           // NEIGH(BOR)
                        "P":[.G],           // PEIGNOIR
                        "PL":[.N],          // PLEIN
                        "R":[.G, .M, .N],   // REIGN, REIMAGINE, REIN
                        "S":[.Z],           // SEIZE
                        "SH":[.K],          // SHEIK
                        "SK":[.N],          // SKEIN
                        "SL":[.G],          // SLEIGH
                        "SP":[.G],          // SPEIGHT
                        "ST":[.N],          // STEIN
                        "TH":[.S],          // THEISM/T
                        "V":[.L, .N],       // VEIL, VEIN
                        "W":[.G, .R]],      // WEIGHT, WEIR
                    dynFollowers: nil,
                    verifyEnd: nil)

let EO = VowelBlend(first: .E, second: .O, third: nil,
                    initCons: [.N],        // EONS
                    interCons: [.D, .G, .L, .M, .N, .R, .S, .T],
                    finalCons: [.N, .R],        // NEON, METEOR
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: true,          // Could be false, ex. YEOMAN
                    followerTable: [
                        "FR":[.N],              // FREON
                        "G":[.D, .G, .L, .S],   // GEODE, GEOGRAPHY, GEOLOGY, GEOSPHERE
                        "L":[.N],               // LEON
                        "N":[.L, .N, .S],       // NEOLIBERAL, NEON, NEOS
                        "P":[.N],               // PEON(S/Y)
                        "R":[.C, .P, .R],       // REOCCUR, REOPERATE, REORDER
                        "Y":[.M]],              // YEOMAN
                    dynFollowers: nil,
                    verifyEnd: nil)

let EU = VowelBlend(first: .E, second: .U, third: nil,
                    initCons: [.R],       // EURO
                    interCons: [.C, .D, .R, .T],
                    finalCons: [.D],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    followerTable: [
                        "F":[.D],               // FEUD
                        "H":[.R],               // HEURISTIC
                        "N":[.R, .S, .T],       // NEURAL, NEUSE, NEUTRAL
                        "QU":[.E],              // QUEUE
                        "R":[.N, .S, .T]],      // REUNITE, REUSE, REUTTER
                    dynFollowers: nil,
                    verifyEnd: nil)

let IA = VowelBlend(first: .I, second: .A, third: nil,
                    initCons: [.M],        // IAMBS
                    interCons: [.B, .C, .D, .L, .M, .N, .P, .R, .S, .T],
                    finalCons: [.D, .L, .M, .N, .R, .T],
                    blendInto: [],
                    canPlural: true,
                    endOfWord: true,
                    glottal: true,          // could be false in some cases?
                    followerTable: [
                        "B":[.N, .S],       // BIANNUAL, BIAS
                        "D":[.L],           // DIAL
                        "DR":[.D],          // DRIAD
                        "F":[.T],           // FIAT
                        "FR":[.R],          // FRIAR
                        "G":[.N],           // GIANT
                        "GL":[.L],          // GLIAL
                        "L":[.B, .R],       // LIABLE, LIAR
                        "PL":[.B],          // PLIABLE
                        "R":[.L],           // RIAL
                        "T":[.R],           // TIARA
                        "TR":[.D, .L],      // TRIAD, TRIAL
                        "V":[.B, .D, .L]],  // VIABLE, VIADUCT, VIAL
                    dynFollowers: nil,
                    
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        let lastElement = phonemes.lastElement()
                        let penElement = phonemes.nextToLastElement()   // assuming this is non-nil
                        
                        // Trying to cover typical IA enders: MEDIA/ENCYCLOPEDIA, MANIA/CRANIA, GLIA/GANGLIA, ILIA, ZINNIA, CRITERIA
                        if (lastElement!.id == "D" && penElement!.id == "E") ||
                            (lastElement!.id == "N" && penElement!.id == "A") ||
                            lastElement!.id == "GL" || lastElement!.id == "L" ||
                            lastElement!.id == "NN" || lastElement!.id == "R" {
                            return true
                        }
                        else {
                            return false
                        }
                    })


let IE = VowelBlend(first: .I, second: .E, third: nil,
                    initCons: [],
                    interCons: [.C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .U, .V, .Z],
                    finalCons: [.D, .F, .L, .M, .N, .R, .T],
                    blendInto: [.U],        // for LIEU
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    followerTable: [
                        "B":[.N, .R],           // BIENNIAL, BIER
                        "BR":[.F],              // BRIEF
                        "CH":[.F],              // CHIEF
                        "CR":[.D, .R, .S],      // CRIED, CRIER, CRIES
                        "D":[.D, .S, .T],       // DIED, DIES, DIET
                        "DR":[.D, .R, .S],      // DRIED, DRIER, DRIES
                        "F":[.F, .L, .R, .S],   // FIEFDOM, FIELD, FIERY, FIES
                        "FL":[.R, .S],          // FLIER, FLIES
                        "FR":[.D, .S],          // FRIED, FRIES
                        "GR":[.F, .V],          // GRIEF, GRIEVE
                        "H":[.R],               // HIERARCHY
                        "L":[.D, .G, .N, .S, .U],   // LIED, LIEGE, LIEN, LIES, LIEU
                        "M":[.N],               // MIEN
                        "N":[.C],               // NIECE
                        "P":[.C, .D, .R, .S, .T],   // PIECE, PIED, PIER(CE), PIES, PIETY
                        "PL":[.D, .R, .S],      // PLIED, PLIER, PLIES
                        "PR":[.D, .R, .S],      // PRIED, PRIER, PRIES
                        "QU":[.T],              // QUIET
                        "S":[.G, .V],           // SIEGE, SIEVE
                        "SH":[.D, .L, .R, .S],  // SHIED, SHIELD, SHIER, SHIES
                        "SHR":[.K],             // SHRIEK
                        "SP":[.D, .L, .R, .S],  // SPIED, SPIEL, SPIER, SPIES
                        "SPR":[.R, .S],         // SPRIER, SPRIEST
                        "ST":[.S],              // STIES
                        "T":[.D, .R, .S],       // TIED, TIER, TIES
                        "TH":[.F, .V],          // THIEF, THIEVES
                        "TR":[.D, .R, .S],      // TRIED, TRIER, TRIES
                        "V":[.D, .R, .S, .W],   // VIED, VIES, VIER, VIEW
                        "W":[.L],               // WIELD
                        "Y":[.L]],              // YIELD
                    dynFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                        let lastElement = phonemes.lastElement()
                        
                        // this allows for VIEW and related words (PREVIEW, REVIEW, OVERVIEW)
                        if lastElement != nil && lastElement!.id == "V" {
                            return [.W]
                        }
                            
                        // this allows for LIEU only at the end of a word
                        else if pos == .positionLAST && phonemes.matchesString("L", matchFull: true) {
                            return [.U]
                        }
                            
                        else {
                            return []
                        }
                    },
                    verifyEnd: nil)

let IEU = VowelBlend(first: .I, second: .E, third: .U,
                     initCons: [],
                     interCons: [],
                     finalCons: [],
                     blendInto: [],
                     canPlural: false,
                     endOfWord: true,
                     glottal: false,
                     followerTable: [:],
                     dynFollowers: nil,
                     verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        let lastElement = phonemes.lastElement
                        
                        if lastElement()!.id == "L" {
                            return true
                        }
                        else {
                            return false
                        }
                    })

let II = VowelBlend(first: .I, second: .I, third: nil,
                    initCons: [],
                    interCons: [],
                    finalCons: [],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: true,
                    followerTable: [
                        "SK":[.N]],
                    dynFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) -> [Letter] in
                        let lastElement = phonemes.lastElement()
                        
                        // SKIING is the only word with II
                        if lastElement != nil && lastElement!.id == "SK" {
                            return [.N]
                        }
                        else {
                            return []
                        }
                    },
                    verifyEnd: nil)

let IO = VowelBlend(first: .I, second: .O, third: nil,
                    initCons: [.N, .T],        // IONS, IOTA
                    interCons: [.D, .M, .N, .R, .S, .T],
                    finalCons: [.D, .N, .R, .S, .T],
                    blendInto: [.U],        // xIOUS ending
                    canPlural: true,
                    endOfWord: true,        // BRIO, TRIO
                    glottal: false,
                    followerTable: [
                        "B":[.D, .G, .L, .S],   // BIODOME, BIOGRAPHY, BIOLOGY, BIOSPHERE
                        "BR":[.S],              // BRIOS
                        "L":[.N],               // LION
                        "P":[.U],               // PIOUS
                        "R":[.T],               // RIOT
                        "PR":[.R],              // PRIOR
                        "TR":[.S],              // TRIOS
                        "V":[.L]],              // VIOLENT
                    dynFollowers: nil,
                    verifyEnd: nil)

let IU = VowelBlend(first: .I, second: .U, third: nil,
                    initCons: [],
                    interCons: [.M, .S],
                    finalCons: [.M],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    followerTable: [:],
                    dynFollowers: nil,
                    verifyEnd: nil)

let OA = VowelBlend(first: .O, second: .A, third: nil,
                    initCons: [.F, .K, .R, .S, .T],        // OAFS, OAKS, OARS, OAST, OATS
                    interCons: [.C, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T, .V],
                    finalCons: [.D, .F, .K, .L, .M, .N, .P, .R, .S, .T],
                    blendInto: [],
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    followerTable: [
                        "B":[.R, .S, .T],               // BOAR, BOAST, BOAT
                        "C":[.C, .L, .S, .T],           // COACH, COAL, COAST, COAT
                        "CR":[.K],                      // CROAK
                        "F":[.L, .M],                   // FOAL, FOAM
                        "G":[.L],                       // GOAL
                        "H":[.R],                       // HOAR(D/Y)
                        "L":[.D, .F, .M, .N, .V],       // LOAD, LOAF, LOAM, LOAN, LOAVES
                        "M":[.N, .T],                   // MOAN, MOAT
                        "P":[.C],                       // POACH
                        "R":[.C, .D, .M, .N, .R, .S],   // ROACH, ROAD, ROAM, ROAN, ROAR, ROAST
                        "S":[.K, .P, .R],               // SOAK, SOAP, SOAR
                        "SH":[.T],                      // SHOAT
                        "ST":[.T],                      // STOAT
                        "T":[.D, .S],                   // TOAD, TOAST
                        "THR":[.T]],                    // THROAT
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        
                        // Words ending in OA: BOA, STOA, COCOA
                        if phonemes.matchesSet(["B", "ST", "COC"]) {
                            return true
                        }
                        else {
                            return false
                        }
                    })

let OE = VowelBlend(first: .O, second: .E, third: nil,
                    initCons: [.N],
                    interCons: [.D, .M, .R, .S, .T],
                    finalCons: [.D, .M, .R, .S, .T],
                    blendInto: [.I],
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    followerTable: [
                        "C":[.X],               // COEXIST
                        "D":[.R, .S],           // DOER, DOES
                        "F":[.S],               // FOES
                        "FL":[.S],              // FLOES
                        "G":[.R, .S],           // GOER, GOES
                        "H":[.D, .I, .R, .S],   // HOED, HOEING, HOER, HOES
                        "J":[.L, .S],           // JOEL, JOES
                        "N":[.S],               // NOES
                        "P":[.M, .T],           // POEM, POET
                        "R":[.S],               // ROES
                        "SH":[.D, .R, .S],      // SHOED, SHOER, SHOES
                        "SL":[.S],              // SLOES
                        "T":[.D, .I, .S],       // TOED, TOEING, TOES
                        "THR":[.S],             // THROES,
                        "W":[.S]],              // WOES
                    dynFollowers: nil,
                    verifyEnd: nil)

let OI = VowelBlend(first: .O, second: .I, third: nil,
                    initCons: [.L],        // OILS
                    interCons: [.C, .D, .F, .L, .N, .R, .S, .T, .V],
                    finalCons: [.C, .D, .L, .N, .R],
                    blendInto: [],
                    canPlural: false,       // but KOI perhaps?
                    endOfWord: false,
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
                        "J":[.N, .S],           // JOIN(T), JOIST
                        "L":[.N, .T],           // LOIN, LOITER
                        "M":[.R, .S],           // MOIRE, MOIST
                        "N":[.R],               // NOIRE
                        "P":[.N],               // POINT
                        "R":[.L],               // ROIL
                        "S":[.L, .R],           // SOIL, SOIREE
                        "ST":[.C],              // STOIC
                        "T":[.L],               // TOIL
                        "V":[.C]],              // VOICE
                    dynFollowers: nil,
                    verifyEnd: nil)

let OO = VowelBlend(first: .O, second: .O, third: nil,
                    initCons: [.Z],        // OOZE
                    interCons: [.B, .C, .D, .F, .G, .I, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finalCons: [.B, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T],
                    blendInto: [.E, .I],        // GOOEY, gerunds like WOOING
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    followerTable: [
                        "B":[.B, .E, .G, .I, .K, .L, .M, .N, .R, .S, .T], // BOOB, BOOED, BOOING, BOOGER, BOOK, BOOLEAN,
                                                                          // BOOM, BOON, BOOR, BOOST, BOOT
                        "BL":[.D, .P],                          // BLOOD, BLOOP
                        "BR":[.D],                              // BROOD
                        "C":[.C, .E, .I, .K, .L, .N, .P, .S, .T],   // COOCH, COOED, COOING, COOK, COOL, COON, COOP, COOS, COOT
                        "CH":[.S],                              // CHOOSE
                        "D":[.M, .R, .S],                       // DOOM, DOOR, DOOS
                        "DR":[.L, .P],                          // DROOL, DROOP
                        "F":[.L],                               // FOOL
                        "FL":[.R],                              // FLOOR
                        "G":[.C, .E, .F, .N, .P, .S],           // GOOCH, GOOEY, GOOF, GOON, GOOP, GOOS(E)
                        "GR":[.V],                              // GROOVE
                        "H":[.C, .F, .K, .P, .S, .V],           // HOOCH, HOOF, HOOK, HOOP, HOOS, HOOVES
                        "L":[.K, .M, .N, .P, .S, .T],           // LOOK, LOOM, LOON, LOOP, LOOS(E), LOOT
                        "M":[.C, .E, .I, .N, .R, .S, .T],       // MOOCH, MOOED, MOOING, MOOR, MOOS(E), MOOT
                        "N":[.K, .N, .S],                       // NOOK, NOON, NOOSE
                        "P":[.C, .F, .L, .P, .R, .S],           // POOCH, POOF, POOL, POOP, POOR, POOS
                        "PH":[.E],                              // PHOOEY
                        "PR":[.F],                              // PROOF
                        "R":[.F, .K, .M, .S, .T],               // ROOF, ROOK, ROOM, ROOS(T), ROOT
                        "S":[.N, .T],                           // SOON, SOOT
                        "SC":[.P, .T],                          // SCOOP, SCOOT
                        "SCH":[.L, .N],                         // SCHOOL, SCHOONER
                        "SH":[.E, .I, .K, .S, .T],              // SHOOED, SHOOING, SHOOK, SHOOS, SHOOT
                        "SL":[.P],                              // SLOOP
                        "SM":[.C],                              // SMOOCH
                        "SN":[.K, .P, .T, .Z],                  // SNOOKER, SNOOP, SNOOT, SNOOZE
                        "SP":[.K, .L, .N],                      // SPOOK, SPOOL, SPOON
                        "ST":[.D, .L, .P],                      // STOOD, STOOL, STOOP
                        "SW":[.N, .P],                          // SWOON, SWOOP
                        "T":[.K, .L],                           // TOOK, TOOL
                        "W":[.D, .E, .F, .I, .L, .S],           // WOOD, WOOED, WOOF, WOOING, WOOL, WOOS
                        "WH":[.P, .S],                          // WHOOP, WHOOSH
                        "V":[.D],                               // VOODOO
                        "Z":[.M, .S]],                          // ZOOM, ZOOS
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in

                        // Final OO words: BOO, COO, GOO, MOO, WOO, ZOO, SHOO, IGLOO, TABOO, VOODOO
                        if phonemes.matchesSet(["B", "C", "G", "M", "W", "Z", "SH", "IGL", "TAB", "VOOD"]) {
                            return true
                        }
                        else {
                            return false
                        }
                    })

let OU = VowelBlend(first: .O, second: .U, third: nil,
                    initCons: [.N, .R, .S, .T],    // OUNCE, OURS, OUST, OUTS
                    interCons: [.B, .C, .D, .F, .G, .L, .N, .P, .Q, .R, .S, .T, .V, .Z],
                    finalCons: [.D, .F, .L, .N, .P, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,       // what about SOUS?
                    endOfWord: false,
                    glottal: false,
                    followerTable: [
                        "B":[.D, .G, .L, .N, .T],       // BOUDOIR, BOUGHT, BOULDER, BOUND, BOUT
                        "BL":[.S],                      // BLOUSE
                        "C":[.L, .R],                   // COULE/COULD, COURAGE/COURT
                        "CL":[.T],                      // CLOUT
                        "D":[.B, .R],                   // DOUBT, DOUR
                        "F":[.G, .L, .N, .R],           // FOUGHT, FOUL, FOUND, FOUR
                        "FL":[.N, .R],                  // FLOUNDER, FLOUR
                        "G":[.T],                       // GOUT
                        "GR":[.T],                      // GROUT
                        "H":[.N, .R, .S],               // HOUND, HOUR, HOUSE
                        "J":[.L, .S],                   // JOULE, JOUST
                        "L":[.D, .S, .T],               // LOUD, LOUSE, LOUT
                        "M":[.N, .R, .S, .T],           // MOUND, MOURN, MOUSE, MOUTH
                        "N":[.N],                       // NOUN
                        "P":[.C, .L, .N, .R, .T],       // POUCH, POULTRY, POUND, POUR, POUT
                        "PL":[.G],                      // PLOUGH
                        "R":[.G, .L, .N, .S, .T],       // ROUGH,
                        "S":[.G, .L, .N, .P, .R, .S, .T],   // SOUGHT, SOUL, SOUND, SOUP, SOUR, SOUSE, SOUTH
                        "SC":[.R],                      // SCOUR
                        "SH":[.L, .T],                  // SHOULD, SHOUT
                        "SHR":[.D],                     // SHROUD
                        "SL":[.C],                      // SLOUCH
                        "SN":[.T],                      // SNOUT
                        "SP":[.T],                      // SPOUT
                        "SPR":[.T],                     // SPROUT
                        "ST":[.T],                      // STOUT
                        "T":[.C, .G],                   // TOUCH, TOUGH
                        "TR":[.G, .S],                  // TROUGH, TROUSERS
                        "W":[.L, .N],                   // WOULD, WOUND
                        "Y":[.R, .T]],                  // YOUR, YOUTH
                    dynFollowers: nil,
                    verifyEnd: nil)

let UA = VowelBlend(first: .U, second: .A, third: nil,
                    initCons: [],
                    interCons: [.B, .C, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finalCons: [.D, .F, .L, .M, .N, .R, .T],        // QUAY?
                    blendInto: [.U],
                    canPlural: false,
                    endOfWord: false,
                    glottal: true,
                    followerTable: [
                        "D":[.L],           // DUAL
                        "L":[.U],           // LUAU
                        "N":[.N]],          // NUANCE
                    dynFollowers: nil,
                    verifyEnd: nil)

let UE = VowelBlend(first: .U, second: .E, third: nil,
                    initCons: [],
                    interCons: [.D, .L, .N, .R, .S, .T],
                    finalCons: [.D, .L, .R, .T],
                    blendInto: [],
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    followerTable: [
                        "BL":[.D, .R, .S],          // BLUED, BLUER, BLUES
                        "C":[.D, .I, .R, .S],       // CUED, CUEING, CUER, CUES
                        "CL":[.D, .I, .R, .S],      // CLUED, CLUEING, CLUER, CLUES
                        "CR":[.L],                  // CRUEL
                        "D":[.L, .S],               // DUEL, DUES
                        "F":[.L],                   // FUEL(S)
                        "FL":[.S],                  // FLUES
                        "G":[.S],                   // GUESS & GUEST
                        "GL":[.D, .I, .R, .S],      // GLUED, GLUEING, GLUER, GLUES
                        "GR":[.L],                  // GRUEL
                        "H":[.D, .R, .S],           // HUED, HUER, HUES
                        "R":[.D, .I, .R, .S],       // RUED, RUEING, RUER, RUES
                        "S":[.D, .R, .S, .T],       // SUED(E), SUER, SUES, SUET
                        "SL":[.S],                  // SLUES
                        "TR":[.D, .R],              // TRUED, TRUER
                        "V":[.S]],                  // VUES?
                    dynFollowers: nil,
                    verifyEnd: nil)

let UI = VowelBlend(first: .U, second: .I, third: nil,
                    initCons: [],
                    interCons: [.C, .D, .L, .N, .R, .S, .T],
                    finalCons: [.D, .L, .N, .R, .T],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: true,            // ENNUI
                    glottal: false,              // but true for RUIN, SUICIDE, TRUISM
                    followerTable: [
                        "B":[.L],               // BUILD
                        "BR":[.N],              // BRUIN
                        "DR":[.D],              // DRUID
                        "FL":[.D],              // FLUID
                        "G":[.D, .L, .S],       // GUIDE, GUILD/GUILT, GUISE
                        "J":[.C],               // JUICE
                        "R":[.N],               // RUIN
                        "S":[.C, .N, .T],       // SUICIDE, SUING, SUIT
                        "SL":[.C],              // SLUICE
                        "TR":[.S]],             // TRUISM
                    dynFollowers: nil,
                    verifyEnd: nil)

let UO = VowelBlend(first: .U, second: .O, third: nil,
                    initCons: [],
                    interCons: [.R, .S],
                    finalCons: [.R, .Y],
                    blendInto: [.U],        // VIRTUOUS
                    canPlural: true,
                    endOfWord: false,     
                    glottal: true,
                    followerTable: [
                        "B":[.Y],           // BUOY
                        "D":[.S],           // DUOS
                        "M":[.N]],          // MUON
                    dynFollowers: nil,
                    verifyEnd: nil)

let UU = VowelBlend(first: .U, second: .U, third: nil,
                    initCons: [],
                    interCons: [.M],       // VACUUM
                    finalCons: [.M],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    followerTable: [:],
                    dynFollowers: nil,
                    verifyEnd: nil)

let vowelBlendMap = ["AA":AA, "AE":AE, "AI":AI, "AO":AO, "AU":AU,
    "EA":EA, "EE":EE, "EI":EI, "EO":EO, "EU":EU, "EAU":EAU,
    "IA":IA, "IE":IE, "II":II, "IO":IO, "IU":IU, "IEU":IEU,
    "OA":OA, "OE":OE, "OI":OI, "OO":OO, "OU":OU,
    "UA":UA, "UE":UE, "UI":UI, "UO":UO, "UU":UU ]
