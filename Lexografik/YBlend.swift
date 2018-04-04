//
//  YBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 4/6/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class YBlend: ConsonantBlend {
    init(first: Letter, initFollowers: [Letter], interFollowers: [Letter], finFollowers: [Letter]) {
        super.init(first: first, second: .Y, start: true, end: true, single: true)
        
        defaultFirst = initFollowers
        defaultMiddle = interFollowers
        defaultLast = finFollowers
        initialFollowers = { return initFollowers }
        interiorFollowers = { (phonemes:PhoneticElementArray) in return interFollowers }
        finalFollowers = { (phonemes:PhoneticElementArray) in return finFollowers }
    }
}

// BYES, BYPASS, BYTE, BYZANTINE
let BY = YBlend(first: .B,
                initFollowers: [.E, .P, .T, .Z],
                interFollowers: [.E, .T],
                finFollowers: [])

// CYCLE, CYST, CYPHER
let CY = YBlend(first: .C,
                initFollowers: [.A, .C, .P, .S],
                interFollowers: [.T],
                finFollowers: [])

// DYES, DYSTOPIA, DYNOMITE
let DY = YBlend(first: .D,
                initFollowers: [.E, .N, .S],
                interFollowers: [],
                finFollowers: [])

let FY = YBlend(first: .F,
                initFollowers: [],
                interFollowers: [],
                finFollowers: [])

// GYROSCOPE, GYPSY
let GY = YBlend(first: .G,
                initFollowers: [.P, .R],
                interFollowers: [],
                finFollowers: [])

// HYACINTH, HYENA
let HY = YBlend(first: .H,
                initFollowers: [.A, .E],
                interFollowers: [],
                finFollowers: [])

let KY = YBlend(first: .K,
                initFollowers: [],
                interFollowers: [.L],
                finFollowers: [])

// LYES, LYING, LYRIC, ANALYSIS
let LY = YBlend(first: .L,
                initFollowers: [.E, .I, .R],
                interFollowers: [.S],
                finFollowers: [])

// MYNA, MYOPIA, MYSTERY
let MY = YBlend(first: .M,
                initFollowers: [.N, .O, .S],
                interFollowers: [],
                finFollowers: [])

// NYLON, *VINYL
let NY = YBlend(first: .N,
                initFollowers: [.L],
                interFollowers: [.L],
                finFollowers: [.L])

// PYLON, PYROTECHNIC
let PY = YBlend(first: .P,
                initFollowers: [.L, .R],
                interFollowers: [],
                finFollowers: [])

// RYES
let RY = YBlend(first: .R,
                initFollowers: [.E, .I],
                interFollowers: [],
                finFollowers: [])

// SYCOPHANT, SYLLABUS, SYMBOL, SYNERGY, SYSTEM
let SY = YBlend(first: .S,
                initFollowers: [.C, .L, .M, .N, .S],
                interFollowers: [],
                finFollowers: [])

let TY = YBlend(first: .T,
                initFollowers: [.I, .R],
                interFollowers: [],
                finFollowers: [])

// VYING
let VY = YBlend(first: .V,
                initFollowers: [.I],
                interFollowers: [],
                finFollowers: [])

let WY = YBlend(first: .W,
                initFollowers: [],
                interFollowers: [],
                finFollowers: [])

let ZY = YBlend(first: .W,
                initFollowers: [],
                interFollowers: [],
                finFollowers: [])

let YBlendMap = ["BY":BY, "CY":CY, "DY":DY, "FY":FY, "GY":GY, "HY":HY, "KY":KY, "LY":LY, "MY":MY,
                 "NY":NY, "PY":PY, "RY":RY, "SY":SY, "TY":TY, "VY":VY, "WY":WY, "ZY":ZY]

