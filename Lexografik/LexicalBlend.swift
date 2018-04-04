//
//  LexicalBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 2/5/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class LexicalBlend: PhoneticElement {
    let firstLetter: Letter
    let secondLetter: Letter
    let thirdLetter: Letter?
    let canEnd: Bool

    init(first: Letter, second: Letter, start: Bool, end: Bool,
         defFirst: [Letter], defMiddle: [Letter], defLast: [Letter]) {
        firstLetter = first
        secondLetter = second
        thirdLetter = nil
        canEnd = end
        super.init(defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        id = "\(first.rawValue)\(second.rawValue)"
        numLetters = 2
    }
    
    init(first: Letter, second: Letter, third: Letter, start: Bool, end: Bool,
         defFirst: [Letter], defMiddle: [Letter], defLast: [Letter]) {
        firstLetter = first
        secondLetter = second
        thirdLetter = third
        canEnd = end
        super.init(defFirst: defFirst, defMiddle: defMiddle, defLast: defLast)
        id = "\(first.rawValue)\(second.rawValue)\(third.rawValue)"
        numLetters = 3
    }
}










