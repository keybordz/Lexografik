//
//  ConsonantBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class ConsonantBlend: LexicalBlend {
    var blendsWithY: Bool = true
    var singlePhoneme: Bool
    var preceders: [String] = []
    
    // New comprehensive initializer
    init(first: Letter, second: Letter, third: Letter?,
        initBlend: [Letter],      // Consonants which can follow this blend to create a super-blend (ex. SC -> H) at the start
        initVowels: [Letter],     // Vowels which can follow if this blend starts a word (empty if it can't start)
        midBlend: [Letter],       // Consonants which can blend in the middle of a word (mainly liquids like L, ex. TT -> L)
        midVowels: [Letter],      // Vowels which follow when the blend appears in the middle of a word
        finFollowers: [Letter],   // All letters which can follow this blend to finish a word, except S or Y
        canPlural: Bool,          // True if the blend accepts a singular S to make a plural
        blendsWithY: Bool,        // True if Y can follow this blend (right now anywhere in the word)
        single: Bool,             // True if the blend is a single phonetic element (ie. CH, PH, TH, SH)
        endOfWord: Bool,          // True if this blend only occurs at the end of a word
        
        preceders: [String],      // Vowels and vowel blends which commonly precede this blend (for future context verification)
        
        dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?,   // Callback for context-sensitive followers
        
        verifyEnd: ((PhoneticElementArray) -> Bool)? )       // Callback for context checking at the end of a word
    {
        var defFirst, defMiddle, defLast: [Letter]
        var start = false
        
        if !initVowels.isEmpty {
            start = true
        }
        
        defFirst = initBlend + initVowels
        defMiddle = midBlend + midVowels
        defLast = finFollowers
        
        if canPlural {
            defLast += [.S]
        }
        
        // Right now Y is added everywhere but this might need fine tuning
        if blendsWithY {
            if start {
                defFirst += [.Y]
            }
            defMiddle += [.Y]
            defLast += [.Y]
        }
        
        self.singlePhoneme = single
        
        if third == nil {
            super.init(first: first, second: second, start: start, end: endOfWord,
                       defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        }
        else {
            super.init(first: first, second: second, third: third!, start: start, end: endOfWord,
                       defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        }
        
        self.canPlural = canPlural
        self.blendsWithY = blendsWithY
        self.preceders = preceders
        self.instNextLetters = dynFollowers
        
        if endOfWord {
            if verifyEnd == nil {
                verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in
                    return self.defaultVerifyEnd(phonemes)
                }
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
    
    // By default, blends that are combinations of sounds should only follow single vowels
    // The exceptions are the H-blends that consititute a single sound (TH, PH, CH, SH)
    // Also blends with a final S (BEANS, BOARS, SOAPS)
    // Same things applies for double consonants with exception of SS
    func defaultVerifyEnd(_ phonemes: PhoneticElementArray) -> Bool {
        let lastElement = phonemes.lastElement()
        
        // Use this to filter out some weird endings like NLK
        if lastElement! is Consonant || lastElement! is ConsonantBlend {
            return false
        }
            
        // Filter out consecutive R sounds
        else if !self.singlePhoneme && self.id.contains("R") {
            let prevElement = phonemes.nextToLastElement()
            
            if prevElement == nil {
                return true
            }
            else if prevElement!.id.contains("R") {
                return false
            }
            else {
                return true
            }
        }
            
        // single phoneme consonant blends (TH, CH, etc.) following a vowel blend are ok
        // so are blends that are S-plurals
        else if lastElement! is VowelBlend {
            
            if self.singlePhoneme && (self.firstLetter != self.secondLetter) {
                return true
            }
            
            else if self.secondLetter == .S && self.firstLetter != .S {
                return true
            }
            
            else {
                return false
            }
        }
        
        else {
            return true
        }
    }
}

let BL = ConsonantBlend(first: .B, second: .L, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "AU", "E", "EA", "EE", "I", "IA", "O", "OA", "OI", "OU", "U", "UA"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let BR = ConsonantBlend(first: .B, second: .R, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.A],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let CH = ConsonantBlend(first: .C, second: .H, third: nil,
                        initBlend: [.R],
                        initVowels: allVowels,
                        midBlend: [.R],
                        midVowels: allVowels,
                        finFollowers: [.A, .E, .O],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["AU", "EA", "EE", "OA", "OO"],      // possibly AI and IE?
                        dynFollowers: { (pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                                        if pos == .positionLAST && pea.matchesString("GNOC", matchFull: true) {
                                            return [.I]
                                        }
                                        else {
                                            return []
                                        }
                                    },
                        verifyEnd: nil)

let CHR = ConsonantBlend(first: .C, second: .H, third: .R,
                        initBlend: [],
                        initVowels: [.O],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let CK = ConsonantBlend(first: .C, second: .K, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: [.E, .I, .O],
                        finFollowers: [.E],
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let CL = ConsonantBlend(first: .C, second: .L, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let CR = ConsonantBlend(first: .C, second: .R, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E, .O],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let CS = ConsonantBlend(first: .C, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.T],         // for ECSTASY
                        midVowels: allVowels,
                        finFollowers: [.A],
                        canPlural: false,
                        blendsWithY: false,
                        single: true,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let CT = ConsonantBlend(first: .C, second: .T, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: ["EA", "IA", "OA"],
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow final I follower for CACTI
                            if pos == .positionLAST && pea.matchesString("CA", matchFull: true) {
                                return [.I]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: nil)

//let DG = ConsonantBlend(first: .D, second: .G,
//                        start: false, end: false,
//                        canPlural: false,
//                        single: true,
//                        followers: [],
//                        finFollowers: [.E, .Y],
//                        dynFollowers: nil)

let DG = ConsonantBlend(first: .D, second: .G, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.A, .E, .I, .O],
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let DL = ConsonantBlend(first: .D, second: .L, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["AU", "EE", "OO", "OU"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let DR = ConsonantBlend(first: .D, second: .R, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],     // only for CADRE, PADRE?
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let FL = ConsonantBlend(first: .F, second: .L, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let FR = ConsonantBlend(first: .F, second: .R, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let GH = ConsonantBlend(first: .G, second: .H, third: nil,
                        initBlend: [],
                        initVowels: [.A, .O],
                        midBlend: [],
                        midVowels: [.I],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,     // maybe true for DINGHY?
                        single: true,
                        endOfWord: true,
                        preceders: ["I", "AU", "EI", "OU"],
                        dynFollowers: { (phonemes:PhoneticElementArray, pos:PositionIndicator) -> [Letter] in
                            let lastElement = phonemes.lastElement()
                            
                            if pos != .positionFIRST {
                                if lastElement!.id == "I" || lastElement!.id == "EI" || lastElement!.id == "AU" || lastElement!.id == "OU" {
                                    return [.T]
                                }
                                else {
                                    return []
                                }
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            if lastElement!.id == "I" || lastElement!.id == "EI" || lastElement!.id == "AU" || lastElement!.id == "OU" {
                                return true
                            }
                            else {
                                return false
                            }
                        } )

let GHT = ConsonantBlend(first: .G, second: .H, third: .T,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.E, .I, .O],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["I", "AI", "AU", "EI", "OU"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            if lastElement!.id == "AI" || lastElement!.id == "AU" ||
                                lastElement!.id == "I" || lastElement!.id == "EI" || lastElement!.id == "OU" {
                                return true
                            }
                            else {
                                return false
                            }
                        } )

let GL = ConsonantBlend(first: .G, second: .L, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let GN = ConsonantBlend(first: .G, second: .N, third: nil,
                        initBlend: [],
                        initVowels: [.A, .O, .U],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: true,
                        endOfWord: true,
                        preceders: ["I", "EI"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            let prevElement = phonemes.nextToLastElement()
                            
                            if prevElement == nil {
                                return true
                            }
                            
                            // SIGN or ALIGN
                            if lastElement!.id == "I" && (prevElement!.id == "S" || prevElement!.id == "L") {
                                return true
                            }
                                
                            // REIGN, FEIGN, PEIGNOIR
                            else if lastElement!.id == "EI" && (prevElement!.id == "F" || prevElement!.id == "R" || prevElement!.id == "P") {
                                return true
                            }
                                
                            else {
                                return false
                            }
                        })

let GR = ConsonantBlend(first: .G, second: .R, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "O"],
                        dynFollowers: nil,
                        verifyEnd: nil)

//let KL = ConsonantBlend(first: .K, second: .L, start: true, end: false, single: false)

let KN = ConsonantBlend(first: .K, second: .N, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let KR = ConsonantBlend(first: .K, second: .R, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let LB = ConsonantBlend(first: .L, second: .B, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["U"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // I think the only word that works here is BULB
                            if phonemes.numLetters() == 2 && lastElement!.id == "U" {
                                return true
                            }
                            else {
                                return false
                            }
                        })

let LC = ConsonantBlend(first: .L, second: .C, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],         // maybe K?
                        midVowels: allVowels,
                        finFollowers: [.H],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: ["A"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // Only allow TALC for 4-letter words
                            if phonemes.numLetters() == 2 && lastElement!.id == "A" {
                                return true
                            }
                            else {
                                return false
                            }
                        })

//let LCH = ConsonantBlend(first: .L, second: .C, third: .H, start: false, canPlural: false, dynFollowers: nil)

let LCH = ConsonantBlend(first: .L, second: .C, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["E", "I", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let LD = ConsonantBlend(first: .L, second: .D, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "AU", "IE", "OU", "UI"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // Can only follow an OU vowel blend i.e. WOULD, COULD
                            if lastElement is Vowel {
                                return true
                            }
                            else if lastElement is VowelBlend && lastElement!.id == "OU" {
                                return true
                            }
                            else {
                                return false
                            }
                        })

let LF = ConsonantBlend(first: .L, second: .F, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let LG = ConsonantBlend(first: .L, second: .G, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],         // BILGE, BULGE, INDULGE
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let LK = ConsonantBlend(first: .L, second: .K, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let LM = ConsonantBlend(first: .L, second: .M, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],       // Could be A and E?
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let LP = ConsonantBlend(first: .L, second: .P, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],
                        midVowels: allVowels,
                        finFollowers: [.H],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["E", "U"],      // HELP, PULP
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // Only allow ending after E & U vowels (HELP, WHELP, GULP, PULP)
                            if lastElement is Vowel && (lastElement!.id == "E" || lastElement!.id == "U") {
                                return true
                            }
                            else {
                                return false
                            }
                        })

let LPH = ConsonantBlend(first: .L, second: .P, third: .H,
                         initBlend: [],
                         initVowels: [],
                         midBlend: [],
                         midVowels: allVowels,
                         finFollowers: [],
                         canPlural: true,
                         blendsWithY: true,
                         single: false,
                         endOfWord: true,
                         preceders: ["A", "E", "Y"],        // ALPHA, DELPHI, SYLPH
                         dynFollowers: {(pea:PhoneticElementArray, pos:PositionIndicator) -> [Letter] in
                            
                            // Return final A follower for ALPHA
                            if pos == .positionLAST && pea.matchesString("A", matchFull: true) {
                                return [.A]
                            }
                            else {
                                return []
                            }
                        },
                         verifyEnd: nil)

let LS = ConsonantBlend(first: .L, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],
                        midVowels: allVowels,
                        finFollowers: [.E, .H],         // VALSE, ELSE, PULSE
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

// WALSH & WELSH, any others?
let LSH = ConsonantBlend(first: .L, second: .S, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let LT = ConsonantBlend(first: .L, second: .T, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],
                        midVowels: allVowels,
                        finFollowers: [.H],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "AU", "E", "EA", "I", "O", "U"],      // MALT, FAULT, PELT, DEALT, HILT, COLT, VULTURE
                        dynFollowers: nil,
                        verifyEnd: nil)

// This one could potentially plural but don't see it in words like FILTH, HEALTH, WEALTH
let LTH = ConsonantBlend(first: .L, second: .T, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["I", "EA"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let LV = ConsonantBlend(first: .L, second: .V, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let MB = ConsonantBlend(first: .M, second: .M, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],       // Possibly E, O
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "I", "O", "U"],     // LAMB, LIMB, SOMBER, CRUMB
                        dynFollowers: nil,
                        verifyEnd: nil)

let MP = ConsonantBlend(first: .M, second: .P, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H, .L],
                        midVowels: allVowels,
                        finFollowers: [.H, .T],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

// OOMPH, LYMPH
let MPH = ConsonantBlend(first: .M, second: .P, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,       // possibly true?
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["OO", "Y"],
                        dynFollowers: nil,
                        verifyEnd: nil)

// EXEMPT, PROMPT
let MPT = ConsonantBlend(first: .M, second: .P, third: .T,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["E", "O"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let NC = ConsonantBlend(first: .N, second: .C, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],
                        midVowels: allVowels,
                        finFollowers: [.E, .H],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            let firstElement = phonemes.firstElement()
                            
                            // Only word with NC ending is ZINC
                            if phonemes.numLetters() == 2 && lastElement!.id == "I" &&
                                firstElement!.id == "Z" {
                                return true
                            }
                            else {
                                return false
                            }
                        })

let NCH = ConsonantBlend(first: .N, second: .C, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow final O follower for HONCHO, PONCHO
                            if pos == .positionLAST && pea.matchesSet(["HO", "PO"]) {
                                return [.O]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: nil)

let ND = ConsonantBlend(first: .N, second: .D, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.O],         // BANDO?
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let NG = ConsonantBlend(first: .N, second: .G, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.E, .O],         // DINGO, GRINGO, CONGO
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // Allow II before NG (SKIING), all other blends are invalid
                            if lastElement is VowelBlend && lastElement!.id != "II" {
                                return false
                            }
                                
                            else {
                                return true
                            }
                        })

let NK = ConsonantBlend(first: .N, second: .K, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

// not sure how common this blend is in English but possibly MANQUE?
let NQ = ConsonantBlend(first: .N, second: .Q, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.U],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let NQU = ConsonantBlend(first: .N, second: .Q, third: .U,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.A, .E, .I],
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let NS = ConsonantBlend(first: .N, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.K],
                        midVowels: allVowels,
                        finFollowers: [.E, .K],     // MINSK, any others?
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let NT = ConsonantBlend(first: .N, second: .T, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H, .L],
                        midVowels: allVowels,
                        finFollowers: [.H, .T, .O],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "AI", "E", "EI", "I", "O", "OI", "U"],
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow final I for ANTI
                            if pos == .positionLAST && pea.matchesString("A", matchFull: true) {
                                return [.I]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            if lastElement is Vowel {
                                return true
                            }
                                
                                // for words like FEINT, POINT, SAINT
                            else if lastElement! is VowelBlend &&
                                    (lastElement!.id == "AI" || lastElement!.id == "EI" || lastElement!.id == "OI") {
                                return true
                            }
                                
                            else {
                                return false
                            }
                        })

let NTH = ConsonantBlend(first: .N, second: .T, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["E", "I"],      // TENTH, PLINTH
                        dynFollowers: nil,
                        verifyEnd: nil)
// let NZ = ConsonantBlend(first: .N, second: .Z, start: false, end: false, single: false)

let PH = ConsonantBlend(first: .P, second: .H, third: nil,
                        initBlend: [.R],
                        initVowels: [.A, .E, .O],
                        midBlend: [.R],
                        midVowels: [.A, .E, .I, .O],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "I", "O", "Y"],     // GRAPH, CIPHER, GOPHER, CYPHER
                        dynFollowers: nil,
                        verifyEnd: nil)

let PHR = ConsonantBlend(first: .P, second: .H, third: .R,
                        initBlend: [],
                        initVowels: [.A, .E, .O],
                        midBlend: [],
                        midVowels: [.A, .E, .I, .O],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,      // But not really at the end?
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let PL = ConsonantBlend(first: .P, second: .L, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "EE", "EO", "I", "O", "OO", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let PR = ConsonantBlend(first: .M, second: .P, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let PS = ConsonantBlend(first: .P, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [.O],       // PSORIASIS
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,          // true if starting the word?
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

// Should this be in Y blends?
let PSY = ConsonantBlend(first: .P, second: .S, third: .Y,
                        initBlend: [.C],
                        initVowels: [],
                        midBlend: [.C],
                        midVowels: [],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let QU = ConsonantBlend(first: .Q, second: .U, third: nil,
                        initBlend: [],
                        initVowels: [.A, .E, .I, .O],
                        midBlend: [],
                        midVowels: [.A, .E, .I, .O],
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: false,
                        single: true,
                        endOfWord: false,
                        preceders: ["A", "E", "I", "O", "OU", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RB = ConsonantBlend(first: .R, second: .B, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.O],     // TURBO
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "O", "OO", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RC = ConsonantBlend(first: .R, second: .C, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],
                        midVowels: allVowels,
                        finFollowers: [.H],     // maybe add E & K
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RCH = ConsonantBlend(first: .R, second: .C, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RD = ConsonantBlend(first: .R, second: .D, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.E],         // HORDE
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "EA", "EI", "I", "O", "OA", "U"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            if lastElement is Vowel {
                                return true
                            }
                                
                            else if lastElement! is VowelBlend &&
                                (lastElement!.id == "EA" || lastElement!.id == "EI" || lastElement!.id == "OA") {
                                return true
                            }
                                
                            else {
                                return false
                            }
                        })

let RF = ConsonantBlend(first: .R, second: .F, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RG = ConsonantBlend(first: .R, second: .G, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.E, .O],             // CARGO
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
                            
                            // Allow final I for CORGI
                            if pos == .positionLAST && phonemes.matchesString("CO", matchFull: true) {
                                return [.I]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // No vowel blends before RG except OU
                            if lastElement is VowelBlend && lastElement!.id != "OU" {
                                return false
                            }
                                
                                // no IRG words
                            else if lastElement is Vowel && lastElement!.id == "I" {
                                return false
                            }
                                
                            else {
                                return true
                            }
                        })

let RH = ConsonantBlend(first: .R, second: .H, third: nil,
                        initBlend: [],
                        initVowels: [.E, .I],       // RHEA, RHINO
                        midBlend: [],
                        midVowels: [],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RK = ConsonantBlend(first: .R, second: .K, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RL = ConsonantBlend(first: .R, second: .L, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "EA", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // GIRL, CURL, WHORL
                            if lastElement is Vowel &&
                                (lastElement!.id == "I" || lastElement!.id == "O" || lastElement!.id == "U") {
                                return true
                            }
                                
                                // PEARL
                            else if lastElement! is VowelBlend && lastElement!.id == "EA" {
                                return true
                            }
                                
                            else {
                                return false
                            }
                        })

let RM = ConsonantBlend(first: .R, second: .M, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RN = ConsonantBlend(first: .R, second: .N, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "EA", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RP = ConsonantBlend(first: .R, second: .P, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RS = ConsonantBlend(first: .R, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H, .T],
                        midVowels: allVowels,
                        finFollowers: [.E, .H, .T],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RSH = ConsonantBlend(first: .R, second: .S, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RST = ConsonantBlend(first: .R, second: .S, third: .T,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RT = ConsonantBlend(first: .R, second: .T, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H, .L],
                        midVowels: allVowels,
                        finFollowers: [.A, .H],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RTH = ConsonantBlend(first: .R, second: .T, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "EA", "I", "O", "OA", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RV = ConsonantBlend(first: .R, second: .V, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RZ = ConsonantBlend(first: .R, second: .Z, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SC = ConsonantBlend(first: .S, second: .C, third: nil,
                        initBlend: [.H, .R],
                        initVowels: allVowels,
                        midBlend: [.H, .R],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow O follower for DISCO and S plural only for DISC
                            if pos == .positionLAST && phonemes.matchesString("DI", matchFull: true) {
                                return [.O, .S]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            
                            // Only word ending in SC is DISC
                            if phonemes.matchesString("DI", matchFull: true) {
                                return true
                            }
                            else {
                                return false
                            }
                        })

let SCH = ConsonantBlend(first: .S, second: .C, third: .H,
                        initBlend: [.M],                // SCHMOOZE
                        initVowels: [.I, .O],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SCR = ConsonantBlend(first: .S, second: .C, third: .R,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SH = ConsonantBlend(first: .S, second: .H, third: nil,
                        initBlend: [.R],
                        initVowels: allVowels,
                        midBlend: [.R],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            if pos == .positionLAST && pea.matchesString("SU", matchFull: true) {
                                return [.I]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: nil)

let SHR = ConsonantBlend(first: .S, second: .H, third: .R,
                        initBlend: [],
                        initVowels: [.I, .O, .U],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SK = ConsonantBlend(first: .S, second: .K, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SL = ConsonantBlend(first: .S, second: .L, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["AI", "I"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SM = ConsonantBlend(first: .S, second: .M, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // Allow CHASM, ORGASM, PHANTASM, DEISM, EGOISM, etc.
                            if phonemes.numLetters() > 2 && (lastElement!.id == "A" || lastElement!.id == "I" || lastElement!.id == "EI" || lastElement!.id == "OI") {
                                return true
                            }
                                
                            else {
                                return false
                            }
                        })

let SN = ConsonantBlend(first: .S, second: .N, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SP = ConsonantBlend(first: .S, second: .P, third: nil,
                        initBlend: [.L, .H, .R],
                        initVowels: allVowels,
                        midBlend: [.L, .H, .R],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)     // HASP, WASP, LISP

let SPH = ConsonantBlend(first: .S, second: .P, third: .H,
                        initBlend: [],
                        initVowels: [.E, .I],       // SPHERE, SPHINX
                        midBlend: [],
                        midVowels: [.E, .I],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "I"],      // BLASPHEMY, HEMISPHERE
                        dynFollowers: nil,
                        verifyEnd: nil)

let SPL = ConsonantBlend(first: .S, second: .P, third: .L,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SPR = ConsonantBlend(first: .S, second: .P, third: .R,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SQ = ConsonantBlend(first: .S, second: .Q, third: nil,
                        initBlend: [],
                        initVowels: [.U],
                        midBlend: [],
                        midVowels: [.U],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SQU = ConsonantBlend(first: .S, second: .Q, third: .U,
                        initBlend: [],
                        initVowels: [.A, .E, .I, .O],
                        midBlend: [],
                        midVowels: [.A, .E, .I, .O],
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "I", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let ST = ConsonantBlend(first: .S, second: .T, third: nil,
                        initBlend: [.R],
                        initVowels: allVowels,
                        midBlend: [.L, .R],
                        midVowels: allVowels,
                        finFollowers: [.E, .O],     // MANIFESTO
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "AU", "E", "EA", "EI", "I", "IE", "O", "OA", "OI", "OO", "OU", "U", "UE"],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in return true })     // allow all cases

let STR = ConsonantBlend(first: .S, second: .T, third: .R,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.O],     // CASTRO
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let SW = ConsonantBlend(first: .S, second: .W, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let TC = ConsonantBlend(first: .T, second: .C, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],
                        midVowels: allVowels,
                        finFollowers: [.H],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let TCH = ConsonantBlend(first: .T, second: .C, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let TH = ConsonantBlend(first: .T, second: .H, third: nil,
                        initBlend: [.R],
                        initVowels: allVowels,
                        midBlend: [.R],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            if pos == .positionLAST && pea.matchesString("LA", matchFull: true) {
                                return [.I]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: nil)

let THR = ConsonantBlend(first: .T, second: .H, third: .R,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [.H],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            if pos == .positionLAST {
                                return [.U]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: nil)

let TL = ConsonantBlend(first: .T, second: .L, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let TR = ConsonantBlend(first: .T, second: .R, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.O],     // NITRO
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let TW = ConsonantBlend(first: .T, second: .W, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let TZ = ConsonantBlend(first: .T, second: .Z, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.E, .I],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "I", "U"],     // KATZ, PRETZEL BLITZ, KLUTZ
                        dynFollowers: nil,
                        verifyEnd: nil)

let XT = ConsonantBlend(first: .X, second: .T, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let WH = ConsonantBlend(first: .W, second: .H, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

//let WN = ConsonantBlend(first: .W, second: .N, start: false, end: true, canPlural: true, single: true,
//                        followers: [], finFollowers: [.Y], dynFollowers: nil)

let WR = ConsonantBlend(first: .W, second: .R, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let BB = ConsonantBlend(first: .B, second: .B, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let CC = ConsonantBlend(first: .C, second: .C, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],             // for GNOCCHI
                        midVowels: allVowels,
                        finFollowers: [.O],         // STUCCO
                        canPlural: false,
                        blendsWithY: false,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let DD = ConsonantBlend(first: .D, second: .D, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let FF = ConsonantBlend(first: .F, second: .F, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.E],         // GAFFE, GIRAFFE
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["A", "I", "O", "U"],
                        dynFollowers: nil,
                        verifyEnd: nil)

let GG = ConsonantBlend(first: .G, second: .G, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,        // EGG, YEGG
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

//// Does this one really exist?
//let KK = ConsonantBlend(first: .K, second: .K, start: false, end: false, canPlural: false,
//                        single: true, followers: [.L], finFollowers: [.Y],
//                        dynFollowers: nil)

let LL = ConsonantBlend(first: .L, second: .L, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let MM = ConsonantBlend(first: .M, second: .M, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let NN = ConsonantBlend(first: .N, second: .N, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            
                            // Only allow final NN for INN & CONN
                            if phonemes.matchesSet(["I", "CO"]) {
                                return true
                            }
                            else {
                                return false
                            }
                        })

let PP = ConsonantBlend(first: .P, second: .P, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RR = ConsonantBlend(first: .R, second: .R, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],               // Possibly an H here?
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            
                            // Only words for final RR are BURR, PURR, WHIRR
                            if phonemes.matchesSet(["BU", "PU", "WHI"]) {
                                return true
                            }
                            else {
                                return false
                            }
                        })

let SS = ConsonantBlend(first: .S, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // Special case for GUESS
                            if phonemes.matchesString("GUE", matchFull: true) {
                                return true
                            }
                                
                                // All other preceding vowel blends shouldn't work (?)
                            else if lastElement! is VowelBlend {
                                return false
                            }
                                
                            else {
                                return true
                            }
                        })

let TT = ConsonantBlend(first: .T, second: .T, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            
                            // final TT words: BUTT, MATT, MITT, SETT, WATT
                            if phonemes.matchesSet(["BU", "MA", "MI", "SE", "WA"]) {
                                return true
                            }
                            else {
                                return false
                            }
                        })

// SKIVVIES, any others?
let VV = ConsonantBlend(first: .V, second: .V, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.I],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)

let ZZ = ConsonantBlend(first: .Z, second: .Z, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: [.A, .E, .I],        // BUZZARD, BUZZER, BUZZING
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: [],
                        dynFollowers: nil,
                        verifyEnd: nil)         // BUZZ, FIZZ, FUZZ

let consonantBlendMap = ["BL":BL, "BR":BR, "CH":CH, "CHR":CHR, "CK":CK, "CL":CL, "CR":CR, "CS":CS, "CT":CT,
    "DG":DG, "DL":DL, "DR":DR, "FL":FL, "FR":FR, "GH":GH, "GHT":GHT, "GN":GN, "GL":GL, "GR":GR,
    /* "KL":KL,*/ "KN":KN, "KR":KR, "LB":LB, "LC":LC, "LCH":LCH, "LD":LD, "LF":LF, "LG":LG, "LK":LK, "LM":LM,
    "LP":LP, "LPH":LPH, "LS":LS, "LSH":LSH, "LT":LT, "LTH":LTH, "LV":LV, "MB":MB, "MP":MP, "MPH":MPH, "MPT":MPT,
    "NC":NC, "NCH":NCH, "ND":ND, "NG":NG, "NK":NK, "NQ":NQ, "NQU":NQU, "NS":NS, "NT":NT,
    "NTH":NTH, /* "NZ":NZ,*/ "PH":PH, "PHR":PHR, "PL":PL, "PR":PR, "PS":PS,
    "QU":QU, "RB":RB, "RC":RC, "RCH":RCH, "RD":RD, "RF":RF, "RG":RG, "RH":RH, "RK":RK, "RL":RL,
    "RM":RM, "RN":RN, "RP":RP, "RS":RS, "RSH":RSH, "RST":RST, "RT":RT, "RTH":RTH, "RV":RV, "RZ":RZ,
    "SC":SC, "SCH":SCH, "SCR":SCR, "SH":SH, "SHR":SHR, "SK":SK, "SL":SL, "SM":SM, "SN":SN, "SP":SP,
    "SPH":SPH, "SPL":SPL, "SPR":SPR, "SQ":SQ, "SQU":SQU, "ST":ST, "STR":STR, "SW":SW,
    "TC":TC, "TCH":TCH, "TH":TH, "THR":THR, "TL":TL, "TR":TR, "TW":TW, "TZ":TZ,
    "WH":WH, "WR":WR, "XT":XT, "BB":BB, "CC":CC, "DD":DD, "FF":FF, "GG":GG, /* "KK":KK, */ "LL":LL, "MM":MM,
    "NN":NN, "PP":PP, "RR":RR, "SS":SS, "TT":TT, "VV":VV, "ZZ":ZZ]
