//
//  LexicalLetter.swift
//  Lexografik
//
//  Created by Jay Wright on 1/25/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

// This class only exists to group vowels and consonants under one branch from PhoneticElement
class LexicalLetter: PhoneticElement {
    
    override init(first: Letter, second: Letter?, third: Letter?,
                  canStart: Bool, canEnd: Bool, canPlural: Bool,
                  dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?) {
        
        super.init(first: first, second: nil, third: nil,
                   canStart: canStart, canEnd: canEnd, canPlural: canPlural,
                   dynFollowers: dynFollowers)
    }
}

let letterDictionary: [Letter:LexicalLetter] = [.A:A, .B:B, .C:C, .D:D, .E:E, .F:F, .G:G, .H:H, .I:I, .J:J, .K:K, .L:L, .M:M,
                                                .N:N, .O:O, .P:P, .Q:Q, .R:R, .S:S, .T:T, .U:U, .V:V, .W:W, .X:X, .Y:Y, .Z:Z]




