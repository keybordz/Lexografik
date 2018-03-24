//
//  DiphthongBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation
class DiphthongBlend: LexicalBlend {
    var singlePhoneme: Bool
    
    init(vowel: Letter, consonant: Letter, start: Bool, end: Bool, interFollowers: [Letter]) {
        
        singlePhoneme = true
        super.init(first: vowel, second: consonant, start: start, end: end)
        
        initialFollowers = { return [] }
        interiorFollowers = { (phonemes:PhoneticElementArray) in return interFollowers }
        verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return end }
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
    
    init(vowel: Letter, consonant: Letter, start: Bool, end: Bool, initFollowers: [Letter], interFollowers: [Letter]) {
        
        singlePhoneme = true
        super.init(first: vowel, second: consonant, start: start, end: end)
        
        initialFollowers = { return initFollowers }
        interiorFollowers = { (phonemes:PhoneticElementArray) in return interFollowers }
        verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return end }
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
    
}

// Not too many cases with vowel-H pairings

// Need AHOY and AHEM
let AH = DiphthongBlend(vowel: .A, consonant: .H, start: false, end: false,
    initFollowers: [.E, .O], interFollowers: [.E, .N, .O])

let EH = DiphthongBlend(vowel: .E, consonant: .H, start: false, end: false,
    interFollowers: [])

let OH = DiphthongBlend(vowel: .O, consonant: .H, start: true, end: false,
    initFollowers: [.M], interFollowers: [.N])

//let UH = DiphthongBlend(vowel: .A, consonant: .H, start: false, end: false)

let AW = DiphthongBlend(vowel: .A, consonant: .W, start: true, end: true,
                        initFollowers: [.A, .E, .L, .N], interFollowers: [.A, .D, .E, .L, .N, .T])
let EW = DiphthongBlend(vowel: .E, consonant: .W, start: true, end: true,
                        initFollowers: [.E], interFollowers: [.A, .D, .E, .I, .L, .N, .T, .Y])
let OW = DiphthongBlend(vowel: .O, consonant: .W, start: true, end: true,
                        initFollowers: [.E, .I, .L, .N], interFollowers: [.A, .D, .E, .I, .L, .N, .S, .Y])

let AY = DiphthongBlend(vowel: .A, consonant: .Y, start: true, end: true,
                        initFollowers: [.E], interFollowers: [.I, .O])
let EY = DiphthongBlend(vowel: .E, consonant: .Y, start: true, end: true,
                        initFollowers: [.E], interFollowers: [.I, .O])
let OY = DiphthongBlend(vowel: .O, consonant: .Y, start: true, end: true,
                        interFollowers: [.A, .I])

let diphthongBlendMap = ["AH":AH, "EH":EH, "OH":OH, "AW":AW, "EW":EW, "OW":OW, "AY":AY, "EY":EY, "OY":OY]
