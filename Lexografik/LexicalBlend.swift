//
//  LexicalBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 2/5/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

// Group all blends under a singular type
class LexicalBlend: PhoneticElement {

    init(first: Letter, second: Letter, third: Letter?,
         canStart: Bool, canEnd: Bool, canPlural: Bool,
         dynFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?) {

        super.init(first: first, second: second, third: third,
                   canStart: canStart, canEnd: canEnd, canPlural: canPlural,
                   dynFollowers: dynFollowers)
    }
}










