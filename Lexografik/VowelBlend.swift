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
                    followerTable: [:],
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
                    interCons: [.B, .C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .V, .X],
                    finalCons: [.D, .F, .L, .M, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: false,
                    followerTable: [:],
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
                        "B":[.D, .K, .L, .M, .N, .R, .S, .T, .U, .V],
                        "Y":[.H, .R, .S, .T]],
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
                        "B":[.N, .R, .S, .T],
                        "BL":[.D, .P],
                        "BR":[.D, .S, .Z],
                        "CH":[.T],
                        "CR":[.D, .L, .S],
                        "D":[.D, .M, .R],
                        "F":[.D, .L, .S],
                        "FL":[.C, .I, .S, .T],
                        "FR":[.D, .I, .L, .S, .Z],
                        "GR":[.D, .N],
                        "H":[.D, .L],
                        "K":[.L, .N, .P],
                        "KN":[.D, .L, .S],
                        "L":[.K, .R],
                        "M":[.L],
                        "N":[.D],
                        "P":[.D, .K, .L, .R, .S],
                        "PR":[.N],
                        "QU":[.N],
                        "R":[.D, .F, .K, .L, .S],
                        "S":[.D, .I, .K, .M, .N, .P, .R],
                        "SH":[.N, .P, .R, .T],
                        "ST":[.D, .L, .P, .R],
                        "STR":[.T],
                        "SW":[.P],
                        "T":[.D, .I, .M, .N, .S],
                        "TH":[.S],
                        "THR":[.S],
                        "TR":[.D, .R, .S],
                        "V":[.R, .S],
                        "W":[.D, .K, .N, .S],
                        "WH":[.L]],
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
                        "D":[.C, .G, .S],   // DEICE, DEIGN, DEISM
                        "F":[.G, .S],       // FEIGN, FEISTY
                        "FR":[.G],          // FREIGHT
                        "H":[.G, .S],       // HEIGHT, HEIST
                        "L":[.S],           // LEIS
                        "N":[.G],           // NEIGH
                        "P":[.G],           // PEIGNOIR
                        "PL":[.N],          // PLEIN
                        "R":[.G, .N],       // REIGN, REIN
                        "S":[.Z],           // SEIZE
                        "SH":[.K],          // SHEIK
                        "SL":[.G],          // SLEIGH
                        "ST":[.N],          // STEIN
                        "TH":[.S],          // THEIST
                        "V":[.L, .N],       // VEIL, VEIN
                        "W":[.R]],          // WEIR
                    dynFollowers: nil,
                    verifyEnd: nil)

let EO = VowelBlend(first: .E, second: .O, third: nil,
                    initCons: [.N],        // EONS
                    interCons: [.D, .G, .L, .M, .N, .R, .S, .T],
                    finalCons: [.N],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: true,          // Could be false, ex. YEOMAN
                    followerTable: [
                        "G":[.D, .G, .L, .S],   // GEODE, GEOGRAPHY, GEOLOGY, GEOSPHERE
                        "L":[.N],               // LEON
                        "N":[.L, .N, .S],       // NEOLIBERAL, NEON, NEOS
                        "P":[.N],               // PEONY
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
                        "F":[.D],           // FEUD
                        "H":[.R],           // HEURISTIC
                        "N":[.S, .T],       // NEUSE, NEUTRAL
                        "QU":[.E],          // QUEUE
                        "R":[.S, .T]],      // REUSE, REUTTER
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
                        "TR":[.D, .L],      // TRIAD, TRIAL
                        "V":[.B, .D, .L]],  // VIABLE, VIADUCT, VIAL
                    dynFollowers: nil,
                    
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        let lastElement = phonemes.lastElement()
                        let penElement = phonemes.nextToLastElement()   // assuming this is non-nil
                        
                        // Trying to cover typical IA enders: MEDIA/ENCYCLOPEDIA, GLIA/GANGLIA, ILIA, ZINNIA, CRITERIA
                        if (lastElement!.id == "D" && penElement!.id == "E") ||
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
                        "CR":[.R],              // CRIER
                        "D":[.D, .S],           // DIED, DIES
                        "DR":[.D, .R, .S],      // DRIED, DRIER, DRIES
                        "F":[.R, .S],           // FIERY, FIES
                        "FL":[.R, .S],          // FLIER, FLIES
                        "FR":[.D, .S],          // FRIED, FRIES
                        "GR":[.V],              // GRIEVE
                        "H":[.R],               // HIERARCHY
                        "L":[.D, .G, .N, .S, .U],   // LIED, LIEGE, LIEN, LIES, LIEU
                        "M":[.N],               // MIEN
                        "N":[.C],               // NIECE
                        "P":[.C, .D, .R, .S],   // PIECE, PIED, PIER, PIES
                        "QU":[.R, .T],          // QUIRE, QUIET
                        "S":[.G, .V],           // SIEGE, SIEVE
                        "SH":[.D, .S],          // SHIED, SHIES
                        "SHR":[.K],             // SHRIEK
                        "T":[.D, .R, .S],       // TIED, TIER, TIES
                        "TR":[.D, .R, .S],      // TRIED, TRIER, TRIES
                        "V":[.D, .R, .S, .W]],  // VIED, VIES, VIER, VIEW
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
                        "BR":[.S],              // BRIO
                        "L":[.N],               // LION
                        "P":[.U],               // PIOUS
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
                    followerTable: [:],
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        
                        // Words ending in OA: BOA, COCOA
                        if phonemes.matchesSet(["B", "COC"]) {
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
                        "D":[.R, .S],
                        "F":[.S],
                        "G":[.R, .S],
                        "H":[.D, .I, .R, .S],
                        "J":[.L, .S],
                        "P":[.M, .T],
                        "SH":[.D, .S],
                        "SL":[.S],
                        "T":[.D, .I, .S],
                        "THR":[.S],
                        "W":[.S]],
                    dynFollowers: nil,
                    verifyEnd: nil)

let OI = VowelBlend(first: .O, second: .I, third: nil,
                    initCons: [.L],        // OILS
                    interCons: [.C, .D, .F, .L, .N, .R, .S, .T, .V],
                    finalCons: [.C, .D, .L, .N, .R, .S, .T],
                    blendInto: [],
                    canPlural: false,       // but KOI perhaps?
                    endOfWord: false,
                    glottal: true,
                    followerTable: [:],
                    dynFollowers: nil,
                    verifyEnd: nil)

let OO = VowelBlend(first: .O, second: .O, third: nil,
                    initCons: [.Z],        // OOZE
                    interCons: [.B, .D, .F, .G, .I, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finalCons: [.B, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T],
                    blendInto: [.E, .I],        // GOOEY, gerunds like WOOING
                    canPlural: true,
                    endOfWord: true,
                    glottal: false,
                    followerTable: [:],
                    dynFollowers: nil,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in

                        // Final OO words: BOO, GOO, MOO, WOO, ZOO, SHOO, IGLOO, TABOO
                        if phonemes.matchesSet(["B", "G", "M", "W", "Z", "SH", "IGL", "TAB"]) {
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
                    followerTable: [:],
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
                        "BL":[.D, .R, .S],
                        "C":[.D, .I, .R, .S],
                        "CL":[.D, .I, .R, .S],
                        "CR":[.L],
                        "D":[.L, .S],
                        "F":[.L],
                        "FL":[.S],
                        "GL":[.D, .I, .R, .S],
                        "H":[.D, .R, .S],
                        "R":[.D, .I, .R, .S],
                        "S":[.D, .I, .R, .S],
                        "TR":[.D, .R],
                        "V":[.S]],
                    dynFollowers: nil,
                    verifyEnd: nil)

let UI = VowelBlend(first: .U, second: .I, third: nil,
                    initCons: [],
                    interCons: [.C, .D, .L, .N, .R, .S, .T],
                    finalCons: [.D, .L, .N, .R, .T],
                    blendInto: [],
                    canPlural: false,
                    endOfWord: false,
                    glottal: true,          // but false for SUIT, SQUID
                    followerTable: [:],
                    dynFollowers: nil,
                    verifyEnd: nil)

let UO = VowelBlend(first: .U, second: .O, third: nil,
                    initCons: [],
                    interCons: [.R, .S],
                    finalCons: [.R, .Y],
                    blendInto: [.U],        // VIRTUOUS
                    canPlural: true,
                    endOfWord: true,
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
