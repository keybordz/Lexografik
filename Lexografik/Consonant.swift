//
//  Consonant.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class Consonant: LexicalLetter, PhoneticFollowers {
    let blendStart: [Letter]
    let blendInto: [Letter]
    let defFinal: [Letter]
    let hardStops: [Letter]
    let allowedVowels: [Letter]
    let blendsWithY: Bool
    let dipthong: Bool
    let liquidBlend: Bool
    let followerTable: [String:[Letter]]
    
    func initialFollowers(nRemain: Int) -> [Letter] {
        var initFollowers: [Letter] = blendStart + allowedVowels
        if blendsWithY {
            initFollowers += [.Y]
        }
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
        let lastElement = pea.lastElement()
        var midFollowers: [Letter]
        
        // Only vowels allowed if this follows a diphthong like AW, AH
        if lastElement is DiphthongBlend {
            midFollowers = allowedVowels
        }
        else {
            midFollowers = blendInto + allowedVowels + hardStops
        }
        
        if blendsWithY {
            midFollowers += [.Y]
        }
        
        if dynFollowers != nil {
            midFollowers += self.dynFollowers!(pea, .positionMIDDLE)
        }
        return midFollowers
    }
    
    func lastFollowers(pea: PhoneticElementArray) -> [Letter] {
        let lastElement = pea.lastElement()
        var lastFollowers: [Letter]
        
        // If following a diphthong, only allow final E
        if lastElement is DiphthongBlend {
            if allowedVowels.contains(.E) {
                lastFollowers = [.E]
            }
            else {
                lastFollowers = []
            }
        }
        else {
            lastFollowers = defFinal
        }
        if blendsWithY {
            lastFollowers += [.Y]
        }
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
    
    init(id: Letter,
         blendStart: [Letter],
         blendInto: [Letter],
         defFinal: [Letter],
         hardStops: [Letter],
         allowedVowels: [Letter],
         blendsWithY: Bool,
         canStart: Bool,
         canEnd: Bool,
         canPlural: Bool,
         dipthong: Bool,
         liquidBlend: Bool,
         followerTable: [String:[Letter]],
         dynamicFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?,
         verifyEnd: ((PhoneticElementArray) -> Bool)?) {

        self.blendStart = blendStart
        self.blendInto = blendInto
        self.defFinal = defFinal
        self.hardStops = hardStops
        self.allowedVowels = allowedVowels
        self.blendsWithY = blendsWithY
        self.dipthong = dipthong
        self.liquidBlend = liquidBlend
        self.followerTable = followerTable
        super.init(first: id, second: nil, third: nil,
                   canStart: canStart, canEnd: canEnd, canPlural: canPlural,
                   dynFollowers: dynamicFollowers)
        
        if canEnd {
            if verifyEnd == nil {
                self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
            }
            else {
                self.verifyEndOfWord = verifyEnd
            }
        }

        else {
            self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
            
            // If there's a conditional test for the end, then use it to verify pluralization
            self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in
                                    let testPhonemes = PhoneticElementArray(pea: phonemes)
                                    testPhonemes.removeLastElement()
                                    return self.verifyEndOfWord!(testPhonemes)
                                }
        }
    }
}

// CONSONANTS
let B = Consonant(id: .B,
                  blendStart: [.L, .R],
                  blendInto: [.B, .L, .R],
                  defFinal: [.B, .E],
                  hardStops: [.C, .D, .F, .J, .N, .S, .T],   // ABCESS, ABDICATE, ABNEGATE, OBFUSCATE, OBJECT, OBSTRUCT, OBTAIN
                  allowedVowels: allVowels,
                  blendsWithY: true,
                  canStart: true,
                  canEnd: true,
                  canPlural: true,
                  dipthong: false,
                  liquidBlend: true,
                  followerTable: [
                    "A":[.A, .B, .D, .E, .H, .I, .L, .N, .O, .R, .U, .Y],
                    "E":[.B, .U],
                    "I":[.E, .I],
                    "O":[.D, .E, .F, .J, .L, .S, .T]],
                  dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
                    
                        // Allow T follower only for DEBT, DOUBT
                        if phonemes.matchesSet(["DE", "DOU"]) {
                            return [.T]
                        }
                    
                        // Allow final I for ALIBI
                        else if posIndicator == .positionLAST && phonemes.matchesString("ALI", matchFull: true) {
                            return [.I]
                        }
                            
                        else {
                            return []
                        }
                    },
                  verifyEnd: nil)

let C = Consonant( id: .C,
    blendStart: [.H, .L, .R],
    blendInto: [.C, .H, .K, .R, .T],
    defFinal: [.E, .H, .K, .T],
    hardStops: [.M, .N, .S],                           
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.C, .E, .H, .I, .M, .N, .O, .R, .T],   // ACCOUNT, ACES, ACHE, ACID, ACME, ACNE, ACORN, ACROSS, ACTIVE
        "E":[.C, .O, .R, .S, .T, .U],
        "EA":[.H],
        "I":[.E, .I, .O, .T, .Y],
        "O":[.C, .H, .R, .T, .U]],                  // OCCUR, OCHRE, OCRA, OCTAGON, OCULAR
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        var followers: [Letter] = []
        
        if posIndicator == .positionLAST {
            let lastElement = phonemes.lastElement()
            
            // Allow final I for FOCI & LOCI
            if phonemes.matchesString("FO", matchFull: true) || phonemes.matchesString("LO", matchFull: true) {
                followers += [.I]
            }
            
            // Allow final A & O if preceding vowel is I, or (PICA/PICO or COCA/LOCO)
            if (lastElement!.id == "I" || lastElement!.id == "O") {
                followers += [.A, .O]
            }
            
            // Allow final O if preceding vowel is A (TACO)
            else if lastElement!.id == "A" {
                followers += [.O]
            }
        }
        return followers
    },
    
    verifyEnd: nil)


let D = Consonant( id: .D,
    blendStart: [.R],
    blendInto: [.D, .G, .J, .L, .R],
    defFinal: [.E],
    hardStops: [.B, .F, .H, .N],            // CARDBOARD, GADFLY, BLOODHOUND, GOODNESS
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: ["A":[.A, .B, .D, .E, .J, .O, .R, .U, .V, .Z],
                    "AI":[.E, .I, .S],
                    "E":[.D, .G, .I, .U],
                    "I":[.E, .I, .L, .O],
                    "O":[.D, .E, .I, .O, .U],
                    "U":[.D]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        var followers:[Letter] = []
        

        if posIndicator == .positionLAST {
            
            // Allow final I for WADI
            if phonemes.matchesString("WA", matchFull: true) {
                followers += [.I]
            }
            
            // Approve final O for KUDO, LIDO, REDO, UNDO, OUTDO
            if phonemes.matchesSet(["KU", "LI", "RE", "UN", "OUT"]) {
                followers += [.O]
            }
            
            // Approve final A for CICADA
            if phonemes.matchesSet(["CICA"]) {
                followers += [.A]
            }
        }

        return followers
    },
    verifyEnd: nil)

let F = Consonant( id: .F,
    blendStart: [.L, .R],
    blendInto: [.F, .R, .T],            // do we need L here for WAFFLE?
    defFinal: [.E, .F, .T],
    hardStops: [.B, .H, .S],            // OFFBEAT, OFFHAND, OFFSITE
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.A, .F, .I, .L, .R, .T],
        "E":[.F],
        "I":[.F],
        "O":[.F, .T],
        "OA":[.S]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        var followers:[Letter] = []
        
        // Allow final U for SNAFU, TOFU
        if posIndicator == .positionLAST {
            
            if phonemes.matchesString("SNA", matchFull: true) || phonemes.matchesString("TO", matchFull: true) {
                followers += [.U]
            }
        }
        
        return followers
    },
    verifyEnd: nil)

let G = Consonant( id: .G,
    blendStart: [.L, .N, .R],
    blendInto: [.G, .H, .N],            // H & N should blend only after I or EI (SIGH, SLEIGH, ALIGN, SIGN, REIGN)
    defFinal: [.E, .H, .N],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.A, .E, .G, .L, .I, .O, .R, .U],
        "AE":[.I],          // AEGIS
        "AU":[.E],
        "E":[.A, .G, .O],
        "EA":[.E],
        "EI":[.H],          // EIGHT
        "I":[.G, .L],
        "O":[.D, .L, .R],
        "U":[.G]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers:[Letter] = []
        
        if pos == .positionLAST {
            
            // Approve final followers for YOGA, YOGI
            if phonemes.matchesString("YO", matchFull: true) {
                followers += [.A, .I]
            }
            
            // If preceding vowel is A or O, then allow both A & O to follow at the end (SAGO, SAGA, LOGO, TOGA)
            if phonemes.lastElement()!.id == "A" || phonemes.lastElement()!.id == "O" {
                followers += [.A, .O]
            }
        }
        
        return followers
    },
    
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
    blendInto: [.M, .R, .T],              // M blend only for OHM
    defFinal: [.M, .N, .T],               // JOHN, may need other blends with L, R
    hardStops: [.D, .H, .S],              // WITHDRAWN, WITHHOLD, WITHSTOOD,
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: true,
    liquidBlend: false,
    followerTable: [:],          // no vowels here since this is a diphthong
    dynamicFollowers: nil,
    verifyEnd: nil)

let J = Consonant( id: .J,
    blendStart: [],
    blendInto: [],
    defFinal: [.A, .O, .J],             // RAJA, BANJO, HAJJ?
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: false,
    canStart: true,
    canEnd: false,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A],           // AJAR
        "E":[.A, .E]],      // EJACULATE, EJECT
    dynamicFollowers: nil,
    verifyEnd: nil)

let K = Consonant( id: .K,
    blendStart: [.L, .N, .R],
    blendInto: [.L, .N, .R],
    defFinal: [.E],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.I],       // AKIN
        "I":[.O],       // IKON (yes)
        "O":[.A],       // OKAY
        "OA":[.E, .S],  // OAKEN, OAKS
        "U":[.E]],      // UKELELE
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
    
        if posIndicator == .positionLAST {
            
            // Allow final U for HAIKU
            if phonemes.matchesString("HAI", matchFull: true)  {
                return [.U]
            }
            
            // Allow final I for RAKI, SAKI
            else if phonemes.matchesSet(["RA", "SA"]) {
                return [.I]
            }
            
            // Allow final O for SHAKO
            else if phonemes.matchesString("SHA", matchFull: true)  {
                return [.O]
            }
            
            // final A's?
            else {
                return []
            }
        }
        else {
            return []
        }
    },
    verifyEnd: nil)

let L = Consonant( id: .L,
    blendStart: [.L],                   // only for LLAMA
    blendInto: [.B, .C, .D, .F, .G, .K, .L, .M, .P, .S, .T, .V],
    defFinal: [.B, .D, .E, .F, .L, .M, .P, .T],
    hardStops: [.N],                    // ULNA
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .B, .D, .E, .G, .I, .K, .L, .M, .O, .P, .S, .T, .U, .V, .W],
        "AI":[.E, .I, .S],
        "AW":[.S],
        "E":[.A, .B, .D, .E, .F, .G, .I, .K, .L, .M, .O, .P, .S, .T, .U],
        "EE":[.S, .Y],                      // EELS, EELY
        "I":[.I, .L],
        "O":[.D, .E, .I, .L],
        "OI":[.E, .I, .S, .Y],              // OILED, OILING, OILS, OILY
        "U":[.C, .N, .S, .T]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers:[Letter] = []
        
        if pos == .positionLAST {
            
            // Approve final I for DELI
            if phonemes.matchesString("DE", matchFull: true) {
                followers += [.I]
            }
            
            // Approve final O for HALO, KILO, SOLO, VELO
            if phonemes.matchesSet(["HA", "KI", "SO", "VE"]) {
                followers += [.O]
            }
            
            // Only allow LN blend at end for KILN
            if phonemes.matchesString("KI", matchFull: true) {
                followers += [.N]
            }
                
            // Only allow LC blend at end for TALC
            if phonemes.matchesString("TA", matchFull: true) {
                followers += [.C]
            }
        }
        
        return followers
    },
    verifyEnd: nil)

let M = Consonant( id: .M,
    blendStart: [],
    blendInto: [.B, .M, .P],
    defFinal: [.B, .E, .O, .P, .Y],
    hardStops: [.H, .L, .N],                     // HAMLET, OMNIBUS
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .B, .E, .H, .I, .M, .O, .P, .U, .Y],
        "AI":[.E, .I, .S],
        "E":[.A, .B, .C, .E, .I, .M, .O, .P, .U],
        "I":[.A, .B, .I, .M],
        "O":[.A, .E, .I, .N],
        "U":[.B]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            let lastElement = phonemes.lastElement()
            
            // Allow final I for SALAMI & SWAMI
            if phonemes.matchesSet(["SALA", "SWA"]) {
                followers += [.I]
            }
                
            // Allow N follower for AUTUMN, COLUMN, SOLEMN
            if phonemes.matchesSet(["AUTU", "COLU", "SOLE"]) {
                followers += [.N]
            }
            
            // Final A words: LIMA, MAMA, COMA, MELANOMA
            if lastElement!.id == "A" || lastElement!.id == "I" || lastElement!.id == "O" {
                followers += [.A]
            }
        }

        return followers
    },
    verifyEnd: nil)

let N = Consonant( id: .N,
    blendStart: [.Y],
    blendInto: [.C, .D, .G, .K, .N, .S, .T],
    defFinal: [.C, .D, .E, .G, .K, .N, .T],
    hardStops: [.B, .F, .J, .L, .M, .P, .V, .W, .Z],   // INBRED, INFER, BANJO, INLET, INMATE, INPUT, INVITE, ENZYME, WAINWRIGHT
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .C, .D, .G, .E, .I, .K, .N, .O, .S, .T, .U, .V, .Y],
        "E":[.A, .C, .D, .E, .I, .L, .M, .N, .O, .S, .T, .U, .V, .Z],
        "EO":[.S],              // EONS
        "I":[.A, .C, .D, .E, .F, .G, .I, .J, .K, .L, .N, .O, .P, .S, .T, .V],
        "IO":[.S],              // IONS
        "O":[.E, .L, .S, .T, .U],
        "OE":[.O],              // OENOPHILE
        "U":[.A, .B, .C, .D, .E, .F, .G, .H, .I, .K, .L, .M, .N, .O, .P, .R, .S, .T, .U, .V, .W, .Y, .Z]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            let lastElement = phonemes.lastElement()

            // Approve final I for RANI
            if phonemes.matchesString("RA", matchFull: true) {
                followers += [.I]
            }
            
            // Final NA words: CORONA, HYENA, MYNA, VINA (might need to make this more general)
            if phonemes.matchesSet(["COR", "HYE", "MY", "VI"]) {
                followers += [.A]
            }
            
            // Approve final O for words like VOLCANO, KENO, ALBINO, CASINO, MONO
            if lastElement!.id != "U" {
                followers += [.O]
            }
        }
            
        return followers
    },
    verifyEnd: nil)

let P = Consonant( id: .P,
    blendStart: [.H, .L, .R, .S],
    blendInto: [.P, .S, .T],
    defFinal: [.E, .H, .T],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.A, .E, .H, .I, .L, .N, .O, .P, .R, .S, .T, .U],
        "E":[.A, .H, .I, .S],
        "O":[.A, .E, .I, .P, .T, .U],
        "OO":[.S],
        "U":[.B, .D, .E, .L, .O, .R, .S, .T, .V]],
    dynamicFollowers: nil,
    verifyEnd: nil)

let Q = Consonant( id: .Q,
    blendStart: [],
    blendInto: [],
    defFinal: [],
    hardStops: [],
    allowedVowels: [.U],
    blendsWithY: false,
    canStart: true,
    canEnd: false,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    followerTable: ["A":[.U], "E":[.U]],
    dynamicFollowers: nil,
    verifyEnd: nil )

let R = Consonant( id: .R,
    blendStart: [.H],                       // RH can only generate Y followers, ex. RHYME, RHYTHM
    blendInto: [.B, .C, .D, .F, .G, .H, .K, .L, .M, .N, .P, .R, .S, .T, .V],
    defFinal: [.B, .D, .E, .F, .G, .K, .L, .M, .N, .O, .P, .T],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .B, .C, .D, .E, .F, .G, .I, .K, .L, .M, .O, .P, .R, .S, .T, .U],
        "AA":[.D],                      // AARDVARK
        "AE":[.A, .I, .O],              // AERATE, AERIE, AEROBIC
        "AI":[.E, .S, .Y],              // AIRE, AIRS, AIRY
        "AO":[.T],                      // AORTA
        "AU":[.A, .O],                  // AURA, AURORA
        "E":[.A, .B, .C, .D, .E, .G, .H, .I, .O, .R, .S, .T],
        "EA":[.G, .L, .N, .S, .T],      // EAGER, EARL, EARN, EARS, EARTH
        "EE":[.I],                      // EERIE
        "I":[.A, .E, .I, .K, .O, .R],
        "O":[.A, .B, .C, .D, .E, .G, .I, .N, .O, .P, .U],           // ORPHAN
        "OA":[.E, .I, .S],              // OARED, OARING, OARS
        "OU":[.S],                      // OURS
        "U":[.A, .E, .G, .I, .N, .O, .S, .U]],      // URANUS, UREA, URGE, URI?, URNS, UROLOGY, URSING, URSU?
    
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            let lastElement = phonemes.lastElement()
            
            // Allow final I for SAFARI, SARI, TORI
            if phonemes.matchesSet(["SA", "SAFA", "TO"]) {
                followers += [.I]
            }
            
            // Final RO words incude: TARO, HERO, TORO
            if lastElement!.id == "A" || lastElement!.id == "E" || lastElement!.id == "O" {
                followers += [.O]
            }
            
            // Approve final A for LIRA, TIARA, others?
            if phonemes.matchesSet(["LI", "TIA"]) {
                followers += [.A]
            }
        }

        return followers
    },
    verifyEnd: nil)

let S = Consonant(id: .S,
    blendStart: [.C, .H, .K, .L, .M, .N, .P, .Q, .T, .W],
    blendInto: [.C, .H, .K, .L, .M, .N, .P, .Q, .S, .T, .W],
    defFinal: [.C, .E, .H, .K, .M, .P, .S, .T],         // MESA, PESO
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.B, .C, .G, .H, .I, .K, .L, .P, .S, .T, .W],
        "AI":[.L],
        "E":[.C, .H, .P, .Q, .S, .T],
        "EA":[.E, .I, .T, .Y],              // EASE(L), EASILY, EAST, EASY
        "I":[.L, .S],
        "O":[.H, .I, .M, .P, .S, .T],
        "OA":[.E, .I, .T],                  // OASES, OASIS, OAST
        "OU":[.T],                          // OUST
        "U":[.A, .E, .H, .I, .T, .U]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            let lastElement = phonemes.lastElement()
            
            // Approve A follower for MESA
            if phonemes.matchesSet(["ME"]) {
                followers += [.A]
            }
            
            // Approve O follower for PESO
            if phonemes.matchesSet(["PE"]) {
                followers += [.O]
            }
            
        }
        return followers
},
    verifyEnd: nil)

let T = Consonant( id: .T,
    blendStart: [.H, .R, .W, .Y],
    blendInto: [.C, .H, .R, .T, .Z],
    defFinal: [.E, .H, .T, .Z],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.E, .H, .I, .L, .O, .R, .T],
        "E":[.C, .H, .N, .T],
        "EA":[.E, .I, .S],          // EATEN, EATING, EATS
        "I":[.A, .C, .E, .S, .T],
        "IO":[.A],                  // IOTA
        "O":[.H, .I, .T],
        "OA":[.E, .H, .S],          // OATEN, OATH, OATS
        "OU":[.S],                  // OUTS
        "U":[.T]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Approve I follower for YETI
            if phonemes.matchesString("YE", matchFull: true) {
                followers += [.I]
            }
            
            // Approve A follower for PITA
            if phonemes.matchesSet(["PI"]) {
                followers += [.A]
            }
            
            // Approve O follower for VETO
            if phonemes.matchesSet(["VE"]) {
                followers += [.O]
            }
        }
        
        return followers
    },
    verifyEnd: nil)

let V = Consonant( id: .V,
    blendStart: [],
    blendInto: [],
    defFinal: [.E],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: false,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .E, .I, .O, .U],   // AVAIL, AVER, AVID, AVOCATION, AVUNCULAR
        "E":[.A, .E, .I, .O],       // EVACUATE, EVES, EVIDENT, EVOKE
        "EA":[.E],                  // EAVES
        "I":[.E, .I, .O],           // IVES, IVIED, IVORY
        "O":[.A, .E, .I, .O],       // OVATION, OVER, OVIATE, OVOID
        "U":[.U]],                  // UVULA
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            let lastElement = phonemes.lastElement()
            
            // Approve final A for LAVA, CAVA, NOVA etc.
            if phonemes.matchesSet(["CA", "LA", "NO"]) {
                followers += [.A]
            }
            
            // Approve final O for BRAVO
            if phonemes.matchesSet(["BRA"]) {
                followers += [.O]
            }
        }
        return followers
    },
    verifyEnd: nil)

let W = Consonant( id: .W,
    blendStart: [.H, .R],
    blendInto: [.D, .H, .K, .L, .N, .R, .S, .T],
    defFinal: [.D, .K, .L, .N, .T],         // LEWD, HAWK, HOWL, SOWN, NEWT
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: true,
    liquidBlend: false,
    followerTable: [:],         // no vowels since this is a diphthong
    dynamicFollowers: nil,
    verifyEnd: nil)

let X = Consonant( id: .X,
    blendStart: [],
    blendInto: [.E, .I, .O],  // TAXONOMY
    defFinal: [],
    hardStops: [],
    allowedVowels: [],
    blendsWithY: true,
    canStart: false,
    canEnd: true,
    canPlural: false,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.E, .I, .L, .O],
        "E":[.A, .C, .E, .I, .O, .P, .T, .U],
        "O":[.E, .I, .T, .Y]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        
        // Allow final I for TAXI
        if pos == .positionLAST && phonemes.matchesString("TA", matchFull: true)  {
            return [.I]
        }
            
        // Allow final T only for NEXT, SEXT
        else if pos == .positionLAST && phonemes.matchesSet(["NE", "SE"]) {
            return [.T]
        }
        
        else {
            return []
        }
    },
    verifyEnd: nil)

let Y = Consonant( id: .Y,
    blendStart: [],
    blendInto: [],    
    defFinal: [.L, .O, .M, .R, .E],         // VINYL, YOYO, ANTONYM, MARTYR, STYE
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: false,
    canStart: true,
    canEnd: true,
    canPlural: false,
    dipthong: true,
    liquidBlend: true,
    followerTable: [
        "B":[.E, .P, .S, .T, .Z],   // BYES, BYPASS, BYSTANDER, BYTE, BYZANTINE
        "C":[.A, .B, .C, .G, .P, .S, .T],   // CYANIDE, CYBER, CYCLE, CYGNET, CYPHER, CYST, CYTOSIS
        "CHR":[.S],                 // CHRYSALIS/CHRYSANTHEMUM
        "CR":[.I],                  // CRYING
        "D":[.E, .I, .N, .S],       // DYES, DYING, DYSTOPIA, DYNOMITE
        "DR":[.E, .I, .S],          // DRYING, DRYER, DRYS
        "G":[.M, .N, .P, .R],       // GYMS, GYNECOLOGY, GYPSY, GYRO
        "GL":[.P],                  // GLYPH
        "GR":[.P],                  // GRYPHON
        "H":[.A, .E, .M],           // HYACINTH, HYENA, HYMN, HYSTERIA
        "L":[.E, .I, .M, .R],       // LYES, LYING, LYME, LYRIC
        "M":[.N, .O, .S],           // MYNA, MYOPIA, MYSTERY
        "N":[.L],                   // NYLON
        "P":[.L, .R, .T],           // PYLON, PYROTECHNIC/PYRRIC?, PYTHON
        "PH":[.L],                  // PHYLUM
        "PR":[.I],                  // PRYING
        "PS":[.C],                  // PSYCHO
        "R":[.E],                   // RYES
        "RH":[.M, .T],              // RHYME, RHYTHM
        "S":[.C, .L, .M, .N, .P, .R, .S],   // SYCOPHANT, SYLLABUS, SYMBOL, SYNERGY, SYPHILIS, SYRUP, SYSTEM
        "SC":[.T],                  // SCYTHE
        "SH":[.E, .I, .L],          // SHYER, SHYING, SHYLY
        "SP":[.I],                  // SPYING
        "ST":[.E, .R],              // STYE, STYROFOAM
        "T":[.I, .P, .R],           // TYING, TYPE, TYRANT
        "TH":[.M],                  // THYME
        "V":[.I],                   // VYING
        "W":[.V],                   // WYVERN
        "Z":[.G]],                  // ZYGOTE
        
    dynamicFollowers: nil,
    verifyEnd: nil)

let Z = Consonant( id: .Z,
    blendStart: [],
    blendInto: [.Z],
    defFinal: [.A, .E, .Z],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: false,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.I, .U],       // AZIMUTH, AZURE
        "E":[.R],           // EZRA
        "OO":[.E],          // OOZE
        "OU":[.O]],         // OUZO
    dynamicFollowers: nil,
    verifyEnd: nil)

let consonantMap: [Letter:Consonant] = [.B:B, .C:C, .D:D, .F:F, .G:G, .H:H, .J:J, .K:K, .L:L, .M:M, .N:N,
                                        .P:P, .Q:Q, .R:R, .S:S, .T:T, .V:V, .W:W, .X:X, .Y:Y, .Z:Z]
