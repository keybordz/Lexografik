//
//  YBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 4/6/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class YBlend: ConsonantBlend {
    
    init(first: Letter,
         initBlend: [Letter],
         initVowels: [Letter],
         midBlend: [Letter],
         midVowels: [Letter],
         finFollowers: [Letter])
    {
        super.init(first: first, second: .Y, third: nil,
                   initBlend: initBlend, initVowels: initVowels, midBlend: midBlend, midVowels: midVowels, finFollowers: finFollowers,
                   canPlural: false, blendsWithY: false, single: true, endOfWord: true, preceders: [],
                   dynFollowers: nil, verifyEnd: nil)
    }
}

// BYES, BYPASS, BYSTANDER, BYTE, BYZANTINE
let BY = YBlend(first: .B,
                initBlend: [.P, .S, .T, .Z],
                initVowels: [.E],
                midBlend: [.T],
                midVowels: [.I],
                finFollowers: [])

// CYANIDE, CYBER, CYCLE, CYGNET, CYPHER, CYST
let CY = YBlend(first: .C,
                initBlend: [.B, .C, .G, .P, .S],
                initVowels: [.A],
                midBlend: [.T],     // SCYTHE
                midVowels: [.I],
                finFollowers: [])

// DYES, DYSTOPIA, DYNOMITE
let DY = YBlend(first: .D,
                initBlend: [.N, .S],
                initVowels: [.E],
                midBlend: [],
                midVowels: [.I],
                finFollowers: [])

// How useful is this, other than securing FFY?
let FY = YBlend(first: .F,
                initBlend: [],
                initVowels: [],
                midBlend: [],
                midVowels: [],
                finFollowers: [])

// GYMNASIUM, GYROSCOPE, GYPSY, GYNECOLOGY
let GY = YBlend(first: .G,
                initBlend: [.M, .N, .P, .R],
                initVowels: [],
                midBlend: [],
                midVowels: [],
                finFollowers: [])

// HYACINTH, HYENA, HYMN, HYSTERIA
let HY = YBlend(first: .H,
                initBlend: [.M, .S],
                initVowels: [.A, .E, .I],
                midBlend: [.M, .S, .T],     // RHYTHM, RHYME, THYME, AMETHYST
                midVowels: [.I],
                finFollowers: [])

// Any application besides end of word like SHAKY?
let KY = YBlend(first: .K,
                initBlend: [],
                initVowels: [],
                midBlend: [],
                midVowels: [],
                finFollowers: [])

// LYES, LYING, LYME, LYRIC, ANALYSIS, ANALYST
let LY = YBlend(first: .L,
                initBlend: [.M, .R],
                initVowels: [.E, .I],
                midBlend: [.S],
                midVowels: [],
                finFollowers: [])

// MYNA, MYOPIA, MYSTERY
let MY = YBlend(first: .M,
                initBlend: [.N, .S],
                initVowels: [.O],
                midBlend: [],
                midVowels: [],
                finFollowers: [])

// NYLON, *VINYL
let NY = YBlend(first: .B,
                initBlend: [.L],
                initVowels: [],
                midBlend: [.L],
                midVowels: [],
                finFollowers: [.L])

// PYLON, PYROTECHNIC
let PY = YBlend(first: .P,
                initBlend: [.L, .R],
                initVowels: [],
                midBlend: [],
                midVowels: [.I],
                finFollowers: [])

// RYES
let RY = YBlend(first: .R,
                initBlend: [],
                initVowels: [.E],
                midBlend: [],
                midVowels: [.I],
                finFollowers: [.S])         // DRYS

// SYCOPHANT, SYLLABUS, SYMBOL, SYNERGY, SYPHILIS, SYSTEM
let SY = YBlend(first: .S,
                initBlend: [.C, .L, .M, .N, .P, .S],
                initVowels: [],
                midBlend: [.C],
                midVowels: [],
                finFollowers: [])

// TYPE, TYING, TYRANT
let TY = YBlend(first: .T,
                initBlend: [.P, .R],
                initVowels: [.I],
                midBlend: [],
                midVowels: [.I],
                finFollowers: [.E, .R])        // STYE, SATYR

// VYING
let VY = YBlend(first: .V,
                initBlend: [],
                initVowels: [.I],
                midBlend: [],
                midVowels: [],
                finFollowers: [])

let WY = YBlend(first: .W,
                initBlend: [],
                initVowels: [],
                midBlend: [],
                midVowels: [],
                finFollowers: [])

// ZYGOTE
let ZY = YBlend(first: .Z,
                initBlend: [.G],
                initVowels: [],
                midBlend: [],
                midVowels: [],
                finFollowers: [])

let YBlendMap = ["BY":BY, "CY":CY, "DY":DY, "FY":FY, "GY":GY, "HY":HY, "KY":KY, "LY":LY, "MY":MY,
                 "NY":NY, "PY":PY, "RY":RY, "SY":SY, "TY":TY, "VY":VY, "WY":WY, "ZY":ZY]

