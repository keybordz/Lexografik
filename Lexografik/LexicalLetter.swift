//
//  LexicalLetter.swift
//  Lexografik
//
//  Created by Jay Wright on 1/25/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class LexicalLetter: PhoneticElement {
    let blendStart: [Letter]
    let blendInto: [Letter]
    let canPlural: Bool
    let endBias: Int  // 0 - Rarely, 1 - Occasionally, 2 - Commonly, 3 - Frequently
    
    init(id: Letter, blendStart: [Letter], blendInto: [Letter], canPlural: Bool, endBias: Int) {
        self.blendStart = blendStart
        self.blendInto = blendInto
        self.canPlural = canPlural
        self.endBias = endBias
        super.init()
        self.id = id.rawValue
        self.numLetters = 1
    }
}

let letterDictionary: [Letter:LexicalLetter] = [.A:A, .B:B, .C:C, .D:D, .E:E, .F:F, .G:G, .H:H, .I:I, .J:J, .K:K, .L:L, .M:M, .N:N, .O:O, .P:P, .Q:Q, .R:R, .S:S, .T:T, .U:U, .V:V, .W:W, .X:X, .Y:Y, .Z:Z]




