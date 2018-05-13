//
//  Letter.swift
//  Lexografik
//
//  Created by Jay Wright on 2/10/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

enum Phonetic {
    case consonant
    case vowel
}

enum Letter: String {
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case H = "H"
    case I = "I"
    case J = "J"
    case K = "K"
    case L = "L"
    case M = "M"
    case N = "N"
    case O = "O"
    case P = "P"
    case Q = "Q"
    case R = "R"
    case S = "S"
    case T = "T"
    case U = "U"
    case V = "V"
    case W = "W"
    case X = "X"
    case Y = "Y"
    case Z = "Z"
    case any = "*"
    
    func isVowel() -> Bool {
        let vowels = [Letter.A, .E, .I, .O, .U]
        
        return vowels.contains(self)
    }
    
    func isDipthong() -> Bool {
        let dipthongs = [Letter.H, .W, .Y]
        
        return dipthongs.contains(self)
    }
    
    func blendsWithS() -> Bool {
        let blends = [Letter.C, .H, .K, .L, .M, .N, .P, .Q, .T, .W]
        
        return blends.contains(self)
    }
    
    func isBlendable() -> Bool {
        let blenders = [Letter.B, .C, .D, .F, .G, .K, .P, .S, .T, .W]
        
        return blenders.contains(self)
    }
    
    func isLiquid() -> Bool {
        let liquids = [Letter.L, .R]
        
        return liquids.contains(self)
    }
    
    func isAspirate() -> Bool {
        let aspirates = [Letter.C, .G, .P, .S, .T, .W]
        
        return aspirates.contains(self)
    }
    
    func isRareConsonant() -> Bool {
        let rareOnes = [Letter.J, .Q, .X, .Z]
        
        return rareOnes.contains(self)
    }
    
    func isConsonant() -> Bool {
        return !self.isVowel()
    }
    
    func isDoublingConsonant() -> Bool {
        let doubles = [Letter.B, .D, .F, .G, .L, .M, .N, .P, .R, .S, .T, .V, .Z]
        
        return doubles.contains(self)
    }
}

let allVowels: [Letter] = [.A, .E, .I, .O, .U]
let allConsonants: [Letter] = [.B, .C, .D, .E, .F, .G, .H, .J, .K, .L, .M, .N, .P, .Q, .R, .S, .T, .V, .W, .X, .Y, .Z]
