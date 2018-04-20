//
//  VowelBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class VowelBlend: LexicalBlend {
    var glottalStop: Bool
    
    init(first: Letter, second: Letter, third: Letter?,
        initFollowers: [Letter],     // Consonants which can follow immediately if this blend starts the word (empty if cannot start)
        interFollowers: [Letter],    // Consonants which follow when the blend occurs in the middle of a word
        finFollowers: [Letter],      // Consonants which can follow if the blend immediately precedes the end of a word
        blendInto: [Letter],         // Vowels which can form a triple-letter blend (not many of these exist)
        canPlural: Bool,             // True if the blend accepts a singular S to make a plural
        endOfWord: Bool,             // True if the blend can appear at the end of a word
        glottal: Bool,               // True if a glottal stop always occurs on the second vowel (some blends are conditional)
        
        dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?,   // Callback for context-sensitive followers
        
        verifyEnd: ((PhoneticElementArray) -> Bool)? )       // Callback for context checking at the end of a word
    {
        let defMiddle: [Letter] = interFollowers + blendInto
        var defLast: [Letter] = finFollowers + blendInto
        
        self.glottalStop = glottal
        
        if canPlural {
            defLast += [.S]
        }
        
        if third == nil {
            super.init(first: first, second: second, 
                       start: (initFollowers != []), end: endOfWord,
                       defFirst: initFollowers, defMiddle: defMiddle, defLast: defLast)
        }
        else {
            super.init(first: first, second: second, third: third!,
                       start: (initFollowers != []), end: endOfWord,
                       defFirst: initFollowers, defMiddle: defMiddle, defLast: defLast)
        }
        
        self.canPlural = canPlural
        self.instNextLetters = dynFollowers
        
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
    
    // Initializer for dynamic follower generation
    init(first: Letter, second: Letter, start: Bool, end: Bool, glottal: Bool,
         initFollowers: [Letter],
         intFollowers: [Letter],
//         generateFollowers: @escaping (PhoneticElementArray) -> [Letter],
         nextLetters: @escaping (PhoneticElementArray, PositionIndicator) -> [Letter],
         finFollowers: [Letter]) {
        
        glottalStop = glottal
        super.init(first: first, second: second, start: start, end: end,
                   defFirst: initFollowers, defMiddle: intFollowers, defLast: finFollowers)
        
        instNextLetters = nextLetters

        if end {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return end }
    }
    
    // Initializer for conditional ending cases...this one should go away
    init(first: Letter, second: Letter, start: Bool, glottal: Bool,
         verifyEnd: @escaping (PhoneticElementArray) -> Bool,
         initFollowers: [Letter], interFollowers: [Letter], finFollowers: [Letter]) {
        
        glottalStop = glottal
        super.init(first: first, second: second, start: start, end: false,
                   defFirst: initFollowers, defMiddle: interFollowers, defLast: finFollowers)
        
        verifyEndOfWord = verifyEnd
        
        // If there's a conditional test for the end, then use it to verify pluralization
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in
            let testPhonemes = PhoneticElementArray(pea: phonemes)
            testPhonemes.removeLastElement()
            return self.verifyEndOfWord!(testPhonemes)
        }
    }
    
    // initializer for triple blends
    init(first: Letter, second: Letter, third: Letter, verifyEnd: ((PhoneticElementArray) -> Bool)?) {
        
        glottalStop = false
        super.init(first: first, second: second, third: third, start: false, end: false,
                   defFirst: [], defMiddle: allVowels, defLast: [])

        verifyEndOfWord = verifyEnd
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
}


let AA = VowelBlend(first: .A, second: .A, third: nil,
                    initFollowers: [.R],        // Only for AARDVARK
                    interFollowers: [],
                    finFollowers: [],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let AE = VowelBlend(first: .A, second: .E, third: nil,
                    initFollowers: [.G, .R],      // AEGIS, AERIE
                    interFollowers: [],
                    finFollowers: [],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: true,            // ALGAE, MINUTAE
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let AI = VowelBlend(first: .A, second: .I, third: nil,
                    initFollowers: [.D, .L, .M, .R, .S],       // AIDS, AILS, AIMS, AIRS, AISLE
                    interFollowers: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finFollowers: [.C, .D, .F, .L, .M, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let AO = VowelBlend(first: .A, second: .O, third: nil,
                    initFollowers: [.R],          // AORTA
                    interFollowers: [.S, .T],     // CHAOS, CHAOTIC
                    finFollowers: [],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: true,           // CACAO
                    glottal: true,          // but false for GAOL
                    dynFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                        let lastElement = phonemes.lastElement()
        
                        // GAOL
                        if pos == .positionLAST && phonemes.matchesString("G", matchFull: true) {
                            return [.L]
                        }
                        else {
                            return []
                        }
                    },
                    verifyEnd: nil)

let AU = VowelBlend(first: .A, second: .U, third: nil,
                    initFollowers: [.D, .G, .L, .R, .S, .T, .X],  // AUDIO, AUGUR, AURAL, AUSTRIAN, AUTO, AUXILIARY
                    interFollowers: [.B, .C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .V, .X],
                    finFollowers: [.D, .F, .L, .M, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let EA = VowelBlend(first: .E, second: .A, third: nil,
                    initFollowers: [.C, .R, .S, .T, .V],
                    interFollowers: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .U, .V],
                    finFollowers: [.D, .F, .H, .K, .L, .M, .N, .P, .R, .T],       // YEAH
                    blendInto: [.U],
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        
                        // FLEA, LEA, PEA, PLEA, RHEA, SEA, TEA, UREA, YEA
                        let finalEAWords = ["FL", "L", "P", "PL", "RH", "S", "T", "UR", "Y"]
                        
                        for word in finalEAWords {
                            if phonemes.matchesString(word, matchFull: true) {
                                return true
                            }
                        }
                        return false
})

let EAU = VowelBlend(first: .E, second: .A, third: .U,
                    initFollowers: [],
                    interFollowers: [.T],       // BEAUTIFUL
                    finFollowers: [],
                    blendInto: [],
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
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
                    initFollowers: [.L, .R],        // EELS, EERIE
                    interFollowers: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finFollowers: [.D, .F, .K, .L, .M, .N, .P, .R, .T],
                    blendInto: [.I],        // for gerunds like FLEEING
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let EI = VowelBlend(first: .E, second: .I, third: nil,
                    initFollowers: [.G, .T],        // EIGHT, EITHER
                    interFollowers: [.C, .G, .K, .L, .N, .R, .S, .T, .V, .Z],
                    finFollowers: [.C, .D, .K, .L, .N, .R, .S],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let EO = VowelBlend(first: .E, second: .O, third: nil,
                    initFollowers: [.N],        // EONS
                    interFollowers: [.D, .G, .L, .M, .N, .R, .S, .T],
                    finFollowers: [.N],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: true,          // Could be false, ex. YEOMAN
                    dynFollowers: nil,
                    verifyEnd: nil)

let EU = VowelBlend(first: .E, second: .U, third: nil,
                    initFollowers: [.R],       // EURO
                    interFollowers: [.C, .D, .R, .T],
                    finFollowers: [.D],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let IA = VowelBlend(first: .I, second: .A, third: nil,
                    initFollowers: [.M],        // IAMBS
                    interFollowers: [.B, .C, .D, .L, .M, .N, .P, .R, .S, .T],
                    finFollowers: [.D, .L, .M, .N, .R, .T],
                    blendInto: [],
                    canPlural: true,
                    endOfWord: true,
                    glottal: true,          // could be false in some cases?
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        
                        // Words ending in IA: ILIA, GLIA, MEDIA, ZINNIA
                        let finalIAWords = ["GL", "IL", "MED", "ZINN"]
                        
                        for word in finalIAWords {
                            if phonemes.matchesString(word, matchFull: true) {
                                return true
                            }
                        }
                        
                        return false
                    })


let IE = VowelBlend(first: .I, second: .E, third: nil,
                    initFollowers: [],
                    interFollowers: [.C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .U, .V, .Z],
                    finFollowers: [.D, .F, .L, .M, .N, .R, .T],
                    blendInto: [.U],        // for LIEU
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
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
                     initFollowers: [],
                     interFollowers: [],
                     finFollowers: [],
                     blendInto: [],
                     canPlural: false,
                     endOfWord: true,
                     glottal: false,
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
                    initFollowers: [],
                    interFollowers: [],
                    finFollowers: [],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: true,
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
                    initFollowers: [.N, .T],        // IONS, IOTA
                    interFollowers: [.D, .M, .N, .R, .S, .T],
                    finFollowers: [.D, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: true,
                    endOfWord: true,        // BRIO, TRIO
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let IU = VowelBlend(first: .I, second: .U, third: nil,
                    initFollowers: [],
                    interFollowers: [.M, .S],
                    finFollowers: [.M],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let OA = VowelBlend(first: .O, second: .A, third: nil,
                    initFollowers: [.F, .K, .R, .S, .T],        // OAFS, OAKS, OARS, OAST, OATS
                    interFollowers: [.C, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T, .V],
                    finFollowers: [.D, .F, .K, .L, .M, .N, .P, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let OE = VowelBlend(first: .O, second: .E, third: nil,
                    initFollowers: [.N],
                    interFollowers: [.D, .M, .R, .S, .T],
                    finFollowers: [.D, .M, .R, .S, .T],
                    blendInto: [],
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let OI = VowelBlend(first: .O, second: .I, third: nil,
                    initFollowers: [.L],        // OILS
                    interFollowers: [.C, .D, .F, .L, .N, .R, .S, .T, .V],
                    finFollowers: [.C, .D, .L, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,       // but KOI perhaps?
                    endOfWord: false,
                    glottal: true,
                    dynFollowers: nil,
                    verifyEnd: nil)

let OO = VowelBlend(first: .O, second: .O, third: nil,
                    initFollowers: [.Z],        // OOZE
                    interFollowers: [.B, .D, .F, .G, .I, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finFollowers: [.B, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T],
                    blendInto: [.I],        // for gerunds like WOOING
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        let finalOOWords = ["B", "G", "M", "W", "Z", "SH", "IGL", "TAB"]
                        for word in finalOOWords {
                            if phonemes.matchesString(word, matchFull: true) {
                                return true
                            }
                        }
                        
                        return false
                })

let OU = VowelBlend(first: .O, second: .U, third: nil,
                    initFollowers: [.N, .R, .S, .T],    // OUNCE, OURS, OUST, OUTS
                    interFollowers: [.B, .C, .D, .F, .G, .L, .N, .P, .Q, .R, .S, .T, .V, .Z],
                    finFollowers: [.D, .F, .L, .N, .P, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,       // what about SOUS?
                    endOfWord: false,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let UA = VowelBlend(first: .U, second: .A, third: nil,
                    initFollowers: [],
                    interFollowers: [.B, .C, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finFollowers: [.D, .F, .L, .M, .N, .R, .T, .Y],
                    blendInto: [.U],        // for LUAU
                    canPlural: false,
                    endOfWord: false,
                    glottal: true,
                    dynFollowers: nil,
                    verifyEnd: nil)

let UE = VowelBlend(first: .U, second: .E, third: nil,
                    initFollowers: [],
                    interFollowers: [.D, .L, .N, .R, .S, .T],
                    finFollowers: [.D, .L, .R, .T, .Y],
                    blendInto: [],
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let UI = VowelBlend(first: .U, second: .I, third: nil,
                    initFollowers: [],
                    interFollowers: [.C, .D, .L, .N, .R, .S, .T],
                    finFollowers: [.D, .L, .N, .R, .T],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: true,          // but false for SUIT, SQUID
                    dynFollowers: nil,
                    verifyEnd: nil)

let UO = VowelBlend(first: .U, second: .O, third: nil,
                    initFollowers: [],
                    interFollowers: [.R, .S],
                    finFollowers: [.R, .Y],     // BUOY
                    blendInto: [],
                    canPlural: true,        // DUOS
                    endOfWord: true,
                    glottal: true,
                    dynFollowers: nil,
                    verifyEnd: nil)

let UU = VowelBlend(first: .U, second: .U, third: nil,
                    initFollowers: [],
                    interFollowers: [.M],       // VACUUM
                    finFollowers: [.M],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    dynFollowers: nil,
                    verifyEnd: nil)

let vowelBlendMap = ["AA":AA, "AE":AE, "AI":AI, "AO":AO, "AU":AU,
    "EA":EA, "EE":EE, "EI":EI, "EO":EO, "EU":EU, "EAU":EAU,
    "IA":IA, "IE":IE, "II":II, "IO":IO, "IU":IU, "IEU":IEU,
    "OA":OA, "OE":OE, "OI":OI, "OO":OO, "OU":OU,
    "UA":UA, "UE":UE, "UI":UI, "UO":UO, "UU":UU ]
