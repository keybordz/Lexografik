//
//  ConsonantBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class ConsonantBlend: LexicalBlend {
    var singlePhoneme: Bool
    
    // Generic initializer, no restrictions on followers or ending condition
    init(first: Letter, second: Letter, start: Bool, end: Bool, single: Bool) {
        var defFirst: [Letter]
        var defMiddle: [Letter]
        var defLast: [Letter]
        let canPlural: Bool = (end && second != .S)
        
        singlePhoneme = single
        
        if start {
            defFirst = allVowels + [.Y]
        }
        else {
            defFirst = []
        }
        
        defMiddle = allVowels + [.Y]

        if canPlural {
            defLast = [.E, .S, .Y]
        }
        else {
            defLast = [.E, .Y]
        }

        super.init(first: first, second: second, start: start, end: end,
                   defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)

        if end {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in
                return self.defaultVerifyEnd(phonemes)
            }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return canPlural }
    }
    
    
    init(first: Letter, second: Letter, start: Bool, end: Bool, canPlural: Bool, single: Bool,
         followers: [Letter], finFollowers: [Letter], dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?) {
        var defFirst: [Letter]
        var defMiddle: [Letter]
        var defLast: [Letter]
        
        singlePhoneme = single

        if start {
            defFirst = allVowels + [.Y] + followers
        }
        else {
            defFirst = []
        }
        
        defMiddle = allVowels + [.Y] + followers
        
        if canPlural {
            defLast = finFollowers + [.S]
        }
        else {
            defLast = finFollowers
        }
            
        super.init(first: first, second: second, start: start, end: end,
                   defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        
        if dynFollowers != nil {
            self.instNextLetters = dynFollowers
        }
        
        if end {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in
                return self.defaultVerifyEnd(phonemes)
            }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
            
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return canPlural }
    }
    
    init(first: Letter, second: Letter, start: Bool,
         verifyEnd: @escaping (PhoneticElementArray) -> Bool,
         canPlural: Bool, single: Bool, conFollowers: [Letter], finFollowers: [Letter],
         dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?) {
        var defFirst: [Letter]
        var defMiddle: [Letter]
        var defLast: [Letter]
            
        singlePhoneme = single

        if start {
            defFirst = allVowels + [.Y] + conFollowers
        }
        else {
            defFirst = []
        }
            
        defMiddle = allVowels + [.Y] + conFollowers
        
        if canPlural {
            defLast = finFollowers + [.S]
        }
        else {
            defLast = finFollowers
        }
        
        super.init(first: first, second: second, start: start, end: true,
                   defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        
        if dynFollowers != nil {
            self.instNextLetters = dynFollowers
        }
        
        verifyEndOfWord = verifyEnd
            
        // If there's a conditional test for the end, then use it to verify pluralization
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in
            let testPhonemes = PhoneticElementArray(pea: phonemes)
            testPhonemes.removeLastElement()
            return self.verifyEndOfWord!(testPhonemes)
        }
    }
    
    // Only case for this initializer is GN
    init(first: Letter, second: Letter, start: Bool, verifyEnd: @escaping (PhoneticElementArray) -> Bool,
         canPlural: Bool, single: Bool, initVowels: [Letter]) {
        var defFirst: [Letter]
        var defMiddle: [Letter]
        var defLast: [Letter]
        
        singlePhoneme = single
        
        if start {
            defFirst =  initVowels
        }
        else {
            defFirst = []
        }
        
        defMiddle = allVowels + [.Y]
        
        if canPlural {
            defLast = [.S]
        }
        else {
            defLast = []
        }
        
        super.init(first: first, second: second, start: start, end: true,
                   defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        
        verifyEndOfWord = verifyEnd
        
        // If there's a conditional test for the end, then use it to verify pluralization
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in
            let testPhonemes = PhoneticElementArray(pea: phonemes)
            testPhonemes.removeLastElement()
            return self.verifyEndOfWord!(testPhonemes)
        }
    }
    
    // This is for partial blends needed to create 3-letter superblends (TCH, SQU)
    init(first: Letter, second: Letter, start: Bool, end: Bool, canPlural: Bool, single: Bool,
         onlyFollowers: [Letter], finFollowers: [Letter]) {
        var defFirst: [Letter]
        var defMiddle: [Letter]
        var defLast: [Letter]
        
        singlePhoneme = single
        
        if start {
            defFirst = onlyFollowers
        }
        else {
            defFirst = []
        }
        
        defMiddle = onlyFollowers
        
        if canPlural {
            defLast = finFollowers + [.S]
        }
        else {
            defLast = finFollowers
        }
        
        super.init(first: first, second: second, start: start, end: end,
                   defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        
        if end {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in
                return self.defaultVerifyEnd(phonemes)
            }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
            
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return canPlural }
    }
    
    // Initializer for triple consonant blends
    init(first: Letter, second: Letter, third: Letter, start: Bool, dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?) {
        var defFirst: [Letter]
        var defMiddle: [Letter]
        var defLast: [Letter]
        
        singlePhoneme = false
       
        if start {
            defFirst = allVowels + [.Y]
            defMiddle = allVowels + [.Y]
            defLast = []
        }
        else {
            defFirst = []
            defMiddle = allVowels + [.Y]
            defLast = [.Y]
        }
        
        super.init(first: first, second: second, third: third, start: start, end: !start,
                   defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        
        if dynFollowers != nil {
            self.instNextLetters = dynFollowers
        }
        
        if start {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
            verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
            verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
        }
    }

    init(first: Letter, second: Letter, third: Letter, start: Bool, onlyFollowers: [Letter], finFollowers: [Letter]) {
        var defFirst: [Letter]
        var defMiddle: [Letter]
        var defLast: [Letter]
        
        singlePhoneme = false
        
        if start {
            defFirst = onlyFollowers
            defMiddle = onlyFollowers
            defLast = finFollowers
        }
        else {
            defFirst = []
            defMiddle = onlyFollowers
            defLast = finFollowers
        }
        
        super.init(first: first, second: second, third: third, start: start, end: !start,
                   defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        
        if start {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
            verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
            verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
        }
    }
    
    init(first: Letter, second: Letter, third: Letter, start: Bool, verifyEnd: (PhoneticElementArray) -> Bool) {
        var defFirst: [Letter]
        var defMiddle: [Letter]
        var defLast: [Letter]
        
        singlePhoneme = false
        
        if start {
            defFirst = allVowels + [.Y]
            defMiddle = allVowels + [.Y]
            defLast = []
        }
        else {
            defFirst = []
            defMiddle = allVowels + [.Y]
            defLast = [.E]   // what should this really be?
        }
        
        super.init(first: first, second: second, third: third, start: start, end: !start,
                   defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)

        if start {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
            verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
            verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
        }
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

let BL = ConsonantBlend(first: .B, second: .L, start: true, end: false, single: false)

let BR = ConsonantBlend( first: .B, second: .R, start: true, end: false, single: false)

let CH = ConsonantBlend( first: .C, second: .H,
    start: true,
    end: true,
    canPlural: true,  // conditional?
    single: true,
    followers: [.R],
    finFollowers: [.A, .E, .O, .Y],
    
    // allow final I for GNOCCHI
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        if pos == .positionLAST && pea.matchesString("GNOCC", matchFull: true) {
            return [.I]
        }
        else {
            return []
        }
    })


let CHR = ConsonantBlend( first: .C, second: .H, third: .R, start: true, dynFollowers: nil)

let CK = ConsonantBlend( first: .C, second: .K,
    start: false,
    end: true,
    canPlural: true,
    single: true,
    followers: [.L],
    finFollowers: [.Y],
    dynFollowers: nil)

let CL = ConsonantBlend(first: .C, second: .L, start: true, end: false, single: false)

let CR = ConsonantBlend(first: .C, second: .R, start: true, end: false, canPlural: false,
                        single: false, followers: [.Y], finFollowers: [.O, .Y],
                        dynFollowers: nil)

let CS = ConsonantBlend(first: .C, second: .S,
                        start: false, end: true,
                        canPlural: false,
                        single: true,
                        followers: [.T],
                        finFollowers: [],
                        dynFollowers: nil)       // ECSTASY

let CT = ConsonantBlend(first: .C, second: .T, start: false, end: true, single: false)

let DG = ConsonantBlend(first: .D, second: .G,
                        start: false, end: false,
                        canPlural: false,
                        single: true,
                        followers: [.E, .Y],
                        finFollowers: [.E, .Y],
                        dynFollowers: nil)

let DL = ConsonantBlend(first: .D, second: .L, start: false, end: false, single: false)
let DR = ConsonantBlend(first: .D, second: .R, start: true, end: false, single: false)

let FL = ConsonantBlend(first: .F, second: .L, start: true, end: false, single: false)
let FR = ConsonantBlend(first: .F, second: .R, start: true, end: false, single: false)

let GH = ConsonantBlend(first: .G, second: .H,
    start: true,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        let lastElement = phonemes.lastElement()
        
        if lastElement!.id == "I" || lastElement!.id == "EI" || lastElement!.id == "OU" {
            return true
        }
        else {
            return false
        }
    },
    canPlural: false,
    single: true,
    conFollowers: [.T],
    finFollowers: [],
    dynFollowers: nil)

let GHT = ConsonantBlend(first: .G, second: .H, third: .T,
    start: false,
    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
        let lastElement = phonemes.lastElement()
        
        if lastElement!.id == "AI" || lastElement!.id == "EI" || lastElement!.id == "AU" || lastElement!.id == "OU" {
            return true
        }
        else {
            return false
        }
} )

let GL = ConsonantBlend(first: .G, second: .L, start: true, end: false, single: false)

let GN = ConsonantBlend(first: .G, second: .N,
    start: true,
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
    },
    canPlural: true, single: true,
    initVowels: [.A, .O, .U] )


let GR = ConsonantBlend(first: .G, second: .R, start: true, end: false, single: false)

let KL = ConsonantBlend(first: .K, second: .L, start: true, end: false, single: false)
let KN = ConsonantBlend(first: .K, second: .N, start: true, end: false, single: true)
let KR = ConsonantBlend(first: .K, second: .R, start: true, end: false, single: false)

let LB = ConsonantBlend(first: .L, second: .B,
    start: false,
    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
        let lastElement = phonemes.lastElement()
        
        // I think the only word that works here is BULB
        if phonemes.numLetters() == 2 && lastElement!.id == "U" {
            return true
        }
        else {
            return false
        }
    },
    canPlural: true,
    single: false,
    conFollowers: [],
    finFollowers: [.Y],
    dynFollowers: nil)

let LC = ConsonantBlend( first: .L, second: .C,
    start: false,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        let lastElement = phonemes.lastElement()
        
        // Only allow TALC for 4-letter words
        if phonemes.numLetters() == 2 && lastElement!.id == "A" {
            return true
        }
        else {
            return false
        }
    },
    canPlural: false,
    single: false,
    conFollowers: [],
    finFollowers: [.H],
    dynFollowers: nil)

let LCH = ConsonantBlend(first: .L, second: .C, third: .H, start: false, dynFollowers: nil)

let LD = ConsonantBlend( first: .L, second: .D,
    start: false,
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
    },
    canPlural: false,
    single: false,
    conFollowers: [],
    finFollowers: [.Y],
    dynFollowers: nil)

let LF = ConsonantBlend(first: .L, second: .F, start: false, end: true, single: false)
let LG = ConsonantBlend(first: .L, second: .G, start: false, end: false, single: false)
let LK = ConsonantBlend(first: .L, second: .K, start: false, end: true, single: false)
let LM = ConsonantBlend(first: .L, second: .M, start: false, end: true, single: false)
let LP = ConsonantBlend(first: .L, second: .P, start: false, end: false, single: false)
let LS = ConsonantBlend(first: .L, second: .S, start: false, end: true, single: false)
let LSH = ConsonantBlend(first: .L, second: .S, third: .H, start: false, dynFollowers: nil)
let LT = ConsonantBlend(first: .L, second: .T, start: false, end: true, single: false)
let LTH = ConsonantBlend(first: .L, second: .T, third: .H, start: false, dynFollowers: nil)
let LV = ConsonantBlend(first: .L, second: .V, start: false, end: false, single: false)

let MB = ConsonantBlend( first: .M, second: .B,
    start: false,
    end: true,
    canPlural: true,
    single: false,
    followers: [.L],
    finFollowers: [.Y],
    dynFollowers: nil)

let MP = ConsonantBlend( first: .M, second: .P,
    start: false,
    end: true,
    canPlural: true,
    single: false,
    followers: [.L],
    finFollowers: [.Y],
    dynFollowers: nil)

let MPT = ConsonantBlend(first: .M, second: .P, third: .T, start: false, dynFollowers: nil)

let NC = ConsonantBlend(first: .N, second: .C, start: false,
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
                        },
                        canPlural: true, single: false,
                        conFollowers: [.H], finFollowers: [.H, .Y],
                        dynFollowers: nil)

let NCH = ConsonantBlend(first: .N, second: .C, third: .H, start: false, dynFollowers: nil)

let ND = ConsonantBlend(first: .N, second: .D, start: false, end: true, canPlural: true,
                        single: false,
                        followers: [.L],
                        finFollowers: [.Y],
                        dynFollowers: nil)

let NG = ConsonantBlend(first: .N, second: .G, start: false,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()

                            // Allow II before NG (SKIING), all other blends are invalid
                            if lastElement is VowelBlend && lastElement!.id != "II" {
                                return false
                            }
                                
                            else {
                                return true
                            }
                        },
                        canPlural: false, single: true,
                        conFollowers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let NK = ConsonantBlend(first: .N, second: .K, start: false, end: true, canPlural: true,
                        single: false,
                        followers: [.L],
                        finFollowers: [.Y],
                        dynFollowers: nil)

// not sure how common this blend is in English but possibly MANQUE?
let NQ = ConsonantBlend(first: .N, second: .Q,
                        start: false,
                        end: false,
                        canPlural: false,
                        single: false,
                        onlyFollowers: [.U],  // only exists to get to NQU
                        finFollowers: [])

let NQU = ConsonantBlend(first: .N, second: .Q, third: .U, start: false, dynFollowers: nil)

let NS = ConsonantBlend(first: .N, second: .S, start: false, end: true, canPlural: false,
                        single: false,
                        followers: [.L], // may need to add letters that blend with S like C for INSCRIBE?
    finFollowers: [.E],
    dynFollowers: nil)

let NT = ConsonantBlend(first: .N, second: .T,
    start: false,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        let lastElement = phonemes.lastElement()
        
        if lastElement is Vowel {
            return true
        }
        
        // for words like FEINT, POINT, SAINT
        else if lastElement! is VowelBlend && (lastElement!.id == "AI" || lastElement!.id == "EI" || lastElement!.id == "OI") {
            return true
        }
            
        else {
            return false
        }
    },
    canPlural: true,
    single: false,
    conFollowers: [.H],
    finFollowers: [.H, .I, .O, .Y],
    
    // allow final I for ANTI
    dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
        if pos == .positionLAST && pea.matchesString("AN", matchFull: true) {
            return [.I]
        }
        else {
            return []
        }
    })

let NTH = ConsonantBlend(first: .N, second: .T, third: .H, start: false, dynFollowers: nil)
let NZ = ConsonantBlend(first: .N, second: .Z, start: false, end: false, single: false)

let PH = ConsonantBlend(first: .P, second: .H, start: true, end: true, canPlural: true,
                        single: true, followers: [.R], finFollowers: [.Y],
                        dynFollowers: nil)          // need to allow final A for ALPHA

let PHR = ConsonantBlend(first: .P, second: .H, third: .R, start: true, dynFollowers: nil)
let PL = ConsonantBlend(first: .P, second: .L, start: true, end: false, single: false)
let PR = ConsonantBlend(first: .P, second: .R, start: true, end: false, single: false)
let PS = ConsonantBlend(first: .P, second: .S, start: true, end: true, canPlural: false,
                        single: false, onlyFollowers: [.Y], finFollowers: [.Y])

let QU = ConsonantBlend(first: .Q, second: .U, start: true, end: false, canPlural: false,
                        single: true, onlyFollowers: [.A, .E, .I, .O], finFollowers: [.E])

let RB = ConsonantBlend(first: .R, second: .B, start: false, end: true, canPlural: true,
                        single: false, followers: [.L], finFollowers: [.O, .Y],
                        dynFollowers: nil)  // TURBO

let RC = ConsonantBlend(first: .R, second: .C, start: false, end: false, canPlural: true,
                        single: false, followers: [.H], finFollowers: [.O, .Y],
                        dynFollowers: nil)    // ARCO

let RCH = ConsonantBlend(first: .R, second: .C, third: .H, start: false, dynFollowers: nil)

let RD = ConsonantBlend( first: .R, second: .D,
    start: false,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        let lastElement = phonemes.lastElement()
        
        if lastElement is Vowel {
            return true
        }
            
        else if lastElement! is VowelBlend && (lastElement!.id == "EE" || lastElement!.id == "OO") {
            return false
        }
            
        else {
            return true
        }
    },
    canPlural: true,
    single: false,
    conFollowers: [.L],
    finFollowers: [.Y],
    dynFollowers: nil)

let RF = ConsonantBlend(first: .R, second: .F, start: false, end: true, canPlural: true,
                        single: false, followers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let RG = ConsonantBlend(first: .R, second: .G, start: false,
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
                        },
                        canPlural: true, single: false,
                        conFollowers: [.L], finFollowers: [.E, .I, .O, .Y],
                        dynFollowers: nil)

let RH = ConsonantBlend(first: .R, second: .H, start: true, end: false, canPlural: false,
                        single: true, followers: [.Y], finFollowers: [],
                        dynFollowers: nil)

let RK = ConsonantBlend(first: .R, second: .K, start: false, end: true, canPlural: true,
                        single: false, followers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let RL = ConsonantBlend(first: .R, second: .L,
                        start: false, 
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // GIRL, CURL
                            if lastElement is Vowel && (lastElement!.id == "I" || lastElement!.id == "U") {
                                return true
                            }
                                
                            // PEARL
                            else if lastElement! is VowelBlend && lastElement!.id == "EA" {
                                return true
                            }
                                
                            else {
                                return false
                            }
                        },
                        canPlural: false, single: false, conFollowers: [], finFollowers: [.Y],
                        dynFollowers: nil)

let RM = ConsonantBlend(first: .R, second: .M, start: false, end: true, single: false)

let RN = ConsonantBlend(first: .R, second: .N, start: false, end: true, single: false)

let RP = ConsonantBlend(first: .R, second: .P, start: false, end: true, single: false)

let RS = ConsonantBlend(first: .R, second: .S, start: false, end: true, canPlural: false,
                        single: false, followers: [.H, .T], finFollowers: [.E, .H, .T, .Y],
                        dynFollowers: nil)

let RSH = ConsonantBlend(first: .R, second: .S, third: .H, start: false, dynFollowers: nil)
let RST = ConsonantBlend(first: .R, second: .S, third: .T, start: false, dynFollowers: nil)

let RT = ConsonantBlend(first: .R, second: .T, start: false, end: true, canPlural: true,
                        single: false,
                        followers: [.H, .L],
                        finFollowers: [.A, .H, .Y],
                        dynFollowers: nil)      // AORTA

let RTH = ConsonantBlend(first: .R, second: .T, third: .H, start: false, dynFollowers: nil)

let RV = ConsonantBlend(first: .R, second: .V, start: false, end: false, single: false)

let RZ = ConsonantBlend(first: .R, second: .Z, start: false, end: false, single: false)

let SC = ConsonantBlend( first: .S, second: .C,
    start: true,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        let lastElement = phonemes.lastElement()
        let firstElement = phonemes.firstElement()
        
        // Only word ending in SC is DISC
        if phonemes.numLetters() == 2 && lastElement!.id == "I" && firstElement!.id == "D" {
            return true
        }
        else {
            return false
        }
    },
    canPlural: true, single: false,
    conFollowers: [.H, .R, .Y],     // SCYTHE
    finFollowers: [.O],
    dynFollowers: nil)        // DISCO

let SCH = ConsonantBlend(first: .S, second: .C, third: .H, start: true, dynFollowers: nil)
let SCR = ConsonantBlend(first: .S, second: .C, third: .R, start: true, dynFollowers: nil)

let SH = ConsonantBlend(first: .S, second: .H, start: true, end: true, canPlural: false, single: true,
                        followers: [.R], finFollowers: [.Y],
                        
                        // allow final I for SUSHI
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            if pos == .positionLAST && pea.matchesString("SUS", matchFull: true) {
                                return [.I]
                            }
                            else {
                                return []
                            }
                        })

let SHR = ConsonantBlend(first: .S, second: .H, third: .R, start: true, dynFollowers: nil)
let SK = ConsonantBlend(first: .S, second: .K, start: true, end: true, single: false)
let SL = ConsonantBlend(first: .S, second: .L, start: true, end: false, single: false)

let SM = ConsonantBlend(first: .S, second: .M,
    start: true,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        let lastElement = phonemes.lastElement()
        
        // Allow CHASM, ORGASM, PHANTASM, DEISM, EGOISM, etc.
        if phonemes.numLetters() > 2 && (lastElement!.id == "A" || lastElement!.id == "I" || lastElement!.id == "EI" || lastElement!.id == "OI") {
            return true
        }
            
        else {
            return false
        }
    },
    canPlural: true,
    single: false,
    conFollowers: [],
    finFollowers: [],
    dynFollowers: nil)

let SN = ConsonantBlend(first: .S, second: .N, start: true, end: false, single: false)

let SP = ConsonantBlend(first: .S, second: .P, start: true, end: true, canPlural: true,
                        single: false, followers: [.L, .H, .R], finFollowers: [.Y],
                        dynFollowers: nil)

let SPH = ConsonantBlend(first: .S, second: .P, third: .H, start: true, dynFollowers: nil)
let SPL = ConsonantBlend(first: .S, second: .P, third: .L, start: true, dynFollowers: nil)
let SPR = ConsonantBlend(first: .S, second: .P, third: .R, start: true, dynFollowers: nil)

let SQ = ConsonantBlend(first: .S, second: .Q,
    start: true,
    end: false,
    canPlural: false,
    single: false,
    onlyFollowers: [.U],  // only exists to get to SQU
    finFollowers: [])

let SQU = ConsonantBlend(first: .S, second: .Q, third: .U, start: true,
                         onlyFollowers: [.A, .E, .I, .O], finFollowers: [.E])

let ST = ConsonantBlend(first: .S, second: .T,
    start: true,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in return true },  // allow all cases
    canPlural: true,
    single: false,
    conFollowers: [.L, .R, .Y],       // STYE
    finFollowers: [.E, .Y],
    dynFollowers: nil)

let STR = ConsonantBlend(first: .S, second: .T, third: .R, start: true, dynFollowers: nil)
let SW = ConsonantBlend(first: .S, second: .W, start: true, end: false, single: false)

let TC = ConsonantBlend(first: .T, second: .C,
                        start: false,
                        end: false,
                        canPlural: false,
                        single: false,
                        onlyFollowers: [.H],  //need it to get to TCH
                        finFollowers: [.H])

let TCH = ConsonantBlend(first: .T, second: .C, third: .H, start: false, dynFollowers: nil)

let TH = ConsonantBlend(first: .T, second: .H, start: true, end: true, canPlural: true,
                        single: true, followers: [.R], finFollowers: [.E, .Y],
                        
                        // allow final I for LATHI
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            if pos == .positionLAST && pea.matchesString("LAT", matchFull: true) {
                                return [.I]
                            }
                            else {
                                return []
                            }
                        })

let THR = ConsonantBlend(first: .T, second: .H, third: .R, start: true,
                         
                        // allow final U for THRU
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            if pos == .positionLAST && pea.matchesString("TH", matchFull: true) {
                                return [.U]
                            }
                            else {
                                return []
                            }
                        })

let TL = ConsonantBlend(first: .S, second: .L, start: false, end: false, single: false)
let TR = ConsonantBlend(first: .T, second: .R, start: true, end: false, single: false)
let TW = ConsonantBlend(first: .T, second: .W, start: true, end: false, single: false)

let XT = ConsonantBlend(first: .X, second: .T, start: false, end: true, single: false)

let WH = ConsonantBlend(first: .W, second: .H, start: true, end: false, single: true)
let WR = ConsonantBlend(first: .W, second: .R, start: true, end: false, single: false)

let BB = ConsonantBlend(first: .B, second: .B, start: false, end: false, canPlural: false,
                        single: true, followers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let CC = ConsonantBlend(first: .C, second: .C, start: false, end: false, canPlural: false,
                        single: true, followers: [.H], finFollowers: [], dynFollowers: nil)     // H follower is for GNOCCHI

let DD = ConsonantBlend(first: .D, second: .D, start: false, end: false, canPlural: false,
                        single: true, followers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let FF = ConsonantBlend(first: .F, second: .F, start: false, end: true, canPlural: true,
                        single: true, followers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let GG = ConsonantBlend(first: .G, second: .G, start: false, end: false, canPlural: true,
                        single: true, followers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

// Does this one really exist?
let KK = ConsonantBlend(first: .K, second: .K, start: false, end: false, canPlural: false,
                        single: true, followers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let LL = ConsonantBlend(first: .L, second: .L, start: false, end: true, single: true)
let MM = ConsonantBlend(first: .M, second: .M, start: false, end: false, single: true)

let NN = ConsonantBlend(first: .N, second: .N, start: false,
                        
                        // CONN is the only word ending in NN
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            let firstElement = phonemes.firstElement()
                            
                            if phonemes.numLetters() == 2 && lastElement!.id == "O" &&
                                 firstElement!.id == "C" {
                                return true
                            }
                            else {
                                return false
                            }
                        },
                        canPlural: true, single: true,
                        conFollowers: [],
                        finFollowers: [.Y],
                        dynFollowers: nil)


let PP = ConsonantBlend(first: .P, second: .P, start: false, end: false, canPlural: true,
                        single: true, followers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

// Only word with this combination is BURR or PURR
let RR = ConsonantBlend(first: .R, second: .R,
    start: false,
    verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
        let lastElement = phonemes.lastElement()
        let firstElement = phonemes.firstElement()
    
        if phonemes.numLetters() == 2 && lastElement!.id == "U" &&
            (firstElement!.id == "B" || firstElement!.id == "P") {
            return true
        }
        else {
            return false
        }
    },
    canPlural: true, single: true,
    conFollowers: [], finFollowers: [.Y],
    dynFollowers: nil)

let SS = ConsonantBlend(first: .S, second: .S,
                        start: false,
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
                        },
                        canPlural: true, single: true,
                        conFollowers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let TT = ConsonantBlend(first: .T, second: .T,
                        start: false,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            let firstElement = phonemes.firstElement()
                            
                            // Only words ending in TT are SETT, MATT, MITT, WATT, BUTT
                            if phonemes.numLetters() == 2 {
                                
                                if lastElement!.id == "U" && firstElement!.id == "B" {
                                    return true
                                }
                                else if lastElement!.id == "E" && firstElement!.id == "S" {
                                    return true
                                }
                                else if lastElement!.id == "I" && firstElement!.id == "M" {
                                    return true
                                }
                                else if lastElement!.id == "A" && (firstElement!.id == "M" || firstElement!.id == "W") {
                                    return true
                                }
                                else {
                                    return false
                                }
                            }
                            else {
                                return false
                            }
                        },
                        canPlural: true, single: true,
                        conFollowers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let VV = ConsonantBlend(first: .V, second: .V, start: false, end: false, single: true)

let ZZ = ConsonantBlend(first: .Z, second: .Z, start: false, end: true, canPlural: false,
                        single: true, followers: [.L], finFollowers: [.Y],
                        dynFollowers: nil)

let consonantBlendMap = ["BL":BL, "BR":BR, "CH":CH, "CHR":CHR, "CK":CK, "CL":CL, "CR":CR, "CS":CS, "CT":CT,
    "DG":DG, "DL":DL, "DR":DR, "FL":FL, "FR":FR, "GH":GH, "GHT":GHT, "GN":GN, "GL":GL, "GR":GR,
    "KL":KL, "KN":KN, "KR":KR, "LB":LB, "LC":LC, "LCH":LCH, "LD":LD, "LF":LF, "LG":LG, "LK":LK, "LM":LM,
    "LP":LP, "LS":LS, "LSH":LSH, "LT":LT, "LTH":LTH, "LV":LV, "MB":MB, "MP":MP, "MPT":MPT,
    "NC":NC, "NCH":NCH, "ND":ND, "NG":NG, "NK":NK, "NQ":NQ, "NQU":NQU, "NS":NS, "NT":NT,
    "NTH":NTH, "NZ":NZ, "PH":PH, "PHR":PHR, "PL":PL, "PR":PR, "PS":PS,
    "QU":QU, "RB":RB, "RC":RC, "RCH":RCH, "RD":RD, "RF":RF, "RG":RG, "RH":RH, "RK":RK, "RL":RL,
    "RM":RM, "RN":RN, "RP":RP, "RS":RS, "RSH":RSH, "RST":RST, "RT":RT, "RTH":RTH, "RV":RV, "RZ":RZ,
    "SC":SC, "SCH":SCH, "SCR":SCR, "SH":SH, "SHR":SHR, "SK":SK, "SL":SL, "SM":SM, "SN":SN, "SP":SP,
    "SPH":SPH, "SPL":SPL, "SPR":SPR, "SQ":SQ, "SQU":SQU,
    "ST":ST, "STR":STR, "SW":SW, "TC":TC, "TCH":TCH,
    "TH":TH, "THR":THR,"TL":TL, "TR": TR,  "TW":TW, "XT":XT, "WH":WH, "WR":WR,
    
    "BB":BB, "CC":CC, "DD":DD, "FF":FF, "GG":GG, "KK":KK, "LL":LL, "MM":MM,
    "NN":NN, "PP":PP, "RR":RR, "SS":SS, "TT":TT, "VV":VV, "ZZ":ZZ]
