//
//  PhoneticFollower.swift
//  Lexografik
//
//  Created by Jay Wright on 5/14/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import Foundation

protocol PhoneticFollowers {
    func initialFollowers(nRemain: Int) -> [Letter]
    func secondFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter]
    func midFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter]
    func lastFollowers(syll: SyllabicArray) -> [Letter]
}

class PhoneticFollower {
    let element: PhoneticElement
    let tokens: String
    
    init(element: PhoneticElement,
         tokenStr: String) {
        self.element = element
        self.tokens = tokenStr
    }
}

