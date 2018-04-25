//
//  ConsonantBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class ConsonantBlend: LexicalBlend, PhoneticFollowers {
    let initBlend: [Letter]
    let initVowels: [Letter]
    let midBlend: [Letter]
    let midVowels: [Letter]
    let finFollowers: [Letter]
    let blendsWithY: Bool
    let singlePhoneme: Bool
    let preceders: [String]
    let followerTable: [String:[Letter]]
    
    func initialFollowers(nRemain: Int) -> [Letter] {
        
        var initFollowers = initBlend + initVowels
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
        var midFollowers = midBlend + midVowels
        if blendsWithY {
            midFollowers += [.Y]
        }
        if dynFollowers != nil {
            midFollowers += self.dynFollowers!(pea, .positionMIDDLE)
        }
        return midFollowers
    }
    
    func lastFollowers(pea: PhoneticElementArray) -> [Letter] {
        var lastFollowers = finFollowers
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
        
        followerTable: [String:[Letter]],
        
        dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?,   // Callback for context-sensitive followers
        
        verifyEnd: ((PhoneticElementArray) -> Bool)? )       // Callback for context checking at the end of a word
    {
        var start = false
        
        if !initVowels.isEmpty {
            start = true
        }
        
        self.initBlend = initBlend
        self.initVowels = initVowels
        self.midBlend = midBlend
        self.midVowels = midVowels
        self.finFollowers = finFollowers
        self.blendsWithY = blendsWithY
        self.singlePhoneme = single
        self.preceders = preceders
        self.followerTable = followerTable
        
        super.init(first: first, second: second, third: third,
                   canStart: start, canEnd: endOfWord, canPlural: canPlural,
                   dynFollowers: dynFollowers)
        
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
            
            if self.singlePhoneme && (self.first != self.second) {
                return true
            }
            
            else if self.second == .S && self.first != .S {
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
                        followerTable: [
                            "A":[.E, .U, .Y],   // ABLE, ABLUTION, ABLY
                            "O":[.O]],          // OBLONG
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
                        followerTable: [
                            "A":[.A, .E, .U, .Y]],   // ABRASIVE, ABREAST, ABRUPT
                        dynFollowers: nil,
                        verifyEnd: nil)

let CH = ConsonantBlend(first: .C, second: .H, third: nil,
                        initBlend: [.R],
                        initVowels: allVowels,
                        midBlend: [.R],
                        midVowels: allVowels,
                        finFollowers: [.A, .E, .O],     // MOCHA, MACHO, NACHO
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["AU", "EA", "EE", "OA", "OO"],      // possibly AI and IE?
                        followerTable: [
                            "A":[.E, .I, .Y],     // ACHE, ACHING, ACHY
                            "I":[.O]],            // ICHOR
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
                        followerTable: [:],
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
                        followerTable: [:],
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
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.E, .O],   // ACRE, ACROSS
                            "E":[.U]],      // ECRU
                        dynFollowers: nil,
                        verifyEnd: nil)

//let CS = ConsonantBlend(first: .C, second: .S, third: nil,
//                        initBlend: [],
//                        initVowels: [],
//                        midBlend: [.T],         // for ECSTASY
//                        midVowels: allVowels,
//                        finFollowers: [.A],
//                        canPlural: false,
//                        blendsWithY: false,
//                        single: true,
//                        endOfWord: true,
//                        preceders: [],
//                        dynFollowers: nil,
//                        verifyEnd: nil)

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
                        followerTable: [
                            "A":[.E, .I, .O, .S]],      // ACTED, ACTING, ACTOR, ACTS
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
                        followerTable: [
                            "E":[.E, .I]],  // EDGE, EDGING
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
                        followerTable: [
                            "I":[.E, .I, .Y]],      // IDLE, IDLING, IDLY
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
                        followerTable: [
                            "A":[.I, .O]],      // ADRIFT, ADROIT
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
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.A, .O]],      // AFRAID, AFRO
                        dynFollowers: nil,
                        verifyEnd: nil)

let FT = ConsonantBlend(first: .F, second: .T, third: nil,
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
                        followerTable: [
                            "A":[.E],       // AFTER
                            "O":[.E]],      // OFTEN
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
                        followerTable: [
                            "A":[.A]],      // AGHAST
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
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.O],       // AGLOW
                            "I":[.O],       // IGLOO
                            "O":[.E, .I],   // OGLE, OGLING
                            "U":[.I, .Y]],  // UGLIER, UGLY
                        dynFollowers: nil,
                        verifyEnd: nil)

// need GM for PARADIGM, PHLEGM

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
                        followerTable: [
                            "A":[.E, .O],       // AGNES, AGNOSTIC
                            "I":[.O]],          // IGNOBLE
                        dynFollowers: nil,
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            let prevElement = phonemes.nextToLastElement()
                            
                            if prevElement == nil {
                                return true
                            }
                            
                            // ALIGN, ASSIGN, SIGN, DESIGN, RESIGN, BENIGN
                            if lastElement!.id == "I" &&
                                (prevElement!.id == "L" || prevElement!.id == "N" || prevElement!.id == "S" || prevElement!.id == "SS") {
                                return true
                            }
                                
                            // DEIGN, REIGN, FEIGN, PEIGNOIR
                            else if lastElement!.id == "EI" &&
                                (prevElement!.id == "D" || prevElement!.id == "F" || prevElement!.id == "R" || prevElement!.id == "P") {
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
                        followerTable: [
                            "A":[.E],       // AGREE
                            "E":[.E],       // EGRET
                            "O":[.E]],      // OGRE
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
                        followerTable: [:],
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
                        followerTable: [
                            "O":[.A]],      // OKRA
                        dynFollowers: nil,
                        verifyEnd: nil)

let LB = ConsonantBlend(first: .L, second: .B, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: ["U"],
                        followerTable: [
                            "E":[.O]],      // ELBOW
                        dynFollowers: nil,
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                            
                            // Only LB ender is BULB
                            if phonemes.matchesString("BU", matchFull: true) {
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
                        followerTable: [
                            "A":[.H]],      // ALCHEMY
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            
                            // Only word ending in LC is TALC
                            if phonemes.matchesString("TA", matchFull: true) {
                                return true
                            }
                            else {
                                return false
                            }
                        })

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
                        followerTable: [
                            "A":[.E]],      // ALCHEMY
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
                        followerTable: [
                            "A":[.E],       // ALDER
                            "E":[.E],       // ELDER
                            "O":[.E]],      // OLDER    
                        dynFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            // Final E ok for TILDE
                            if phonemes.matchesString("TI", matchFull: true) {
                                return [.E]
                            }
                            else {
                                return []
                            }
                        },
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
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.A],       // ALFALFA
                            "O":[.A]],      // OLFACTORY
                        dynFollowers: nil,
                        verifyEnd: nil)

let LG = ConsonantBlend(first: .L, second: .G, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.A, .E],         // BILGE, BULGE, INDULGE
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "I", "O", "U"],
                        followerTable: [
                            "A":[.A]],      // ALGA, ALGAE
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
                        followerTable: [
                            "A":[.A],       // ALKALINE
                            "E":[.S],       // ELKS
                            "I":[.S]],      // ILKS
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
                        followerTable: [
                            "A":[.O, .S],   // ALMOND, ALMS
                            "E":[.S]],      // ELMS
                        dynFollowers: nil,
                        verifyEnd: nil)

// Only exists for KILN
let LN = ConsonantBlend(first: .L, second: .N, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: ["I"],
                        followerTable: [
                            "U":[.A]],       // for ULNA
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
                        followerTable: [
                            "A":[.E, .H, .I]],      // ALPEN, ALPHA, ALPINE
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
                         followerTable: [
                            "A":[.A]],      // ALPHA
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
                        followerTable: [
                            "A":[.O],       // ALSO
                            "E":[.E, .T],   // ELSE, ELSTER
                            "U":[.T]],      // ULSTER
                        dynFollowers: { (pea:PhoneticElementArray, pos:PositionIndicator) -> [Letter] in
                            
                            // Final A follower for BALSA, SALSA
                            if pos == .positionLAST && pea.matchesSet(["BA", "SA"]) {
                                return [.A]
                            }
                            else {
                                return []
                            }
                        },
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
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.A, .E],       // ALTAR, ALTER
                            "U":[.I]],          // ULTIMATE
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
                        followerTable: [:],
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
                        followerTable: [
                            "E":[.E]],          // ELVES
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
                        followerTable: [
                            "A":[.E, .L, .R],               // AMBER, AMBLE, AMBROSE
                            "E":[.A, .E, .L, .O, .R],       // EMBALM, EMBER, EMBLEM, EMBOLDEN, EMBRACE
                            "U":[.E]],
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
                        followerTable: [
                            "A":[.E, .I, .L, .S],           // AMPERSAND, AMPING, AMPLE, AMPS
                            "E":[.A, .E, .H, .R, .T],       // EMPATHY, EMPEROR, EMPHATIC, EMPRESS, EMPTY
                            "I":[.A, .E, .O, .R, .S, .U],   // IMPART, IMPERIAL, IMPORTANT, IMPRESS, IMPS, IMPULSE
                            "U":[.I, .S, .T]],              // UMPING, UMPS, UMPTEEN
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
                        followerTable: [
                            "E":[.A]],          // EMPHASIZE, EMPHATIC
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
                        followerTable: [
                            "E":[.I, .Y],       // EMPTIES, EMPTY
                            "U":[.E]],          // UMPTEEN
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
                        followerTable: [
                            "A":[.H],                         // ANCHOR
                            "I":[.A, .E, .H, .I, .O, .R, .U], // INCAPABLE, INELEGANT, INCH, INCISION, INCORPORATE, INCREDIBLE, INCUBUS
                            "O":[.O],                         // ONCOLOGY
                            "U":[.A, .E, .I, .L, .O, .U]],    // UNCALM, UNCEASING, UNCIVIL, UNCLE, UNCOOPERATIVE, UNCUBED
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            
                            // Only word with NC ending is ZINC
                            if phonemes.matchesString("ZI", matchFull: true) {
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
                        followerTable: [
                            "A":[.O],           // ANCHOR
                            "I":[.E, .I]],      // INCHES, INCHING
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
                        finFollowers: [.A, .O],         // AGENDA, BANDO?
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.E, .R, .S],
                            "E":[.E, .I, .O, .S],           // ENDED, ENDING, ENDOSCOPY, ENDS
                            "I":[.A, .E, .I, .O, .U, .Y],   // INDEPDENDENT, INDICATE, INDOLENT, INDULGE, INDY
                            "U":[.A, .E, .I, .R, .U]],      // UNDAUNTED, UNDER, UNDIES, UNDRESS, UNDUE
                        dynFollowers: nil,
                        verifyEnd: nil)

let NG = ConsonantBlend(first: .N, second: .G, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.E, .O],         // BINGO, DINGO, GRINGO, CONGO
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.E, .L, .O, .R, .U],       // ANGEL, ANGLE, ANGOLA, ANGRY, ANGULAR
                            "E":[.A, .I, .L, .R, .U],       // ENGAGE, ENGINE, ENGLAND, ENGRAVE, ENGULF
                            "I":[.A, .E, .I, .O, .R, .U]],  // INGENIOUS, INGROWN
                        dynFollowers: nil,
                        verifyEnd: { (phonemes: PhoneticElementArray) -> Bool in
                            let lastElement = phonemes.lastElement()
                            
                            // Vowel blends which can precede final NG: EI (BEING) and II (SKIING)
                            if lastElement is VowelBlend &&
                                (lastElement!.id == "EI" || lastElement!.id == "II") {
                                return true
                            }
                             
                            // All single vowels ok
                            else if lastElement is Vowel {
                                return true
                            }
                            
                            else {
                                return false
                            }
                        })

let NK = ConsonantBlend(first: .N, second: .K, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.H],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.H, .L],           // ANKH, ANKLE
                            "I":[.E, .I, .S],       // INKED, INKING, INKS
                            "U":[.E, .I]],          // UNKEMPT, UNKIND
                        dynFollowers: {(pea: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
    
                            // Approve H follower for ANKH
                            if pea.matchesString("A", matchFull: true) {
                                return [.H]
                            }
                            else {
                                return []
                            }
                        },
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
                        followerTable: [
                            "I":[.U]],      // INQUIET
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
                        followerTable: [
                            "I":[.I]],      // INQUIET
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
                        followerTable: [
                            "E":[.I, .L, .U],                       // ENSIGN, ENSLAVE, ENSURE
                            "I":[.A, .E, .I, .O, .T, .U],           // INSANE, INSENSITIVE, INSOLENT, INSULAR
                            "O":[.E],                               // ONSET
                            "U":[.A, .E, .H, .I, .O, .P, .T, .U]],  // UNSHAKEN, UNSOLD, UNSTABLE, UNSUNG
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
                        followerTable: [
                            "A":[.E, .H, .I, .O, .R],       // ANTE, ANTHEM, ANTI, ANTONYM, ANTHRAX
                            "E":[.A, .E, .H, .O, .R],       // ENTAIL, ENTER, ENTHRALL, ENTOMB, ENTROPY
                            "I":[.A, .E, .I, .O],           // INTANGIBLE, INTENT, INTONE,
                            "O":[.O],                       // ONTO
                            "U":[.H, .I, .O, .R]],          // UNTHINKABLE, UNTIMELY, UNTO, UNTRIED
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
                        followerTable: [
                            "A":[.R],
                            "E":[.R]],
                        dynFollowers: nil,
                        verifyEnd: nil)
// let NZ = ConsonantBlend(first: .N, second: .Z, start: false, end: false, single: false)

let PH = ConsonantBlend(first: .P, second: .H, third: nil,
                        initBlend: [.R],
                        initVowels: [.A, .E, .O],
                        midBlend: [.L, .R],
                        midVowels: [.A, .E, .I, .O],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "I", "O", "Y"],     // GRAPH, CIPHER, GOPHER, CYPHER
                        followerTable: [
                            "A":[.O]],          // APHORISM
                        dynFollowers: nil,
                        verifyEnd: nil)

let PHL = ConsonantBlend(first: .P, second: .H, third: .L,
                         initBlend: [],
                         initVowels: [.E],      // PHLEGM, PHLEBOTOMY
                         midBlend: [],
                         midVowels: [],
                         finFollowers: [],
                         canPlural: false,
                         blendsWithY: false,
                         single: false,
                         endOfWord: false,
                         preceders: [],
                         followerTable: [:],
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
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.E, .O],           // APLENTY, APLOMB
                            "U":[.I, .O]],          // UPLIFT, UPLOAD
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
                        followerTable: [
                            "O":[.Y]],          // OPRY
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
                        followerTable: [
                            "A":[.E],                   // APSE
                            "E":[.I],                   // EPSILON
                            "U":[.E, .I, .T, .W]],      // UPSELL, UPSIDE, UPSTANDING, UPSWING
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
                        followerTable: [:],
                        dynFollowers: nil,
                        verifyEnd: nil)

let PT = ConsonantBlend(first: .P, second: .T, third: nil,
                         initBlend: [],
                         initVowels: [],
                         midBlend: [.H, .R],
                         midVowels: allVowels,
                         finFollowers: [],
                         canPlural: true,
                         blendsWithY: false,
                         single: false,
                         endOfWord: true,
                         preceders: ["A", "E", "O"],
                         followerTable: [
                            "A":[.E, .I],               // APTER, APTITUDE
                            "O":[.E, .H, .I, .O, .S],   // OPTED, OPTHAMOLOGIST, OPTIC, OPTOMETRIST, OPTS
                            "U":[.I, .O]],              // UPTICK, UPTON
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
                        followerTable: [
                            "A":[.A],               // AQUA
                            "E":[.A, .E, .I]],      // EQUAL, EQUESTRIAN, EQUINE
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
                        followerTable: [
                            "O":[.S],           // ORBS
                            "U":[.A]],          // URBAN
                        dynFollowers: nil,
                        verifyEnd: nil)

let RC = ConsonantBlend(first: .R, second: .C, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],
                        midVowels: allVowels,
                        finFollowers: [.H],     // maybe add E & K
                        canPlural: false,       // could be true for ARCS
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.H, .I, .O, .S, .T],       // ARCH, ARCING, ARCO, ARCS, ARCTANGENT
                            "O":[.H, .S],                   // ORCHESTRA, ORCS
                            "U":[.H]],                      // URCHIN
                        dynFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
                            
                            // Only allow plural for ARCS and ORCS
                            if pos == .positionLAST && phonemes.matchesSet(["A", "O"]) {
                                return [.S]
                            }
                            else {
                                return []
                            }
                        },
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
                        followerTable: [
                            "A":[.A, .E, .I, .L],       // ARCHANGEL, ARCHES, ARCHING, ARCHLY
                            "O":[.E],                   // ORCHESTRA
                            "U":[.I]],                  // URCHIN
                        dynFollowers: nil,
                        verifyEnd: nil)

let RD = ConsonantBlend(first: .R, second: .D, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "EA", "EI", "I", "O", "OA", "U"],
                        followerTable: [
                            "A":[.U],               // ARDUOUS
                            "AA":[.R],              // AARDVARK
                            "O":[.A, .E, .I],       // ORDAIN, ORDER, ORDINAL
                            "U":[.U]],              // URDU
                        dynFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow final E for HORDE
                            if phonemes.matchesString("HO", matchFull: true) {
                                return [.E]
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
                        followerTable: [:],
                        dynFollowers: nil,
                        verifyEnd: nil)

let RG = ConsonantBlend(first: .R, second: .G, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.E, .O],             // CARGO, EMBARGO, LARGO
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.U, .Y],       // ARGUE, ARGYLE
                            "E":[.S],           // ERGS
                            "O":[.A, .I, .Y],   // ORGAN, ORGIES, ORGY
                            "U":[.E, .I]],      // URGES, URGING
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
                        initVowels: [.A, .E, .I],       // RHAPSODY, RHEA, RHINO
                        midBlend: [],
                        midVowels: [],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.S],               // ARKS
                            "I":[.E, .I, .S]],      // IRKED, IRKING, IRKS
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
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.A, .E, .I, .S]],          // ARMADILLO, ARMED, ARMIES, ARMS
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
                        followerTable: [
                            "U":[.S]],              // URNS
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
                        followerTable: [
                            "O":[.H]],          // ORPHAN
                        dynFollowers: nil,
                        verifyEnd: nil)

// probably need RPH    for MORPH

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
                        followerTable: [
                            "A":[.E, .O],               // ARSENIC, ARSON
                            "E":[.E, .I, .T]],          // ERSE, ERSINE
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
                        followerTable: [:],
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
                        followerTable: [
                            "E":[.W]],              // ERSTWHILE
                        dynFollowers: nil,
                        verifyEnd: nil)

let RT = ConsonantBlend(first: .R, second: .T, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H, .L, .S],
                        midVowels: allVowels,
                        finFollowers: [.A, .H, .Z],     // AORTA, HERTZ, QUARTZ
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.H, .I, .S],       // ARTHUR, ARTIST, ARTSY
                            "O":[.H, .S],           // ORTHOPEDIC, ORTS
                            "U":[.E]],              // URTEXT
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
                        followerTable: [
                            "A":[.U],           // ARTHUR
                            "O":[.O]],          // ORTHOPEDIC
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
                        followerTable: [
                            "O":[.I]],          // ORVILLE
                        dynFollowers: nil,
                        verifyEnd: nil)

//let RZ = ConsonantBlend(first: .R, second: .Z, third: nil,
//                        initBlend: [],
//                        initVowels: [],
//                        midBlend: [.L],
//                        midVowels: allVowels,
//                        finFollowers: [],
//                        canPlural: false,
//                        blendsWithY: true,
//                        single: false,
//                        endOfWord: false,
//                        preceders: ["A", "E", "I", "O", "U"],
//                        followerTable: [:],
//                        dynFollowers: nil,
//                        verifyEnd: nil)

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
                        followerTable: [
                            "A":[.E, .O, .R],       // ASCEND, ASCOT, ASCRIBE
                            "E":[.H, .O, .R]],      // ESCHEW, ESCORT, ESCROW
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
                        followerTable: [
                            "E":[.E]],          // ESCHEW
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
                        followerTable: [
                            "A":[.I],           // ASCRIBE
                            "E":[.O]],          // ESCROW
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
                        followerTable: [
                            "A":[.E, .R, .Y],       // ASHEN, ASHRAM, ASHY
                            "U":[.E]],              // USHER
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
                        followerTable: [
                            "A":[.A]],              // ASHRAM
                        dynFollowers: nil,
                        verifyEnd: nil)

let SK = ConsonantBlend(first: .S, second: .K, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "U"],
                        followerTable: [
                            "A":[.A, .E, .I, .S]],      // ASKANCE, ASKED, ASKING, ASKS
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
                        followerTable: [
                            "A":[.E],           // ASLEEP
                            "AI":[.E]],         // AISLE
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
                        followerTable: [
                            "O":[.A]],
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
                        followerTable: [
                            "E":[.E]],              // ESNE
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
                        followerTable: [
                            "A":[.E, .I],           // ASPEN, ASPIC
                            "E":[.E, .L, .Y],       // ESPECIALLY, ESPLENADE, ESPY
                            "O":[.R]],              // OSPREY
                        dynFollowers: nil,
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in
                            
                            // Final SP words: CLASP, CRISP, HASP, LISP, WASP, WISP
                            if pea.matchesSet(["CLA", "CRI", "HA", "LI", "WA", "WI"]) {
                                return true
                            }
                            else {
                                return false
                            }
                        })     // HASP, WASP, LISP

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
                        followerTable: [:],
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
                        followerTable: [
                            "E":[.E]],
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
                        followerTable: [
                            "O":[.E]],
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
                        followerTable: [
                            "E":[.U]],
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
                        followerTable: [
                            "E":[.I]],              // ESQUIRE
                        dynFollowers: nil,
                        verifyEnd: nil)

let ST = ConsonantBlend(first: .S, second: .T, third: nil,
                        initBlend: [.R],
                        initVowels: allVowels,
                        midBlend: [.L, .R],
                        midVowels: allVowels,
                        finFollowers: [.E, .O],     // PESTO, MANIFESTO
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "AU", "E", "EA", "EI", "I", "IE", "O", "OA", "OI", "OO", "OU", "U", "UE"],
                        followerTable: [
                            "A":[.A, .E, .I, .O, .R],   // ASTAR, ASTER, ASTIR, ASTOR, ASTRIDE
                            "E":[.E],                   // ESTER
                            "I":[.H],                   // ISTHMUS
                            "O":[.E, .R]],              // OSTER, OSTRICH
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
                        followerTable: [
                            "A":[.A, .I],               // ASTRAY, ASTRIDE
                            "O":[.I]],                  // OSTRICH
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
                        followerTable: [:],
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
                        followerTable: [
                            "E":[.H],       // ETCH
                            "I":[.H]],      // ITCH
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
                        followerTable: [
                            "E":[.E, .I],            // ETCHES, ETCHING
                            "I":[.E, .I, .Y]],       // ITCHES, ITCHING, ITCHY
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
                        followerTable: [
                            "E":[.E],               // ETHER
                            "O":[.E]],              // OTHER
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
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.A]],              // ATLAS
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
                        followerTable: [
                            "A":[.O]],          // ATROPHY
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:],
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
                        followerTable: [
                            "E":[.A, .E, .R],           // EXTANT, EXTENT, EXTRA
                            "O":[.A]],                  // OXTAIL
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
                        followerTable: [
                            "A":[.I]],              // AWHILE
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:],
                        dynFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
                            
                            // Approve final I for RABBI
                            if pos == .positionLAST && phonemes.matchesString("RA", matchFull: true) {
                                return [.I]
                            }
                            else {
                                return []
                            }
                        },
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
                        followerTable: [:], dynFollowers: nil,
                        verifyEnd: nil)

let DD = ConsonantBlend(first: .D, second: .D, third: nil,
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:], dynFollowers: nil,
                        verifyEnd: nil)

let NN = ConsonantBlend(first: .N, second: .N, third: nil,
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:], dynFollowers: nil,
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
                        midBlend: [.L],             // HASSLE, TUSSLE
                        midVowels: allVowels,
                        finFollowers: [.O],         // LASSO
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:], dynFollowers: nil,
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
                        followerTable: [:], dynFollowers: nil,
                        verifyEnd: nil)         // BUZZ, FIZZ, FUZZ

let consonantBlendMap = ["BL":BL, "BR":BR, "CH":CH, "CHR":CHR, "CK":CK, "CL":CL, "CR":CR, /*"CS":CS,*/ "CT":CT,
                         "DG":DG, "DL":DL, "DR":DR, "FL":FL, "FR":FR, "FT":FT, "GH":GH, "GHT":GHT, "GN":GN, "GL":GL, "GR":GR,
                         /* "KL":KL,*/ "KN":KN, "KR":KR, "LB":LB, "LC":LC, "LCH":LCH, "LD":LD, "LF":LF, "LG":LG, "LK":LK, "LM":LM,
                         "LN":LN, "LP":LP, "LPH":LPH, "LS":LS, "LSH":LSH, "LT":LT, "LTH":LTH, "LV":LV,
                         "MB":MB, "MP":MP, "MPH":MPH, "MPT":MPT,
    "NC":NC, "NCH":NCH, "ND":ND, "NG":NG, "NK":NK, "NQ":NQ, "NQU":NQU, "NS":NS, "NT":NT,
    "NTH":NTH, /* "NZ":NZ,*/ "PH":PH, "PHL":PHL, "PHR":PHR, "PL":PL, "PR":PR, "PS":PS, "PT":PT,
    "QU":QU, "RB":RB, "RC":RC, "RCH":RCH, "RD":RD, "RF":RF, "RG":RG, "RH":RH, "RK":RK, "RL":RL,
    "RM":RM, "RN":RN, "RP":RP, "RS":RS, "RSH":RSH, "RST":RST, "RT":RT, "RTH":RTH, "RV":RV, /* "RZ":RZ, */
    "SC":SC, "SCH":SCH, "SCR":SCR, "SH":SH, "SHR":SHR, "SK":SK, "SL":SL, "SM":SM, "SN":SN, "SP":SP,
    "SPH":SPH, "SPL":SPL, "SPR":SPR, "SQ":SQ, "SQU":SQU, "ST":ST, "STR":STR, "SW":SW,
    "TC":TC, "TCH":TCH, "TH":TH, "THR":THR, "TL":TL, "TR":TR, "TW":TW, "TZ":TZ,
    "WH":WH, "WR":WR, "XT":XT, "BB":BB, "CC":CC, "DD":DD, "FF":FF, "GG":GG, /* "KK":KK, */ "LL":LL, "MM":MM,
    "NN":NN, "PP":PP, "RR":RR, "SS":SS, "TT":TT, "VV":VV, "ZZ":ZZ]
