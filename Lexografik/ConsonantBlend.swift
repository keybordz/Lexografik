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
    
    func secondFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter] {
        let firstElement = syll.initialVowel()
        
        if let secondFollowers = followerTable[firstElement!.id] {
            return secondFollowers
        }
        else {
            return []
        }
    }
    
    func midFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter] {
        var midFollowers = midBlend + midVowels
        if blendsWithY {
            midFollowers += [.Y]
        }
        if dynFollowers != nil {
            midFollowers += self.dynFollowers!(syll, .positionMIDDLE)
        }
        return midFollowers
    }
    
    func lastFollowers(syll: SyllabicArray) -> [Letter] {
        var lastFollowers = finFollowers
        if blendsWithY {
            lastFollowers += [.Y]
        }
        if canPlural {
            lastFollowers += [.S]
        }
        if dynFollowers != nil {
            lastFollowers += self.dynFollowers!(syll, .positionLAST)
        }
        return lastFollowers
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
        
        dynFollowers: ((SyllabicArray, PositionIndicator) -> [Letter])?,   // Callback for context-sensitive followers
        
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
    }
    
    // By default, blends that are combinations of sounds should only follow single vowels
    // The exceptions are the H-blends that consititute a single sound (TH, PH, CH, SH)
    // Also blends with a final S (BEANS, BOARS, SOAPS)
    // Same things applies for double consonants with exception of SS
    func defaultVerifyEnd(_ phonemes: PhoneticElementArray) -> Bool {
        let lastElement = phonemes.lastElement()
        
        // Use this to filter out some weird endings like NLK
        if (lastElement! is Consonant || lastElement! is ConsonantBlend) && lastElement!.id != "Y" {
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
        
        // Ok with any preceding single vowels
        else {
            return true
        }
    }
}

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
                        followerTable: [
                            "A":[.E, .O],           // ABBEY, ABBOTT
                            "E":[.E, .I, .S]],      // EBBED, EBBING, EBBS
    dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        
        // Approve final I for RABBI
        if pos == .positionLAST && syll.matchesString("RA", matchFull: false) {
            return [.I]
        }
        else {
            return []
        }
    },
    verifyEnd: nil)

let BL = ConsonantBlend(first: .B, second: .L, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,           // always true for liquids
                        endOfWord: false,
                        preceders: ["A", "AU", "E", "EA", "EE", "I", "IA", "O", "OA", "OI", "OU", "U", "UA"],
                        followerTable: [
                            "A":[.A, .E, .U, .Y],   // ABLAZE, ABLE, ABLUTION, ABLY
                            "O":[.O]],              // OBLONG
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Approve A follower for TABLA
                            if pos == .positionLAST && syll.matchesString("TA", matchFull: false) {
                                return [.A]
                            }
                            else {
                                return []
                            }
                        },
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
                            "A":[.A, .E, .O, .U, .Y]],   // ABRASIVE, ABREAST, ABROAD, ABRUPT
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) in
                            var followers: [Letter] = []
                            
                            if pos == .positionLAST {
                                
                                // Approve final A for UMBRA
                                if syll.matchesString("UM", matchFull: false) {
                                    followers += [.A]
                                }
                            }
                            return followers
                        },
                        verifyEnd: nil)

let BT = ConsonantBlend(first: .B, second: .T, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.E, .I, .O],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [:],
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
                        single: false,          // false for all double consonants for splitting purposes
                        endOfWord: false,
                        preceders: [],
                        followerTable: [
                            "A":[.E, .L, .O, .R],       // ACCEPT, ACCLAIM, ACCOST, ACCRUE
                            "E":[.L],                   // ECCLESIASTIC
                            "O":[.A, .I, .U]],          // OCCAM, OCCIPITER, OCCUPY
                        dynFollowers: nil,
                        verifyEnd: nil)

let CH = ConsonantBlend(first: .C, second: .H, third: nil,
                        initBlend: [.R],
                        initVowels: allVowels,
                        midBlend: [.R, .T],
                        midVowels: allVowels,
                        finFollowers: [],    
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["AU", "EA", "EE", "OA", "OO"],      // possibly AI and IE?
                        followerTable: [
                            "A":[.E, .I, .Y],     // ACHE, ACHING, ACHY
                            "I":[.O]],            // ICHOR
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            let lastElement = syll.lastElement()
                            
                            if pos == .positionLAST {
                                
                                // Only approve final A for MOCHA
                                if syll.matchesString("MO", matchFull: false) {
                                    followers += [.A]
                                }
                                
                                // Approve final E for CLOCHE, NICHE
                                if syll.matchesSet(["CLO", "NI"]) {
                                    followers += [.E]
                                }
                                
                                // Approve final I follower for GNOCCHI
                                if syll.matchesString("GNOC", matchFull: true) {
                                    followers += [.I]
                                }
                                
                                // Approve final O only if preceding vowel is A (MACHO, NACHO)
                                // Likewise final E only for "ACHE" words (could be some OCHE words?)
                                if lastElement!.id == "A" {
                                    followers += [.E, .O]
                                }
                                
                                // Approve final T for YACHT
                                if syll.matchesSet(["YA"]) {
                                    followers += [.T]
                                }
                            }
                            return followers
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

// For YACHT, any others?
let CHT = ConsonantBlend(first: .C, second: .H, third: .T,
                         initBlend: [],
                         initVowels: [],
                         midBlend: [],
                         midVowels: [.E, .I],
                         finFollowers: [],
                         canPlural: true,
                         blendsWithY: false,
                         single: true,
                         endOfWord: true,
                         preceders: [],
                         followerTable: [:],
                         dynFollowers: nil,
                         verifyEnd: nil)

let CK = ConsonantBlend(first: .C, second: .K, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: [.E, .I, .O],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,          // for splitting purposes only
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
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        followerTable: [:],
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) in
                            let lastElement = syll.lastElement()
                            
                            // Final CLE words: ICICLE, BARNACLE, MONOCLE, TREACLE, UNCLE
                            if lastElement!.id == "I" || lastElement!.id == "A" ||
                                lastElement!.id == "O" || lastElement!.id == "N" || lastElement!.id == "EA" {
                                return [.E]
                            }
                            else {
                                return []
                            }
                        },
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
                            "A":[.E, .I, .O, .S],       // ACTED, ACTING, ACTOR, ACTS
                            "E":[.O],                   // ECTOPLASM
                            "O":[.A, .E]],              // OCTANE/OCTAVE, OCTET
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            
                            // Allow final I follower for CACTI and A for RECTA
                            if pos == .positionLAST {
                                if syll.matchesString("CA", matchFull: false) {
                                    followers += [.I]
                                }
                                else if syll.matchesSet(["DI", "RE"]) {
                                    followers += [.A]
                                }
                            }
                            return followers
                        },
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in return true })

let DD = ConsonantBlend(first: .D, second: .D, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [
                            "A":[.E, .I, .L, .S],       // ADDED, ADDING, ADDLE, ADDS
                            "O":[.E, .I, .L, .S],       // ODDER, ODDITY, ODDLY, ODDS
                            "U":[.E]],                  // UDDER
                        dynFollowers: nil,
                        verifyEnd: nil)

let DG = ConsonantBlend(first: .D, second: .G, third: nil,
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
                            "E":[.E, .I, .Y]],      // EDGE, EDGING, EDGY
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
                        single: true,
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

let DT = ConsonantBlend(first: .D, second: .T, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [:],
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) in
                            var followers: [Letter] = []
                            let lastElement = syll.lastElement()
                            
                            // Allow final H follower for BREADTH, WIDTH, etc.
                            if pos == .positionLAST && lastElement!.id == "EA" || lastElement!.id == "I" {
                                followers += [.H]
                            }
                            return followers
                        },
                        verifyEnd: nil)

let DTH = ConsonantBlend(first: .D, second: .T, third: .H,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [:],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in return true })

let DW = ConsonantBlend(first: .D, second: .W, third: nil,
                        initBlend: [],
                        initVowels: [.A, .E, .I],
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

let FF = ConsonantBlend(first: .F, second: .F, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [.E],         // GAFFE, GIRAFFE
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "I", "O", "U"],
                        followerTable: [
                            "A":[.A, .E, .I, .L, .O],           // AFFABLE, AFFECT, AFFIRM, AFFLUENT, AFFORD
                            "E":[.A, .E, .I, .O],               // EFFACE, EFFECT, EFFICIENT, EFFORT
                            "O":[.A, .B, .E, .H, .I, .L, .S]],  // OFFAL, OFFBASE, OFFER, OFFHAND, OFFICE, OFFLINE, OFFSET
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
                        single: true,
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

let FTH = ConsonantBlend(first: .F, second: .T, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [:],
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
                        single: false,
                        endOfWord: true,        // EGG, YEGG
                        preceders: [],
                        followerTable: [
                            "A":[.R],           // AGGREGATE
                            "E":[.S,. Y]],      // EGGS, EGGY
                        dynFollowers: nil,
                        verifyEnd: nil)

let GH = ConsonantBlend(first: .G, second: .H, third: nil,          // this is really a diphthong!!!
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
                            "A":[.A],        // AGHAST
                            "EI":[.T]],      // EIGHT
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            
                            let lastElement = syll.lastElement()
                            
                            if pos != .positionFIRST {
                                if lastElement!.id == "I" || lastElement!.id == "EI" ||
                                    lastElement!.id == "AU" || lastElement!.id == "OU" {
                                    followers += [.T]
                                }
                            }
                            
                            // Final Y only for DINGHY
                            if pos == .positionLAST && syll.matchesString("DIN", matchFull: true) {
                                followers += [.Y]
                            }
                            return followers
                        },
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in return true })

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
                        followerTable: [
                            "EI":[.E, .S, .Y],         // EIGHTEEN, EIGHTS, EIGHTY
                            "OU":[]],
                        dynFollowers: nil,
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in return true })

let GL = ConsonantBlend(first: .G, second: .L, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        followerTable: [
                            "A":[.O],       // AGLOW
                            "I":[.O],       // IGLOO
                            "O":[.E, .I],   // OGLE, OGLING
                            "U":[.I, .Y]],  // UGLIER, UGLY
                        dynFollowers: nil,
                        verifyEnd: nil)

let GM = ConsonantBlend(first: .G, second: .M, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: true,
                        endOfWord: true,
                        preceders: ["E", "I"],   // need GM for PARADIGM, PHLEGM
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.E, .O],       // AGNES, AGNOSTIC
                            "I":[.O]],          // IGNOBLE
                        dynFollowers: nil,
                        verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in return true })

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

let KK = ConsonantBlend(first: .K, second: .K, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.E, .I],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: ["E"],
                        followerTable: [:],
                        dynFollowers: nil,
                        verifyEnd: nil)

let KL = ConsonantBlend(first: .K, second: .L, third: nil,
                        initBlend: [],
                        initVowels: allVowels,
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: [],
                        followerTable: [:],
                        dynFollowers: nil,
                        verifyEnd: nil)

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
                        midBlend: [.R],           // Don't like R being here but works for now
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: ["U"],
                        followerTable: [
                            "A":[.E, .I],       // ALBEIT, ALBINO
                            "E":[.O]],          // ELBOW
                        dynFollowers: nil,
                        verifyEnd: nil)

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
                            "A":[.H],       // ALCHEMY
                            "U":[.E]],      // ULCER
                        dynFollowers: nil,
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                        preceders: ["E", "I", "U"],     // SQUELCH, FILCH, MULCH
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
                            "A":[.E],       // ALDER(MAN)
                            "E":[.E],       // ELDER
                            "O":[.E]],      // OLDER    
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            
                            if pos == .positionLAST {

                                // Final E ok for TILDE
                                if syll.matchesString("TI", matchFull: false) {
                                    followers += [.E]
                                }
                                
                                // Allow final T for VELDT
                                if syll.matchesString("VE", matchFull: false) {
                                    followers += [.T]
                                }
                            }
                            return followers
                        },
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })     // allow all cases

let LDT = ConsonantBlend(first: .L, second: .D, third: .T,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: ["E"],       // VELDT
                        followerTable: [:],
                        dynFollowers: nil,
                        verifyEnd: nil)

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
                            "A":[.A],           // ALFALFA
                            "E":[.I, .L],       // ELFLIKE
                            "O":[.A]],          // OLFACTORY
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

let LL = ConsonantBlend(first: .L, second: .L, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [
                            "A":[.A, .E, .I, .O, .Y],    // ALLAY, ALLEN, ALLIES, ALLOY, ALLY
                            "I":[.E, .I, .O, .S, .U],    // ILLEGIBLE, ILLOGICAL, ILLICIT, ILLS, ILLUSTRATE
                            "O":[.A]],                   // OLLA
                        dynFollowers: {(syll: SyllabicArray, pos:PositionIndicator) -> [Letter] in
                            
                            // Return final O follower for HALLO, HELLO
                            if pos == .positionLAST && syll.matchesSet(["HA", "HE"]) {
                                return [.O]
                            }
                            else {
                                return []
                            }
                        },
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
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Approve final A for ULNA
                            if pos == .positionLAST && syll.matchesString("U", matchFull: false) {
                                return [.A]
                            }
                            else {
                                return []
                            }
                        },
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
                            "A":[.A, .E, .H, .I]],      // ALPACA, ALPEN, ALPHA, ALPINE
                        dynFollowers: nil,
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                         dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Return final A follower for ALPHA
                            if pos == .positionLAST && syll.matchesString("A", matchFull: false) {
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
                        dynFollowers: { (syll: SyllabicArray, pos:PositionIndicator) -> [Letter] in
                            
                            // Final A follower for BALSA, SALSA
                            if pos == .positionLAST && syll.matchesSet(["BA", "SA"]) {
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
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "AU", "E", "EA", "I", "O", "U"],      // MALT, FAULT, PELT, DEALT, HILT, COLT, VULTURE
                        followerTable: [
                            "A":[.A, .E, .O],       // ALTAR, ALTER, ALTO
                            "U":[.I, .R]],          // ULTIMATE, ULTRA
                        dynFollowers: { (syll: SyllabicArray, pos:PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            let lastElement = syll.lastElement()
                            
                            if pos == .positionLAST {
                                
                                // Final A follower for DELTA
                                if syll.matchesSet(["DE"]) {
                                    followers += [.A]
                                }
                                // Final H follower for FILTH, HEALTH, WEALTH, STEALTH, etc.
                                if lastElement!.id == "EA" || lastElement!.id == "I" {
                                    followers += [.H]
                                }
                            }

                            return followers
                        },
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                            "A":[.E, .L, .R],                // AMBER, AMBLE, AMBROSE
                            "I":[.U],
                            "E":[.A, .E, .L, .O, .R],        // EMBALM, EMBER, EMBLEM, EMBOLDEN, EMBRACE
                            "U":[.E, .R]],                   // UMBER, UMBRA(GE)
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            
                            if pos == .positionLAST {
                                
                                // Final A followers for R(H)UMBA and SAMBA
                                if syll.matchesSet(["RHU", "RU", "SA"]) {
                                    followers += [.A]
                                }
                                
                                // Final O follower for DUMBO, JUMBO, MAMBO
                                if syll.matchesSet(["DU", "JU", "MA"]) {
                                    followers += [.O]
                                }
                            }
                            
                            return followers
                        },
                        verifyEnd: nil)

let MM = ConsonantBlend(first: .M, second: .M, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        followerTable: [
                            "A":[.A, .E, .I, .O, .U],
                            "I":[.A, .E, .I, .O, .U]],      // IMMATURE, IMMENSE, IMMINENT, IMMOBILE
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) in
                            var followers: [Letter] = []
                            
                            if pos == .positionLAST {
                                
                                // Approve final A for GAMMA
                                if syll.matchesString("GA", matchFull: false) {
                                    followers += [.A]
                                }
                            }
                            return followers
                        },
                        verifyEnd: nil)

let MN = ConsonantBlend(first: .M, second: .N, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.E, .I, .O],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: true,
                        endOfWord: true,
                        preceders: ["A", "E", "U"],     // DAMN, SOLEMN, COLUMN, AUTUMN
                        followerTable: [:],
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
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow final O follower for TEMPO
                            if pos == .positionLAST && syll.matchesSet(["TE"]) {
                                return [.O]
                            }
                            else {
                                return []
                            }
                        },
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
                            "E":[.A, .R],                     // ENCASE, ENCRUST
                            "I":[.A, .E, .H, .I, .O, .R, .U], // INCAPABLE, INCELIBATE, INCH, INCISION, INCOMPLETE, INCREDIBLE, INCUR
                            "O":[.E, .O],                     // ONCE, ONCOLOGY
                            "OU":[.E],                        // OUNCE
                            "U":[.A, .E, .I, .L, .O, .U]],    // UNCALM, UNCEASING, UNCIVIL, UNCLE, UNCOOPERATIVE, UNCUBED
                        dynFollowers: nil,
                        verifyEnd: nil)

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
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow final O follower for HONCHO, PONCHO
                            if pos == .positionLAST && syll.matchesSet(["HO", "PO"]) {
                                return [.O]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: {(pea: PhoneticElementArray) -> Bool in return true })

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
                            "E":[.E, .I, .O, .S, .U],       // ENDED, ENDING, ENDOSCOPY, ENDS, ENDURE
                            "I":[.A, .E, .I, .O, .U, .Y],   // INDEPDENDENT, INDICATE, INDOLENT, INDULGE, INDY
                            "U":[.A, .E, .I, .R, .U]],      // UNDAUNTED, UNDER, UNDIES, UNDRESS, UNDUE
                        dynFollowers: nil,
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

let NG = ConsonantBlend(first: .N, second: .G, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],         // H is for DINGHY
                        midVowels: allVowels,
                        finFollowers: [.E],
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.E, .L, .O, .R, .S, .U],   // ANGEL, ANGLE, ANGOLA, ANGRY, ANGST, ANGULAR
                            "E":[.A, .I, .L, .R, .U],       // ENGAGE, ENGINE, ENGLAND, ENGRAVE, ENGULF
                            "I":[.A, .E, .I, .O, .R, .U]],  // INGENIOUS, INGROWN
    
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            let lastElement = syll.lastElement()

                            if pos == .positionLAST {
                                
                                // Approve final I for FUNGI
                                if syll.matchesString("FU", matchFull: false) {
                                    followers += [.I]
                                }
                                
                                // Approve final O for A/E/I vowels, i.e. TANGO, BINGO, BONGO
                                if lastElement!.id == "A" || lastElement!.id == "I" || lastElement!.id == "O" {
                                    followers += [.O]
                                }
                            }
                            
                            else if pos == .positionMIDDLE {
                                if syll.matchesString("DI", matchFull: false) {
                                    followers += [.H]
                                }
                            }
                            return followers
                        },
                        verifyEnd: nil)

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
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            
                            // Approve H follower for ANKH
                            if syll.matchesString("A", matchFull: false) {
                                followers += [.H]
                            }
                            
                            // Approve E follower for MINKE
                            if syll.matchesString("MI", matchFull: false) {
                                followers += [.E]
                            }
                            return followers
                        },
                        verifyEnd: nil)

let NN = ConsonantBlend(first: .N, second: .N, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [
                            "A":[.A, .E, .O, .U],           // ANNAL, ANNEX, ANNOY/ANNOUNCE, ANNUL
                            "E":[.U],                       // ENNUI
                            "I":[.S],                       // INNS
                            "U":[.A, .E, .I, .O, .U]],      // UNNATURAL, UNNESTED, UNNOTICED, UNNUMBERED
                        dynFollowers: nil,
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                            "I":[.U]],      // INQUIRE
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
                            "I":[.I, .U]],      // INQUIRE
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
                            "E":[.I, .L, .U],                       // ENSIGN, ENSLAVE, ENSURE/ENSUING
                            "I":[.A, .C, .E, .I, .O, .T, .U],       // INSANE, INSCRIBE, INSENSITIVE, INSOLENT, INSULAR
                            "O":[.E],                               // ONSET
                            "U":[.A, .E, .H, .I, .O, .P, .T, .U]],  // UNSHAKEN, UNSOLD, UNSTABLE, UNSUNG
                        dynFollowers: nil,
                        verifyEnd: nil)

let NT = ConsonantBlend(first: .N, second: .T, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H, .L, .R],
                        midVowels: allVowels,
                        finFollowers: [.H, .O],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "AI", "E", "EI", "I", "O", "OI", "U"],
                        followerTable: [
                            "A":[.E, .H, .I, .O, .R, .S],   // ANTE, ANTHEM, ANTI, ANTONYM, ANTHRAX, ANTS
                            "E":[.A, .E, .H, .O, .R],       // ENTAIL, ENTER, ENTHRALL, ENTOMB, ENTROPY
                            "I":[.A, .E, .I, .O, .R],       // INTANGIBLE, INTENT, INTONE, INTRIGUE
                            "O":[.O],                       // ONTO
                            "U":[.H, .I, .O, .R]],          // UNTHINKABLE, UNTIMELY, UNTO, UNTRIED
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            
                            if pos == .positionLAST {
                                
                                // Approve final I for ANTI, VENTI
                                if syll.matchesSet(["A", "VE"]) {
                                    followers += [.I]
                                }
                                
                                // Approve final A for MANTA
                                if syll.matchesString("MA", matchFull: false) {
                                    followers += [.A]
                                }
                            }
                            return followers
                        },
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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

let PH = ConsonantBlend(first: .P, second: .H, third: nil,
                        initBlend: [.R],
                        initVowels: [.A, .E, .O],
                        midBlend: [.L, .R],
                        midVowels: [.A, .E, .I, .O],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: true,
                        endOfWord: true,
                        preceders: ["A", "I", "O", "Y"],     // GRAPH, CIPHER, GOPHER, CYPHER
                        followerTable: [
                            "A":[.I, .O],       // APHID, APHORISM
                            "E":[.E],           // EPHEMERAL
                            "U":[.E, .O]],      // UPHELD, UPHOLD
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
                        single: true,
                        endOfWord: false,
                        preceders: ["A", "EE", "EO", "I", "O", "OO", "U"],
                        followerTable: [
                            "A":[.E, .O],           // APLENTY, APLOMB
                            "U":[.I, .O]],          // UPLIFT, UPLOAD
                        dynFollowers: nil,
                        verifyEnd: nil)

let PP = ConsonantBlend(first: .P, second: .P, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        followerTable: [
                            "A":[.A, .E, .L, .R],           // APPALL, APPEASE, APPLY, APPRISE,
                            "O":[.O],
                            "U":[.E]],
                        dynFollowers: nil,
                        verifyEnd: nil)

let PR = ConsonantBlend(first: .P, second: .R, third: nil,
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
                            "A":[.I, .O],       // APRIL, APRON
                            "O":[.Y],           // OPRY
                            "U":[.I]],          // UPRIGHT
                        dynFollowers: nil,
                        verifyEnd: nil)

let PS = ConsonantBlend(first: .P, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [.O],       // PSORIASIS
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,          // true if starting the word?
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.E],                   // APSE
                            "E":[.I],                   // EPSILON
                            "U":[.E, .I, .T, .W]],      // UPSELL, UPSIDE, UPSTANDING, UPSWING
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
                            var followers: [Letter] = []
                            let lastElement = syll.lastElement()
                            
                            // Final E only followers for A & O vowels (LAPSE, COPSE
                            if pos == .positionLAST {
                                if lastElement!.id == "A" || lastElement!.id == "O" {
                                    followers += [.E]
                                }
                            }

                            return followers
                        },
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
                         verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                            "A":[.A, .E, .I],       // AQUA, AQUEDUCT, AQUIFER
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
                            "A":[.I, .O],           // ARBITER, ARBOR
                            "O":[.I, .S],           // ORBIT, ORBS
                            "U":[.A]],              // URBAN
                        dynFollowers: nil,
                        verifyEnd: nil)

let RC = ConsonantBlend(first: .R, second: .C, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H],
                        midVowels: allVowels,
                        finFollowers: [.H],
                        canPlural: false,       // could be true for ARCS
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.H, .I, .O, .S, .T],       // ARCH, ARCING, ARCO, ARCS, ARCTANGENT
                            "O":[.A, .H, .S],               // ORCA, ORCHESTRA, ORCS
                            "U":[.H]],                      // URCHIN
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
                            var followers: [Letter] = []
                            
                            // Only allow plural for ARCS and ORCS
                            if pos == .positionLAST {
                                if syll.matchesSet(["A", "O"]) {
                                    followers += [.S]
                                }
                            }
                            
                            // Allow E follower for COERCE
                            if syll.matchesSet(["COE"]) {
                                followers += [.E]
                            }
                            
                            return followers
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
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow final E for HORDE
                            if syll.matchesString("HO", matchFull: false) {
                                return [.E]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                            "A":[.I, .O, .U, .Y],   // ARGIL, ARGON, ARGUE, ARGYLE
                            "E":[.O, .S],           // ERGO, ERGS
                            "O":[.A, .I, .Y],       // ORGAN, ORGIES, ORGY
                            "U":[.E, .I]],          // URGENT/URGES, URGING
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
                            
                            // Allow final I for CORGI
                            if pos == .positionLAST && syll.matchesString("CO", matchFull: false) {
                                return [.I]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                        followerTable: [
                            "EA":[.I, .S, .Y]],         // EARLIER, EARLS, EARLY
                        dynFollowers: nil,
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                            "A":[.A, .E, .I, .O, .S, .Y]],        // ARMADILLO, ARMED, ARMIES, ARMOR, ARMS, ARMY
                       dynFollowers: nil,
                       verifyEnd: nil)

let RN = ConsonantBlend(first: .R, second: .N, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [.E],                // BORNE
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "EA", "O", "U"],
                        followerTable: [
                            "EA":[.E, .I, .S],      // EARNED/EARNEST, EARNING, EARNS
                            "U":[.S]],              // URNS
                        dynFollowers: nil,
                        verifyEnd: nil)

let RP = ConsonantBlend(first: .R, second: .P, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H, .L, .R],
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


let RPH = ConsonantBlend(first: .R, second: .P, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.E, .I],
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: ["O"],       // MORPH
                        followerTable: [
                            "O":[.A]],
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
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [
                            "A":[.A, .E, .I, .O],       // ARRAY, ARREARS, ARRIVE, ARROW
                            "E":[.A, .E, .I, .O, .S],   // ERRATA, ERRED, ERRING, ERROR, ERRS
                            "I":[.E]],                  // IRRESISTABLE
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            
                            // Approve final E for BARRE
                            if pos == .positionLAST && syll.matchesString("BA", matchFull: false) {
                                followers += [.E]
                            }

                            return followers
                        },
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

let RS = ConsonantBlend(first: .R, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.H, .T, .W],
                        midVowels: allVowels,
                        finFollowers: [.E, .H, .T],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.E, .O],               // ARSENIC, ARSON
                            "E":[.E, .T],               // ERSE, ERSTWHILE
                            "U":[.I]],                  // URSINE
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) in
                            
                            // Approve final O follower for TORSO, VERSO
                            if pos == .positionLAST && syll.matchesSet(["TO", "VE"]) {
                                return [.O]
                            }
                            else {
                                return []
                            }
                        },
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
                        finFollowers: [.A, .E, .H, .Z],     // AORTA, TORTE/CARTE, HERTZ/QUARTZ
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.H, .I, .S],       // ARTHUR, ARTIST, ARTSY
                            "AO":[.A, .I],          // AORTA, AORTIC
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
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow O follower for SERVO
                            if pos == .positionLAST && syll.matchesString("SE", matchFull: false) {
                                return [.O]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: nil)

let SC = ConsonantBlend(first: .S, second: .C, third: nil,
                        initBlend: [.H, .R, .Y],
                        initVowels: allVowels,
                        midBlend: [.H, .R],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.E, .O, .R],       // ASCEND, ASCOT, ASCRIBE
                            "E":[.H, .O, .R]],      // ESCHEW, ESCORT, ESCROW
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Allow O follower for DISCO and S plural only for DISC
                            if pos == .positionLAST && syll.matchesString("DI", matchFull: false) {
                                return [.O, .S]
                            }
                            else {
                                return []
                            }
                        },
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })     // allow all cases

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
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            if pos == .positionLAST && syll.matchesString("SU", matchFull: false) {
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
                        initVowels: allVowels,
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
                        single: true,
                        endOfWord: false,
                        preceders: ["AI", "I"],
                        followerTable: [
                            "A":[.E],           // ASLEEP
                            "AI":[.E],          // AISLE
                            "I":[.A, .E]],      // ISLAM, ISLE
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
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })     // allow all cases

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
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "O", "U"],
                        followerTable: [
                            "A":[.E, .I, .S],       // ASPEN, ASPIC
                            "E":[.E, .L, .Y],       // ESPECIALLY, ESPLANADE, ESPY
                            "O":[.R]],              // OSPREY
                        dynFollowers: nil,
                        verifyEnd: nil)

let SPH = ConsonantBlend(first: .S, second: .P, third: .H,
                        initBlend: [],
                        initVowels: [.E, .I],       // SPHERE, SPHINX
                        midBlend: [],
                        midVowels: allVowels,
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

let SS = ConsonantBlend(first: .S, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],             // HASSLE, TUSSLE
                        midVowels: allVowels,
                        finFollowers: [.O],         // LASSO
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [
                            "A":[.A, .E, .I, .O, .U],   // ASSAIL, ASSET, ASSIST, ASSONANCE, ASSUME
                            "E":[.A, .E],               // ESSAY, ESSENTIAL
                            "I":[.U],                   // ISSUE
                            "O":[.I]],                  // OSSIFY
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            
                            // Approve E follower for POSSE, others?
                            if syll.matchesString("PO", matchFull: false) {
                                return [.E]
                            }
                            return []
                        },
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

let ST = ConsonantBlend(first: .S, second: .T, third: nil,
                        initBlend: [.R],
                        initVowels: allVowels,
                        midBlend: [.H, .L, .R],     // H for ASTHMA, ISTHMUS
                        midVowels: allVowels,
                        finFollowers: [.E, .O],     // PESTO, MANIFESTO
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "AU", "E", "EA", "EI", "I", "IE", "O", "OA", "OI", "OO", "OU", "U", "UE"],
                        followerTable: [
                            "A":[.A, .E, .H, .I, .O, .R],   // ASTAR, ASTER, ASTIR, ASTOR, ASTRIDE
                            "E":[.E],                   // ESTER
                            "I":[.H],                   // ISTHMUS
                            "O":[.E, .R]],              // OSTER, OSTRICH
                        dynFollowers: nil,
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })     // allow all cases

let STH = ConsonantBlend(first: .S, second: .T, third: .H,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],    
                        midVowels: [.A, .U],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: false,
                        single: false,
                        endOfWord: false,
                        preceders: ["A", "I"],
                        followerTable: [
                            "A":[.M],                    // ASTHMA
                            "I":[.M]],                   // ISTHMUS
                        dynFollowers: nil,
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })     // allow all cases

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
                        midVowels: [],          // ** This forces TC to always become TCH **
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
                            "E":[.A, .I, .E, .O],   // ETHANOL, ETHER, ETHIC, ETHOS
                            "O":[.E],               // OTHER
                            "OA":[.S]],
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            if pos == .positionLAST && syll.matchesString("LA", matchFull: false) {
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
                        dynFollowers: {(syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
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
                        single: true,
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
                        finFollowers: [.A, .O],     // CONTRA, NITRO
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        followerTable: [
                            "A":[.I, .O]],          // ATRIA, ATROPHY
                        dynFollowers: nil,
                        verifyEnd: nil)

let TS = ConsonantBlend(first: .T, second: .S, third: nil,
                        initBlend: [],
                        initVowels: [.A, .E],       // TSAR, TSETSE
                        midBlend: [],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [:],
                        dynFollowers: nil,
                        verifyEnd: nil)

let TT = ConsonantBlend(first: .T, second: .T, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [.L],
                        midVowels: allVowels,
                        finFollowers: [],
                        canPlural: true,
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: [],
                        followerTable: [
                            "A":[.A, .E, .I, .U],       // ATTACK, ATTEST, ATTIRE, ATTUNED
                            "O":[.E],
                            "U":[.E]],
                        dynFollowers: { (syll: SyllabicArray, pos: PositionIndicator) -> [Letter] in
                            var followers: [Letter] = []
                            
                            if pos == .positionLAST {
                                let lastElement = syll.lastElement()
                                
                                // Approve final O for words like LOTTO, GROTTO, DITTO
                                if lastElement!.id == "I" || lastElement!.id == "O" {
                                    followers += [.O]
                                }
                                
                                // Approve final E for LATTE, MATTE
                                if syll.matchesSet(["LA", "MA"]) {
                                    followers += [.E]
                                }
                            }
                            return followers
                        },
                        verifyEnd: { (pea: PhoneticElementArray) -> Bool in return true })

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
                        blendsWithY: true,
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "E", "I", "U"],     // KATZ, PRETZEL, BLITZ, KLUTZ
                        followerTable: [:],
                        dynFollowers: nil,
                        verifyEnd: nil)

// DIVVY, SAVVY SKIVVIES
let VV = ConsonantBlend(first: .V, second: .V, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.I],
                        finFollowers: [],
                        canPlural: false,
                        blendsWithY: true,
                        single: false,
                        endOfWord: false,
                        preceders: [],
                        followerTable: [:],
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
                        followerTable: [
                            "A":[.Y]],
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
                        preceders: ["E"],
                        followerTable: [
                            "E":[.A, .E, .I, .O, .R, .U],   // EXTANT, EXTENT, EXTINGUISH, EXTOL, EXTRA, EXTUNT
                            "O":[.A]],                      // OXTAIL
                        dynFollowers: nil,
                        verifyEnd: nil)

let XTH = ConsonantBlend(first: .X, second: .T, third: .H,
                         initBlend: [],
                         initVowels: [],
                         midBlend: [],
                         midVowels: [],
                         finFollowers: [],
                         canPlural: true,
                         blendsWithY: false,
                         single: false,
                         endOfWord: true,
                         preceders: ["I"],       // SIXTH
                         followerTable: [:],
                         dynFollowers: nil,
                         verifyEnd: nil)

let ZL = ConsonantBlend(first: .Z, second: .L, third: nil,
                        initBlend: [],
                        initVowels: [],
                        midBlend: [],
                        midVowels: [.E, .I],
                        finFollowers: [.E],
                        canPlural: false,
                        blendsWithY: true,
                        single: true,
                        endOfWord: false,
                        preceders: ["I", "U"],
                        followerTable: [:],
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
                        single: false,
                        endOfWord: true,
                        preceders: ["A", "I", "O", "U"],
                        followerTable: [
                            "O":[.L, .Y],
                            "U":[.L]],
                        dynFollowers: nil,
                        verifyEnd: nil)

let consonantBlendMap = ["BB":BB, "BL":BL, "BR":BR, "BT":BT, "CC":CC, "CH":CH, "CHR":CHR, "CHT":CHT, "CK":CK, "CL":CL, "CR":CR,
                         "CT":CT, "DD":DD, "DG":DG, "DL":DL, "DR":DR, "DT":DT, "DTH":DTH, "DW":DW, "FF":FF, "FL":FL, "FR":FR,
                         "FT":FT, "FTH":FTH,
                         "GH":GH, "GHT":GHT, "GG":GG, "GN":GN, "GL":GL, "GR":GR, "KK":KK, "KL":KL, "KN":KN, "KR":KR,
                         "LB":LB, "LC":LC, "LCH":LCH, "LD":LD, "LDT":LDT, "LF":LF, "LG":LG, "LK":LK, "LL":LL, "LM":LM, "LN":LN,
                         "LP":LP, "LPH":LPH, "LS":LS, "LSH":LSH, "LT":LT, "LTH":LTH, "LV":LV, "MB":MB, "MM":MM, "MN":MN,
                         "MP":MP, "MPH":MPH, "MPT":MPT,
                         "NC":NC, "NCH":NCH, "ND":ND, "NG":NG, "NK":NK, "NN":NN, "NQ":NQ, "NQU":NQU, "NS":NS, "NT":NT,
                         "NTH":NTH, "PH":PH, "PHL":PHL, "PHR":PHR, "PL":PL, "PP":PP, "PR":PR, "PS":PS, "PT":PT,
                         "QU":QU, "RB":RB, "RC":RC, "RCH":RCH, "RD":RD, "RF":RF, "RG":RG, "RH":RH, "RK":RK, "RL":RL,
                         "RM":RM, "RN":RN, "RP":RP, "RPH":RPH, "RR":RR, "RS":RS, "RSH":RSH, "RST":RST, "RT":RT, "RTH":RTH, "RV":RV,
                         "SC":SC, "SCH":SCH, "SCR":SCR, "SH":SH, "SHR":SHR, "SK":SK, "SL":SL, "SM":SM, "SN":SN, "SP":SP,
                         "SPH":SPH, "SPL":SPL, "SPR":SPR, "SQ":SQ, "SQU":SQU, "SS":SS, "ST":ST, "STH":STH, "STR":STR, "SW":SW,
                         "TC":TC, "TCH":TCH, "TH":TH, "THR":THR, "TL":TL, "TR":TR, "TS":TS, "TT":TT, "TW":TW, "TZ":TZ,
                         "VV":VV, "WH":WH, "WR":WR, "XT":XT, "XTH":XTH, "ZL":ZL, "ZZ":ZZ]
