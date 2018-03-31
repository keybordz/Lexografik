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
    
    // No special cases for generating followers
    init(first: Letter, second: Letter, start: Bool, end: Bool, glottal: Bool,
         initFollowers: [Letter], interFollowers: [Letter], finFollowers: [Letter]) {
        
        glottalStop = glottal
        super.init(first: first, second: second, start: start, end: end)
        
        if start {
            initialFollowers = { return initFollowers }
        }
        else {
            initialFollowers = { return [] }
        }
        
        interiorFollowers = { (phonemes:PhoneticElementArray) in return interFollowers }
        finalFollowers = { (phonemes:PhoneticElementArray) in return finFollowers }
        
        if end {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return end }
    }
    
    // Initializer for dynamic follower generation
    init(first: Letter, second: Letter, start: Bool, end: Bool, glottal: Bool,
         initFollowers: [Letter],
         generateFollowers: @escaping (PhoneticElementArray) -> [Letter],
         finFollowers: [Letter]) {
        
        glottalStop = glottal
        super.init(first: first, second: second, start: start, end: end)
        
        if start {
            initialFollowers = { return initFollowers }
        }
        else {
            initialFollowers = { return [] }
        }
        
        interiorFollowers = generateFollowers
        finalFollowers = { (phonemes:PhoneticElementArray) in return finFollowers }
        
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
        super.init(first: first, second: second, start: start, end: true)
        
        if start {
            initialFollowers = { return initFollowers }
        }
        else {
            initialFollowers = { return [] }
        }
        
        interiorFollowers = { (phonemes:PhoneticElementArray) in return interFollowers }
        finalFollowers = { (phonemes:PhoneticElementArray) in return finFollowers }
        
        verifyEndOfWord = verifyEnd
        
        // If there's a conditional test for the end, then use it to verify pluralization
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in
            let testPhonemes = PhoneticElementArray(pea: phonemes)
            testPhonemes.removeLastElement()
            return self.verifyEndOfWord!(testPhonemes)
        }
    }
    
    // initializer for triple blends
    init(first: Letter, second: Letter, third: Letter,
         verifyEnd: @escaping (PhoneticElementArray) -> Bool ) {
        
        glottalStop = false
        super.init(first: first, second: second, third: third, start: false, end: true)
        
        initialFollowers = { return [] }
        interiorFollowers = { (phonemes:PhoneticElementArray) -> [Letter] in return [.T] }
        finalFollowers = { (phonemes:PhoneticElementArray) -> [Letter] in return [.S] }
        verifyEndOfWord = verifyEnd
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
}


let AA = VowelBlend(first: .A, second: .A, start: true, end: false, glottal: false,
                    initFollowers: [.R],
                    interFollowers: [],
                    finFollowers: [])

let AE = VowelBlend(first: .A, second: .E, start: true, end: false, glottal: false,
                    initFollowers: [.R],
                    interFollowers: [],
                    finFollowers: [])

let AI = VowelBlend(first: .A, second: .I, start: true, end: false, glottal: false,
    initFollowers: [.D, .L, .M, .R],
    interFollowers: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
    finFollowers: [.C, .D, .F, .L, .M, .N, .R, .S, .T])

let AO = VowelBlend(first: .A, second: .O, start: true, end: false, glottal: true,
    initFollowers: [.R],
    generateFollowers: { (phonemes:PhoneticElementArray) -> [Letter] in
                        let lastElement = phonemes.lastElement
    
                        // GAOL
                        if lastElement()!.id == "G" {
                            return [.L]
                        }
                        else {
                            return []
                        }
                    },
    finFollowers: [.L, .S]
    ) // fix this to only work with GAOL


let AU = VowelBlend(first: .A, second: .U, start: true, end: false, glottal: false,
    initFollowers: [.D, .G, .L, .R, .S, .T, .X],
    interFollowers: [.B, .C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .V, .X],
    finFollowers: [.D, .F, .L, .M, .N, .R, .S, .T])

let EA = VowelBlend(first: .E, second: .A, start: true, glottal: false,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        
                        // FLEA, LEA, PEA, PLEA, RHEA, SEA, TEA, UREA
                        let finalEAWords = ["FL", "L", "P", "PL", "RH", "S", "T", "UR"]
                        
                        for word in finalEAWords {
                            if phonemes.matchesString(word, matchFull: true) {
                                return true
                            }
                        }                        
                        return false
                    },
                    initFollowers: [.C, .R, .S, .T, .V],
                    interFollowers: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .U, .V],
                    finFollowers: [.D, .F, .K, .L, .M, .N, .P, .R, .S, .T, .U])

let EE = VowelBlend(first: .E, second: .E, start: true, end: true, glottal: false,
                    initFollowers: [.L, .R],
                    interFollowers: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
                    finFollowers: [.D, .F, .K, .L, .M, .N, .P, .R, .S, .T])

let EI = VowelBlend(first: .E, second: .I, start: true, end: false, glottal: false,
                    initFollowers: [.G, .T],
                    interFollowers: [.C, .G, .K, .L, .N, .R, .S, .T, .V, .Z],
                    finFollowers: [.C, .D, .K, .L, .N, .R, .S])

let EO = VowelBlend(first: .E, second: .O, start: true, end: false, glottal: true,
                    initFollowers: [.N],
                    interFollowers: [.M, .N, .R, .S, .T],
                    finFollowers: [.N, .R, .S])

let EU = VowelBlend(first: .E, second: .U, start: true, end: false, glottal: false,
                    initFollowers: [.R],
                    interFollowers: [.C, .D, .R, .T],
                    finFollowers: [.D])

let EAU = VowelBlend(first: .E, second: .A, third: .U,  // only T can follow?
                     verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        let lastElement = phonemes.lastElement
                        
                        if lastElement()!.id == "B" {
                            return true
                        }
                        else {
                            return false
                        }
    } )

let IA = VowelBlend(first: .I, second: .A, start: true, glottal: true,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        let finalIAWords = ["MED", "ZINN"]
                        
                        for word in finalIAWords {
                            if phonemes.matchesString(word, matchFull: true) {
                                return true
                            }
                        }
                        
                        return false
                    },
                    initFollowers: [.M],
                    interFollowers: [.B, .C, .D, .L, .M, .N, .P, .R, .S, .T],
                    finFollowers: [.D, .L, .M, .N, .R, .S, .T])

let IE = VowelBlend(first: .I, second: .E, start: false, end: true, glottal: false,
    initFollowers: [],
    generateFollowers: { (phonemes:PhoneticElementArray) -> [Letter] in
        let lastElement = phonemes.lastElement
        
        // mainly for VIEW
        if lastElement()!.id == "V" {
            return [.D, .N, .R, .S, .W]
        }
        else {
            return [.C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .U, .V, .Z]
        }
    },
    finFollowers: [.D, .F, .L, .M, .N, .R, .S, .T, .U, .W])


let II = VowelBlend(first: .I, second: .I, start: false, end: false, glottal: true,
    initFollowers: [],
    generateFollowers: { (phonemes:PhoneticElementArray) -> [Letter] in
        let lastElement = phonemes.lastElement
        
        // SKIING is the only word with II
        if lastElement()!.id == "SK" {
            return [.N]
        }
        else {
            return []
        }
    },
    finFollowers: [])

let IO = VowelBlend(first: .I, second: .O, start: true, end: true, glottal: true,
    initFollowers: [.N, .T],
    interFollowers: [.C, .D, .M, .N, .R, .S, .T],
    finFollowers: [.D, .N, .R, .S, .T])

let IU = VowelBlend(first: .I, second: .U, start: false, end: false, glottal: false,
    initFollowers: [],
    interFollowers: [.M, .S],
    finFollowers: [.M])

let IEU = VowelBlend(first: .I, second: .E, third: .U,
                     verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        let lastElement = phonemes.lastElement
                        
                        if lastElement()!.id == "L" {
                            return true
                        }
                        else {
                            return false
                        }
} )


let OA = VowelBlend(first: .O, second: .A, start: true, end: false, glottal: false,
    initFollowers: [.F, .K, .R, .S, .T],
    interFollowers: [.C, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T, .V],
    finFollowers: [.D, .F, .K, .L, .M, .N, .P, .R, .S, .T])

let OE = VowelBlend(first: .O, second: .E, start: true, end: true, glottal: false,
    initFollowers: [.N],
    interFollowers: [.D, .M, .R, .S, .T],
    finFollowers: [.D, .M, .R, .S, .T])

let OI = VowelBlend(first: .O, second: .I, start: true, end: false, glottal: true,
                    initFollowers: [.L],
                    interFollowers: [.C, .D, .F, .L, .N, .R, .S, .T, .V],
                    finFollowers: [.C, .D, .L, .N, .R, .S, .T])

let OO = VowelBlend(first: .O, second: .O, start: true, glottal: false,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        let finalOOWords = ["B", "G", "M", "W", "Z", "SH", "IGL", "TAB"]
                        for word in finalOOWords {
                            if phonemes.matchesString(word, matchFull: true) {
                                return true
                            }
                        }
                        
                        return false
    },                    
    initFollowers: [.Z],
    interFollowers: [.B, .D, .F, .G, .I, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
    finFollowers: [.B, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T])


let OU = VowelBlend(first: .O, second: .U, start: true, end: false, glottal: false,
    initFollowers: [.N, .R, .S, .T],
    interFollowers: [.B, .C, .D, .F, .G, .L, .N, .P, .Q, .R, .S, .T, .V, .Z],
    finFollowers: [.D, .F, .L, .N, .P, .R, .S, .T])

let UA = VowelBlend(first: .U, second: .A, start: false, end: false, glottal: true,
    initFollowers: [],
    interFollowers: [.B, .C, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T, .V, .Z],
    finFollowers: [.D, .F, .L, .M, .N, .R, .T, .Y])

let UE = VowelBlend(first: .U, second: .E, start: false, end: true, glottal: false,
                    initFollowers: [],
                    interFollowers: [.D, .L, .N, .R, .S, .T],
                    finFollowers: [.D, .L, .R, .S, .T, .Y])

let UI = VowelBlend(first: .U, second: .I, start: false, end: false, glottal: false,
    initFollowers: [],
    interFollowers: [.C, .D, .L, .N, .R, .S, .T],
    finFollowers: [.D, .L, .N, .R, .T])

let UO = VowelBlend(first: .U, second: .O, start: false, end: false, glottal: true,
                    initFollowers: [],
                    interFollowers: [.R, .S],
                    finFollowers: [.R, .S, .Y])

let UU = VowelBlend(first: .U, second: .U, start: false, end: false, glottal: false,
                    initFollowers: [],
                    interFollowers: [.M],
                    finFollowers: [.M])

let vowelBlendMap = ["AA":AA, "AE":AE, "AI":AI, "AO":AO, "AU":AU,
    "EA":EA, "EE":EE, "EI":EI, "EO":EO, "EU":EU, "EAU":EAU,
    "IA":IA, "IE":IE, "II":II, "IO":IO, "IU":IU, "IEU":IEU,
    "OA":OA, "OE":OE, "OI":OI, "OO":OO, "OU":OU,
    "UA":UA, "UE":UE, "UI":UI, "UO":UO, "UU":UU ]
