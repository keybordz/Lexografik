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
    
    init(first: Letter, second: Letter, start: Bool, end: Bool, glottal: Bool, initFollowers: [Letter],interFollowers: [Letter]) {
        
        glottalStop = glottal
        super.init(first: first, second: second, start: start, end: end)
        
        if start {
            initialFollowers = { return initFollowers }
        }
        else {
            initialFollowers = { return [] }
        }
        
        interiorFollowers = { (phonemes:PhoneticElementArray) in return interFollowers }
        
        if end {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return end }
    }
    
    // Initializer for dynamic follower generation
    init(first: Letter, second: Letter, start: Bool, end: Bool, glottal: Bool, initFollowers: [Letter],generateFollowers: @escaping (PhoneticElementArray) -> [Letter]) {
        
        glottalStop = glottal
        super.init(first: first, second: second, start: start, end: end)
        
        if start {
            initialFollowers = { return initFollowers }
        }
        else {
            initialFollowers = { return [] }
        }
        
        interiorFollowers = generateFollowers
        
        if end {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
        }
        else {
            verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return false }
        }
        
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return end }
    }
    
    init(first: Letter, second: Letter, start: Bool, glottal: Bool,
         verifyEnd: @escaping (PhoneticElementArray) -> Bool, initFollowers: [Letter], interFollowers: [Letter]) {
        
        glottalStop = glottal
        super.init(first: first, second: second, start: start, end: true)
        
        if start {
            initialFollowers = { return initFollowers }
        }
        else {
            initialFollowers = { return [] }
        }
        
        interiorFollowers = { (phonemes:PhoneticElementArray) in return interFollowers }
        
        verifyEndOfWord = verifyEnd
        
        // If there's a conditional test for the end, then use it to verify pluralization
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in
            let testPhonemes = PhoneticElementArray(pea: phonemes)
            testPhonemes.removeLastElement()
            return self.verifyEndOfWord!(testPhonemes)
        }
    }
    
    init(first: Letter, second: Letter, third: Letter,
         verifyEnd: @escaping (PhoneticElementArray) -> Bool ) {
        
        glottalStop = false
        super.init(first: first, second: second, third: third, start: false, end: true)
        
        initialFollowers = { return [] }
        interiorFollowers = { (phonemes:PhoneticElementArray) -> [Letter] in return [.T] }
        verifyEndOfWord = verifyEnd
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
}


let AA = VowelBlend(first: .A, second: .A, start: true, end: false, glottal: false,
    initFollowers: [.R], interFollowers: [])

let AE = VowelBlend(first: .A, second: .E, start: true, end: false, glottal: false,
    initFollowers: [.R], interFollowers: [])

let AI = VowelBlend(first: .A, second: .I, start: true, end: false, glottal: false,
    initFollowers: [.D, .L, .M, .R], interFollowers: [.D, .F, .L, .M, .N, .R, .S, .T, .V, .Z])

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
        
        
                    }
    ) // fix this to only work with GAOL


let AU = VowelBlend(first: .A, second: .U, start: true, end: false, glottal: false,
    initFollowers: [.D, .G, .L, .R, .S, .T, .X], interFollowers: [.B, .C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .V, .X])

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
                    interFollowers: [.B, .C, .D, .F, .G, .K, .L, .M, .N, .P, .R, .S, .T, .U, .V])

let EE = VowelBlend(first: .E, second: .E, start: true, end: true, glottal: false,
    initFollowers: [.L, .R],
    interFollowers: [.B, .C, .D, .F, .G, .I, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z])

let EI = VowelBlend(first: .E, second: .I, start: true, end: false, glottal: false,
    initFollowers: [.G, .T], interFollowers: [.C, .G, .L, .N, .R, .S, .T, .V])

let EO = VowelBlend(first: .E, second: .O, start: true, end: false, glottal: true,
    initFollowers: [.N], interFollowers: [.M, .N])

let EU = VowelBlend(first: .E, second: .U, start: true, end: false, glottal: false,
    initFollowers: [.R], interFollowers: [.C, .D, .R, .T])

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
                    initFollowers: [.M], interFollowers: [.C, .D, .L, .M, .N, .R, .S, .T])

let IE = VowelBlend(first: .I, second: .E, start: false, end: true, glottal: false,
    initFollowers: [],
    generateFollowers: { (phonemes:PhoneticElementArray) -> [Letter] in
        let lastElement = phonemes.lastElement
        
        // mainly for VIEW
        if lastElement()!.id == "V" {
            return [.D, .N, .R, .S, .W]
        }
        else {
            return [.C, .D, .L, .M, .N, .R, .S, .T, .U, .V, .Z]
        }
    })


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
    })

let IO = VowelBlend(first: .I, second: .O, start: true, end: true, glottal: true,
    initFollowers: [.N, .T], interFollowers: [.M, .N, .R, .S, .T])
let IU = VowelBlend(first: .I, second: .U, start: false, end: false, glottal: false,
    initFollowers: [], interFollowers: [.M, .S])

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
    initFollowers: [.F, .K, .R, .S, .T], interFollowers: [.C, .D, .F, .K, .L, .M, .N, .P, .R, .S, .T, .V])
let OE = VowelBlend(first: .O, second: .E, start: true, end: true, glottal: false,
    initFollowers: [.N], interFollowers: [.D, .M, .R, .S, .T])
let OI = VowelBlend(first: .O, second: .I, start: true, end: false, glottal: true,
    initFollowers: [.L], interFollowers: [.C, .D, .F, .L, .N, .R, .S, .T, .V])

let OO = VowelBlend(first: .O, second: .O, start: true, glottal: false,
                    verifyEnd: { (phonemes:PhoneticElementArray) -> Bool in
                        let finalOOWords = ["IGL", "TAB", "SH"]
                        for word in finalOOWords {
                            if phonemes.matchesString(word, matchFull: true) {
                                return true
                            }
                        }
                        
                        return false
    },                    
    initFollowers: [.Z],
    interFollowers: [.B, .D, .F, .G, .H, .I, .K, .L, .M, .N, .P, .R, .S, .T, .V, .Z])


let OU = VowelBlend(first: .O, second: .U, start: true, end: false, glottal: false,
    initFollowers: [.N, .R, .S, .T], interFollowers: [.B, .C, .D, .F, .G, .L, .N, .P, .Q, .R, .S, .T, .V, .Z])

let UA = VowelBlend(first: .U, second: .A, start: false, end: false, glottal: true,
    initFollowers: [], interFollowers: [.B, .C, .D, .F, .G, .L, .M, .N, .R, .S, .T, .V, .Z])
let UE = VowelBlend(first: .U, second: .E, start: false, end: true, glottal: false,
    initFollowers: [], interFollowers: [.D, .L, .N, .R, .S, .T])
let UI = VowelBlend(first: .U, second: .I, start: false, end: false, glottal: false,
    initFollowers: [], interFollowers: [.C, .D, .L, .N, .R, .S])
let UO = VowelBlend(first: .U, second: .O, start: false, end: false, glottal: true,
    initFollowers: [], interFollowers: [.R, .S])
let UU = VowelBlend(first: .U, second: .U, start: false, end: false, glottal: false,
    initFollowers: [], interFollowers: [.M])

let vowelBlendMap = ["AA":AA, "AE":AE, "AI":AI, "AO":AO, "AU":AU,
    "EA":EA, "EE":EE, "EI":EI, "EO":EO, "EU":EU, "EAU":EAU,
    "IA":IA, "IE":IE, "II":II, "IO":IO, "IU":IU, "IEU":IEU,
    "OA":OA, "OE":OE, "OI":OI, "OO":OO, "OU":OU,
    "UA":UA, "UE":UE, "UI":UI, "UO":UO, "UU":UU ]
