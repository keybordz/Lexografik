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
    
    init(vowel: Letter, consonant: Letter, start: Bool, end: Bool,
         interFollowers: [Letter], finFollowers: [Letter]) {
        
        singlePhoneme = true
        super.init(first: vowel, second: consonant, start: start, end: end,
                   defFirst: [], defMiddle: interFollowers, defLast: finFollowers)
        
        verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return end }
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
    
    init(vowel: Letter, consonant: Letter, start: Bool, end: Bool,
         initFollowers: [Letter], interFollowers: [Letter], finFollowers: [Letter]) {
        
        singlePhoneme = true
        super.init(first: vowel, second: consonant, start: start, end: end,
                   defFirst: initFollowers, defMiddle: interFollowers, defLast: finFollowers)

        verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return end }
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
    
}

// Not too many cases with vowel-H pairings

// Need AHOY and AHEM
let AH = DiphthongBlend(vowel: .A, consonant: .H, start: false, end: false,
    initFollowers: [.E, .O],
    interFollowers: [.N, .R],
    finFollowers: [.N])  // plural?

let EH = DiphthongBlend(vowel: .E, consonant: .H, start: false, end: false,
    interFollowers: [],
    finFollowers: [])     // plural?

let OH = DiphthongBlend(vowel: .O, consonant: .H, start: true, end: false,
    initFollowers: [.M],
    interFollowers: [.N],
    finFollowers: [])      // plural?

//let UH = DiphthongBlend(vowel: .A, consonant: .H, start: false, end: false)

let AW = DiphthongBlend(vowel: .A, consonant: .W, start: true, end: true,
                        initFollowers: [.A, .E, .L, .N, .R],
                        interFollowers: [.A, .D, .E, .I, .L, .N, .R, .T],
                        finFollowers: [.L, .N, .S])

let EW = DiphthongBlend(vowel: .E, consonant: .W, start: true, end: true,
                        initFollowers: [.E],
                        interFollowers: [.A, .D, .E, .I, .L, .N, .T, .Y],
                        finFollowers: [.L, .N, .S, .T])

let OW = DiphthongBlend(vowel: .O, consonant: .W, start: true, end: true,
                        initFollowers: [.E, .I, .L, .N],
                        interFollowers: [.A, .D, .E, .I, .L, .N, .S, .Y],
                        finFollowers: [.L, .N, .S])

let AY = DiphthongBlend(vowel: .A, consonant: .Y, start: true, end: true,
                        initFollowers: [.E],
                        interFollowers: [.E, .I, .O],
                        finFollowers: [.O, .S])         // MAYO

let EY = DiphthongBlend(vowel: .E, consonant: .Y, start: true, end: true,
                        initFollowers: [.E],
                        interFollowers: [.E, .I, .O],
                        finFollowers: [.S])

let OY = DiphthongBlend(vowel: .O, consonant: .Y, start: true, end: true,
                        interFollowers: [.A, .E, .I, .O],
                        finFollowers: [.S])

let diphthongBlendMap = ["AH":AH, "EH":EH, "OH":OH,
                         "AW":AW, "EW":EW, "OW":OW,
                         "AY":AY, "EY":EY, "OY":OY]
