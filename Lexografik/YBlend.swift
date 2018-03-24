//
//  YBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 4/6/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class YBlend: ConsonantBlend {
    init(first: Letter, initFollowers: [Letter], interFollowers: [Letter]) {
        super.init(first: first, second: .Y, start: true, end: true, single: true)
        initialFollowers = { return initFollowers }
        interiorFollowers = { (phonemes:PhoneticElementArray) in return interFollowers }
    }
}

let BY = YBlend(first: .B, initFollowers: [.E, .P, .S, .T, .Z], interFollowers: [.S, .T])
let CY = YBlend(first: .C, initFollowers: [.A, .P, .S], interFollowers: [.T])
let DY = YBlend(first: .D, initFollowers: [.E, .N, .S], interFollowers: [])
let FY = YBlend(first: .F, initFollowers: [], interFollowers: [])
let GY = YBlend(first: .G, initFollowers: [.R], interFollowers: [])
let HY = YBlend(first: .H, initFollowers: [.A], interFollowers: [])
let KY = YBlend(first: .K, initFollowers: [], interFollowers: [.L])
let LY = YBlend(first: .L, initFollowers: [.E, .I, .R], interFollowers: [])
let MY = YBlend(first: .M, initFollowers: [.N, .O, .S], interFollowers: [])
let NY = YBlend(first: .N, initFollowers: [], interFollowers: [.L])    // VINYL
let PY = YBlend(first: .P, initFollowers: [.R], interFollowers: [])
let RY = YBlend(first: .R, initFollowers: [.E, .I], interFollowers: [])
let SY = YBlend(first: .S, initFollowers: [.L, .M, .N], interFollowers: [])
let TY = YBlend(first: .T, initFollowers: [.I, .R], interFollowers: [])
let VY = YBlend(first: .V, initFollowers: [.I], interFollowers: [])    // VYING
let WY = YBlend(first: .W, initFollowers: [], interFollowers: [])
let ZY = YBlend(first: .W, initFollowers: [], interFollowers: [])

let YBlendMap = ["BY":BY, "CY":CY, "DY":DY, "FY":FY, "GY":GY, "HY":HY, "KY":KY, "LY":LY, "MY":MY,
                 "NY":NY, "PY":PY, "RY":RY, "SY":SY, "TY":TY, "VY":VY, "WY":WY, "ZY":ZY]

