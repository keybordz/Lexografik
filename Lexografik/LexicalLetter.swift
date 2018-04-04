//
//  LexicalLetter.swift
//  Lexografik
//
//  Created by Jay Wright on 1/25/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class LexicalLetter: PhoneticElement {
//    let blendStart: [Letter]
//    let blendInto: [Letter]
//    let blendFinal: [Letter]
    let canPlural: Bool
    let endBias: Int
    
    init(id: Letter, blendStart: [Letter], blendInto: [Letter], blendFinal: [Letter], canPlural: Bool, endBias: Int) {
//        self.blendStart = blendStart
//        self.blendInto = blendInto
//        self.blendFinal = blendFinal
        self.canPlural = canPlural
        self.endBias = endBias
        super.init(defFirst: blendStart, defMiddle: blendInto, defLast: blendFinal)
        self.id = id.rawValue
        self.numLetters = 1
    }
}

let letterDictionary: [Letter:LexicalLetter] = [.A:A, .B:B, .C:C, .D:D, .E:E, .F:F, .G:G, .H:H, .I:I, .J:J, .K:K, .L:L, .M:M, .N:N, .O:O, .P:P, .Q:Q, .R:R, .S:S, .T:T, .U:U, .V:V, .W:W, .X:X, .Y:Y, .Z:Z]




