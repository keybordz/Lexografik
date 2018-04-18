//
//  Consonant.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class Consonant: LexicalLetter {

    let blendInto: [Letter]
    let hardStops: [Letter]
    let allowedVowels: [Letter]
    let blendsWithY: Bool
    let dipthong: Bool
    let liquidBlend: Bool
    
    init(id: Letter,
         blendStart: [Letter],
         blendInto: [Letter],
         defFinal: [Letter],
         hardStops: [Letter],
         allowedVowels: [Letter],
         blendsWithY: Bool,
         canPlural: Bool,
         dipthong: Bool,
         liquidBlend: Bool, 
         endBias: Int,
         dynamicFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?,
         verifyEnd: ((PhoneticElementArray) -> Bool)?) {
        
        var defFirst, defMiddle, defLast: [Letter]
        
        defFirst = blendStart + allowedVowels
        defMiddle = blendInto + allowedVowels
        
        if canPlural {
            defLast = defFinal + [.S]
        }
        else {
            defLast = defFinal
        }
        
        if blendsWithY {
            defFirst += [.Y]
            defMiddle += [.Y]
            defLast += [.Y]
        }

        self.blendInto = blendInto
        self.hardStops = hardStops
        self.allowedVowels = allowedVowels
        self.blendsWithY = blendsWithY
        self.dipthong = dipthong
        self.liquidBlend = liquidBlend
        super.init(id: id,
                    blendStart: defFirst,
                    blendInto: defMiddle,
                    blendFinal: defLast,
                    canPlural: canPlural, endBias: endBias)
        
        self.instNextLetters = dynamicFollowers
    
        if verifyEnd == nil {
            if endBias > 1 {
                self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
            }
            else {
                self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
            }
            
            if canPlural {
                self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
            }
            else {
                self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return false }
            }        }

        else {
            self.verifyEndOfWord = verifyEnd
            
            // If there's a conditional test for the end, then use it to verify pluralization
            self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in
                                    let testPhonemes = PhoneticElementArray(pea: phonemes)
                                    testPhonemes.removeLastElement()
                                    return self.verifyEndOfWord!(testPhonemes)
                                }
        }
    }
    
    // Override the class-level nextLetters to deal with consonants which follow diphthongs and to generate hard stop followers
    override func nextLetters(pea: PhoneticElementArray, nRemaining: Int) -> [Letter] {
        var expecting: [Letter] = []
        let lastElement = pea.lastElement()
        
        // Check if this consonant follows a diphthong like AH, AW, AY
        // If true, only allow vowels, Y, and final S
        if lastElement != nil && lastElement is DiphthongBlend {

            // For generating the last letter in the word, should only be E, Y, or S
            if nRemaining == 2 {
                if self.allowedVowels.contains(.E) {
                    expecting += [.E]
                }
                if self.blendsWithY {
                    expecting += [.Y]
                }
                if self.canPlural {
                    expecting += [.S]
                }
            }
            
            // Middle of the word allows all vowel followers and Y
            else {
                expecting = self.allowedVowels
                if self.blendsWithY {
                    expecting += [.Y]
                }
            }
        }
        
        // This is the normal case to allow the consonants respective hard stops to follow in the middle of a word
        else {
            expecting = super.nextLetters(pea: pea, nRemaining: nRemaining)
            
            if pea.elements.count > 1 && nRemaining > 2 {
                expecting += hardStops
            }
        }
        
        return expecting
    }
}

// CONSONANTS
let B = Consonant( id: .B,
    blendStart: [.L, .R],
    blendInto: [.B, .L, .R],
    defFinal: [.B, .E],
    hardStops: [.C, .D, .F, .J, .N, .S, .T],   // ABCESS, ABDICATE, ABNEGATE, OBFUSCATE, OBJECT, OBSTRUCT, OBTAIN
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    endBias: 2,
    
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
    blendInto: [.C, .H, .K, .R, .S, .T],
    defFinal: [.A, .E, .H, .K, .O, .T],
    hardStops: [.M, .N],                            // ACME, ACNE
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    endBias: 2,
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
//    verifyEnd: { (phonemes: PhoneticElementArray) in
//        
//        let lastElement = phonemes.lastElement()
//        
//        // Single vowels
//        if lastElement is Vowel {
//            
//            // IC is always a valid ending
//            if lastElement!.id == "I" {
//                return true
//            }
//                
//            // other vowels only work with single syllable words
//            // COULD BE EXCEPTIONS TO THIS...something like EMACS?
//            else if phonemes.numSyllables() > 1 {
//                return false
//            }
//                
//            else {
//                return true
//            }
//        }
//            
//        // Vowel blends that end in I are ok
//        else if lastElement is VowelBlend && String(Array(lastElement!.id)[1]) == "I" {
//            return true
//        }
//            
//        else {
//            return false
//        }
//    } )

let D = Consonant( id: .D,
    blendStart: [.R],
    blendInto: [.D, .J],
    defFinal: [.A, .E, .O],
    hardStops: [.B, .H, .N],            // CARDBOARD, BLOODHOUND, GOODNESS
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    endBias: 3,
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
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    endBias: 2,
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
//    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
//        
//        let lastElement = phonemes.lastElement()
//        
//        // 4 letter words: only allow vowel blends and E ("CLEF"), no 2-syllable words ending in F
//        if phonemes.numLetters() < 4 {
//            if lastElement! is VowelBlend {
//                return true
//            }
//            else if phonemes.numSyllables() == 2 || lastElement!.id != "E" {
//                return false
//            }
//            else {
//                return true
//            }
//        }
//            
//        // Only allow vowel blends (which ones?) for 5-letter or longer words, ex. THIEF, PROOF
//        else {
//            if lastElement! is VowelBlend {
//                return true
//            }
//
//            else {
//                return true
//            }
//        }
//    }
//)

let G = Consonant( id: .G,
    blendStart: [.L, .N, .R],
    blendInto: [.G, .H, .N],            // H & N should blend only after I or EI (SIGH, SLEIGH, ALIGN, SIGN, REIGN)
    defFinal: [.A, .E, .H, .N, .O],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    endBias: 2,
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
    defFinal: [.M, .N, .T],       // JOHN, may need other blends with L, R
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: true,
    liquidBlend: false,
    endBias: 3,
    dynamicFollowers: nil,
    verifyEnd: nil)

let J = Consonant( id: .J,
    blendStart: [],
    blendInto: [],
    defFinal: [.A, .O, .J],             // HAJJ?
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: false,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    endBias: 0,
    dynamicFollowers: nil,
    verifyEnd: nil)

let K = Consonant( id: .K,
    blendStart: [.L, .N, .R],
    blendInto: [.L, .N, .R],
    defFinal: [.E],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    endBias: 2,
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
    
        if posIndicator == .positionLAST {
            
            // Allow final U for HAIKU
            if phonemes.matchesString("HAI", matchFull: true)  {
                return [.U]
            }
            
            // Allow final I for RAKI, SAKI
            else if phonemes.matchesString("RA", matchFull: true) || phonemes.matchesString("SA", matchFull: true)  {
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
//    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
//        
//        let lastElement = phonemes.lastElement()
//        let finalKWords = ["TRE", "AMO"]    // Only valid 4-letter works ending in vowel-K
//        
//        if lastElement is Vowel {
//            
//            // Need to allow words like TREK and AMOK
//            if phonemes.numLetters() == 3 && lastElement! is Vowel {
//                for word in finalKWords {
//                    if phonemes.matchesString(word, matchFull: true) {
//                        return true
//                    }
//                }
//                return false
//            }
//                    
//            
//            else {
//                return false
//            }
//        }
//            
//        else {
//            return true
//        }
//    } )

let L = Consonant( id: .L,
    blendStart: [.L],                   // only for LLAMA
    blendInto: [.B, .C, .D, .F, .G, .K, .L, .M, .P, .S, .T, .V],
    defFinal: [.A, .B, .D, .E, .L, .M, .O, .P, .T],
    hardStops: [.N],                    // ULNA
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    endBias: 2,
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        
        // Allow final I for DELI
        if posIndicator == .positionLAST && phonemes.matchesString("DE", matchFull: true) {
            return [.I]
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
    hardStops: [.L, .N],                             // HAMLET, OMNIBUS
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    endBias: 2,
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
    hardStops: [.F, .L, .M, .P, .V, .Z],                           // INFER, INLET, INPUT, INVITE
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    endBias: 3,
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
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    endBias: 2,
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
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    endBias: 2,
    dynamicFollowers: nil,
    verifyEnd: nil )

let R = Consonant( id: .R,
    blendStart: [.H],                       // RH can only generate Y followers, ex. RHYME, RHYTHM
    blendInto: [.B, .C, .D, .F, .G, .H, .K, .L, .M, .N, .P, .R, .S, .T, .V],
    defFinal: [.A, .B, .D, .E, .F, .G, .K, .L, .M, .N, .O, .P, .T],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    endBias: 3,
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

//    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
//
//        let lastElement = phonemes.lastElement()
//        let finalIRWords = ["EMI", "STI", "NADI"]
//
//        // No consonant-I-R endings except for STIR, NADIR, EMIR -- any others?
//        if lastElement is Vowel && lastElement!.id == "I" {
//
//            if phonemes.numLetters() < 5 {
//                for word in finalIRWords {
//                    if phonemes.matchesString(word, matchFull: true) {
//                        return true
//                    }
//                }
//                return false
//            }
//
//            else {
//                return false
//            }
//        }
//
//        else {
//            return true
//        }
//    } )

let S = Consonant(id: .S,
    blendStart: [.C, .H, .K, .L, .M, .N, .P, .Q, .T, .W],
    blendInto: [.C, .H, .K, .L, .M, .N, .P, .Q, .S, .T, .W],
    defFinal: [.A, .C, .E, .H, .K, .M, .O, .P, .S, .T],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    endBias: 3,
    dynamicFollowers: nil,
    verifyEnd: nil)

let T = Consonant( id: .T,
    blendStart: [.H, .R, .W, .Y],
    blendInto: [.C, .H, .R, .T, .Z],
    defFinal: [.A, .E, .H, .O, .T, .Z],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    endBias: 3,
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
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    endBias: 0,
    dynamicFollowers: nil,
    verifyEnd: nil)

let W = Consonant( id: .W,
    blendStart: [.H, .R],
    blendInto: [.D, .K, .L, .N, .R, .S, .T],
    defFinal: [.D, .L, .N],         // final D: LEWD
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: true,
    dipthong: true,
    liquidBlend: false,
    endBias: 3,
    dynamicFollowers: nil,
    verifyEnd: nil)

let X = Consonant( id: .X,
    blendStart: [],
    blendInto: [.A, .C, .E, .I, .O, .P, .T, .U, .Y],  // EXACT, EXCEL, EXECUTE, EXIST, TAXONOMY, EXPEL, EXTOL, EXUDE, OXYMORON
    defFinal: [],
    hardStops: [],
    allowedVowels: [],
    blendsWithY: true,
    canPlural: false,
    dipthong: false,
    liquidBlend: true,
    endBias: 2,
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
    canPlural: false,
    dipthong: true,
    liquidBlend: true,
    endBias: 3,
    dynamicFollowers: nil,
    verifyEnd: nil)

let Z = Consonant( id: .Z,
    blendStart: [],
    blendInto: [.Z],
    defFinal: [.A, .E, .Z],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canPlural: false,
    dipthong: false,
    liquidBlend: true,
    endBias: 1,
    dynamicFollowers: nil,
    verifyEnd: nil)

let consonantMap: [Letter:Consonant] = [.B:B, .C:C, .D:D, .F:F, .G:G, .H:H, .J:J, .K:K, .L:L, .M:M, .N:N,
     .P:P, .Q:Q, .R:R, .S:S, .T:T, .V:V, .W:W, .X:X, .Y:Y, .Z:Z]


