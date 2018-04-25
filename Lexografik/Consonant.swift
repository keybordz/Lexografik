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
    
    // Override the class-level nextLetters to deal with consonants which follow diphthongs and to generate hard stop followers
//    override func nextLetters(pea: PhoneticElementArray, nRemaining: Int) -> [Letter] {
//        var expecting: [Letter] = []
//        let lastElement = pea.lastElement()
//
//        // Check if this consonant follows a diphthong like AH, AW, AY
//        // If true, only allow vowels, Y, and final S
//        if lastElement != nil && lastElement is DiphthongBlend {
//
//            // For generating the last letter in the word, should only be E, Y, or S
//            if nRemaining == 2 {
//                if self.allowedVowels.contains(.E) {
//                    expecting += [.E]
//                }
//                if self.blendsWithY {
//                    expecting += [.Y]
//                }
//                if self.canPlural {
//                    expecting += [.S]
//                }
//            }
//
//            // Middle of the word allows all vowel followers and Y
//            else {
//                expecting = self.allowedVowels
//                if self.blendsWithY {
//                    expecting += [.Y]
//                }
//            }
//        }
//
//        // This is the normal case to allow the consonants respective hard stops to follow in the middle of a word
//        else {
//            expecting = super.nextLetters(pea: pea, nRemaining: nRemaining)
//
//            if pea.elements.count > 1 && nRemaining > 2 {
//                expecting += hardStops
//            }
//        }
//
//        return expecting
//    }
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
                    "A":[.A, .B, .D, .E, .I, .L, .N, .O, .R, .U, .Y],
                    "E":[.B, .U],
                    "I":[.E, .I],
                    "O":[.A, .D, .E, .F, .I, .J, .O, .S, .T, .U]],
                  dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
                    
                        // Allow T follower only for DEBT
                        if phonemes.matchesString("DE", matchFull: true) {
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
                
                verifyEnd: { (phonemes: PhoneticElementArray) in
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
    blendInto: [.C, .H, .K, .R, .T],
    defFinal: [.A, .E, .H, .K, .O, .T],
    hardStops: [.M, .N, .S],                            // ACME, ACNE
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.A, .C, .E, .H, .I, .M, .N, .O, .R, .T, .U],
        "E":[.C, .O, .R, .S, .T, .U],
        "I":[.A, .E, .I, .O, .T, .Y],
        "O":[.A, .C, .E, .I, .O, .R, .T, .U]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        
        // Allow final I for FOCI & LOCI
        if posIndicator == .positionLAST &&
            (phonemes.matchesString("FO", matchFull: true) || phonemes.matchesString("LO", matchFull: true)) {
            return [.I]
        }
        else {
            return []
        }
    },
    
    verifyEnd: nil)


let D = Consonant( id: .D,
    blendStart: [.R],
    blendInto: [.D, .J, .L, .R],
    defFinal: [.A, .E, .O],
    hardStops: [.B, .H, .N],            // CARDBOARD, BLOODHOUND, GOODNESS
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: ["A":[.A, .B, .D, .E, .J, .O, .R, .U, .V, .Z],
                    "E":[.D, .G, .I, .O, .U],
                    "I":[.E, .I, .L, .O],
                    "O":[.D, .E, .I, .O, .U],
                    "U":[.D]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        
        // Allow final I for WADI
        if posIndicator == .positionLAST && phonemes.matchesString("WA", matchFull: true) {
            return [.I]
        }
        else {
            return []
        }
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
        "A":[.A, .F, .L, .R, .T],
        "E":[.F],
        "I":[.F],
        "O":[.F, .T]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        
        // Allow final U for SNAFU, TOFU
        if posIndicator == .positionLAST &&
            (phonemes.matchesString("SNA", matchFull: true) || phonemes.matchesString("TO", matchFull: true)) {
            return [.U]
        }
        else {
            return []
        }
    },
    verifyEnd: nil)

let G = Consonant( id: .G,
    blendStart: [.L, .N, .R],
    blendInto: [.G, .H, .N],            // H & N should blend only after I or EI (SIGH, SLEIGH, ALIGN, SIGN, REIGN)
    defFinal: [.A, .E, .H, .N, .O],
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
        "AE":[.G],          // AEGIS
        "E":[.A, .G, .O],
        "EI":[.H],          // EIGHT
        "I":[.G, .L],
        "O":[.D, .L, .R],
        "U":[.G]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        
        // Allow final I for YOGI
        if pos == .positionLAST && phonemes.matchesString("YO", matchFull: true) {
            return [.I]
        }
        else {
            return []
        }
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
        "A":[.A],
        "E":[.A, .E]],
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
    defFinal: [.A, .B, .D, .E, .F, .L, .M, .O, .P, .T],
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
        "E":[.A, .B, .C, .D, .E, .F, .G, .K, .L, .M, .O, .P, .S, .T, .U],
        "EE":[.S, .Y],                      // EELS, EELY
        "I":[.I, .L],
        "O":[.D, .E, .I, .L],
        "U":[.C, .N, .S, .T]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        
        // Allow final I for DELI
        if pos == .positionLAST && phonemes.matchesString("DE", matchFull: true) {
            return [.I]
        }
        
        // This makes KILN work without adding an LN blend
        else if phonemes.matchesString("KI", matchFull: true) {
            return [.N]
        }
            
        else {
            return []
        }
    },
    verifyEnd: nil)

let M = Consonant( id: .M,
    blendStart: [],
    blendInto: [.B, .M, .P],
    defFinal: [.A, .B, .E, .O, .P, .Y],          // final I for SWAMI, SALAMI
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
        "E":[.A, .B, .C, .E, .I, .M, .O, .P, .U],
        "I":[.A, .B, .I, .M],
        "O":[.A, .E, .I, .N],
        "U":[.B]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        
        // Allow final I for SALAMI & SWAMI
        if pos == .positionLAST && (phonemes.matchesString("SALA", matchFull: true) || phonemes.matchesString("SWA", matchFull: true)) {
            return [.I]
        }
          
        // Allow N follower for COLUMN
        else if pos == .positionLAST && phonemes.matchesString("COLU", matchFull: true) {
            return [.N]
        }
            
        else {
            return []
        }
    },
    verifyEnd: nil)

let N = Consonant( id: .N,
    blendStart: [.Y],
    blendInto: [.C, .D, .G, .K, .N, .S, .T],
    defFinal: [.A, .C, .D, .E, .G, .K, .N, .O, .T],    // A is for MYNA, HYENA
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
        "OE":[.N],              // OENOPHILE
        "U":[.A, .B, .C, .D, .E, .F, .G, .H, .I, .K, .L, .M, .N, .O, .P, .R, .S, .T, .U, .V, .W, .Y, .Z]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        
        // Allow final I for RANI
        if pos == .positionLAST && phonemes.matchesString("RA", matchFull: true) {
            return [.I]
        }
            
        else {
            return []
        }
    },
    verifyEnd: nil)

let P = Consonant( id: .P,
    blendStart: [.H, .L, .R, .S],
    blendInto: [.P, .S, .T],
    defFinal: [.A, .E, .H, .O, .T],
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
        "E":[.A, .E, .H, .I, .O, .S],
        "O":[.A, .E, .I, .P, .T, .U],
        "U":[.B, .D, .E, .L, .O, .R, .S, .T, .V]],
    dynamicFollowers: nil,
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
    defFinal: [.A, .B, .D, .E, .F, .G, .K, .L, .M, .N, .O, .P, .T],
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
        "E":[.A, .B, .C, .D, .E, .G, .H, .I, .O, .R, .S, .T],
        "EA":[.G, .L, .N, .S, .T],      // EAGER, EARL, EARN, EARS, EARTH
        "EE":[.I],                      // EERIE
        "I":[.A, .E, .I, .K, .O, .R],
        "O":[.A, .B, .C, .D, .E, .G, .I, .N, .O, .P, .U],           // ORPHAN
        "OA":[.E, .I, .S],              // OARED, OARING, OARS
        "U":[.A, .E, .G, .I, .N, .O, .U]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        
        // Allow final I for SAFARI, SARI, TORI
        if pos == .positionLAST && phonemes.matchesSet(["SA", "SAFA", "TO"]) {
            return [.I]
        }
        else {
            return []
        }
    },
    verifyEnd: nil)

let S = Consonant(id: .S,
    blendStart: [.C, .H, .K, .L, .M, .N, .P, .Q, .T, .W],
    blendInto: [.C, .H, .K, .L, .M, .N, .P, .Q, .S, .T, .W],
    defFinal: [.A, .C, .E, .H, .K, .M, .O, .P, .S, .T],
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
        "E":[.C, .H, .P, .Q, .S, .T],
        "EA":[.E, .I, .T, .Y],              // EASE, EASILY, EAST, EASY
        "I":[.L, .S],
        "O":[.H, .I, .M, .P, .S, .T],
        "OA":[.E, .I, .T],                  // OASES, OASIS, OAST
        "U":[.A, .E, .H, .I, .T, .U]],
    dynamicFollowers: nil,
    verifyEnd: nil)

let T = Consonant( id: .T,
    blendStart: [.H, .R, .W, .Y],
    blendInto: [.C, .H, .R, .T, .Z],
    defFinal: [.A, .E, .H, .O, .T, .Z],
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
        "EA":[.E, .I, .S],          // EATEN
        "I":[.A, .C, .E, .S, .T],
        "IO":[.A],                  // IOTA
        "O":[.H, .I, .T],
        "OA":[.H, .S],              // OATH, OATS
        "U":[.T]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        
        // Allow final I for YETI
        if posIndicator == .positionLAST && phonemes.matchesString("YE", matchFull: true) {
            return [.I]
        }
        else {
            return []
        }
    },
    verifyEnd: nil)

let V = Consonant( id: .V,
    blendStart: [],
    blendInto: [],
    defFinal: [.A, .E],         // final A words: LAVA, CAVA
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: false,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .E, .I, .O, .U],
        "E":[.A, .E, .I, .O],
        "I":[.A, .E, .I, .O],
        "O":[.A, .E, .I, .U],
        "U":[.U]],
    dynamicFollowers: nil,
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
    blendInto: [.A, .C, .E, .I, .O, .P, .T, .U, .Y],  // EXACT, EXCEL, EXECUTE, EXIST, TAXONOMY, EXPEL, EXTOL, EXUDE, OXYMORON
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
        "O":[.E, .I, .Y]],
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
    blendInto: [.L, .M, .N, .P, .R, .S],    // these are also covered in YBlend, are they needed here?
    defFinal: [.L, .O, .M, .R, .E],         // VINYL, YOYO, ANTONYM, MARTYR, STYE
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: false,
    canStart: true,
    canEnd: true,
    canPlural: false,
    dipthong: true,
    liquidBlend: true,
    followerTable: [:],             // followers generated thru YBlend and Diphthongs
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
        "A":[.I],       // AZIMUTH
        "E":[.R],
        "OO":[.Z]],
    dynamicFollowers: nil,
    verifyEnd: nil)

let consonantMap: [Letter:Consonant] = [.B:B, .C:C, .D:D, .F:F, .G:G, .H:H, .J:J, .K:K, .L:L, .M:M, .N:N,
                                        .P:P, .Q:Q, .R:R, .S:S, .T:T, .V:V, .W:W, .X:X, .Y:Y, .Z:Z]
