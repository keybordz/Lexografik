//
//  DiphthongBlend.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation
class DiphthongBlend: LexicalBlend, PhoneticFollowers {
    var initFollowers: [Letter]
    var interFollowers: [Letter]
    var finFollowers: [Letter]
    var singlePhoneme: Bool
    var followerTable: [String:[Letter]]
    
    func initialFollowers(nRemain: Int) -> [Letter] {
        return initFollowers
    }
    
    func secondFollowers(pea: PhoneticElementArray, nRemain: Int) -> [Letter] {
        let firstElement = pea.firstElement()               // Should only be one element
        
        if let secondFollowers = followerTable[firstElement!.id] {
            return secondFollowers
        }
        else {
            return []
        }
    }
    
    func midFollowers(pea: PhoneticElementArray, nRemain: Int) -> [Letter] {
        return interFollowers
    }
    
    func lastFollowers(pea: PhoneticElementArray) -> [Letter] {
        return finFollowers
    }
    
    func verifyFinal(pea: PhoneticElementArray) -> Bool {
        return true;
    }
    
    init(vowel: Letter, consonant: Letter, start: Bool, end: Bool,
         initFollowers: [Letter], interFollowers: [Letter], finFollowers: [Letter], followerTable: [String:[Letter]]) {
        
        self.initFollowers = initFollowers
        self.interFollowers = interFollowers
        self.finFollowers = finFollowers
        self.followerTable = followerTable
        singlePhoneme = true
        super.init(first: vowel, second: consonant, third: nil,
                   canStart: start, canEnd: end, canPlural: true,
                   dynFollowers: nil)

        verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return end }
        verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
    
}

// Not too many cases with vowel-H pairings

// AHOY, AHEM, BLAH
let AH = DiphthongBlend(vowel: .A, consonant: .H, start: true, end: true,
                        initFollowers: [.E, .O],
                        interFollowers: [.N, .R],
                        finFollowers: [.N, .S],
                        followerTable: [
                            "BL":[.S],          // BLAHS
                            "S":[.I]])          // SAHIB

let EH = DiphthongBlend(vowel: .E, consonant: .H, start: false, end: false,
                        initFollowers: [],
                        interFollowers: [],
                        finFollowers: [],
                        followerTable: [
                            "B":[.E],                   // BEHEMOTH
                            "R":[.A, .E, .I, .O, .U]])  // REHEAT

let OH = DiphthongBlend(vowel: .O, consonant: .H, start: true, end: false,
                        initFollowers: [.M],
                        interFollowers: [.N],
                        finFollowers: [],
                        followerTable: [
                            "J":[.N]])

//let UH = DiphthongBlend(vowel: .A, consonant: .H, start: false, end: false)

let AW = DiphthongBlend(vowel: .A, consonant: .W, start: true, end: true,
                        initFollowers: [.A, .E, .L, .N, .R],
                        interFollowers: [.A, .D, .E, .I, .L, .N, .R, .T],
                        finFollowers: [.L, .N, .S],
                        followerTable: [
                            "B":[.L],
                            "C":[.E, .I, .S],
                            "CL":[.E, .I, .S],
                            "CR":[.L, .S],
                            "D":[.N],
                            "DR":[.I, .S],
                            "F":[.N],
                            "FL":[.E, .S],
                            "GN":[.E, .I, .S],
                            "H":[.K, .S],
                            "J":[.B, .S],
                            "L":[.N, .S, .Y],
                            "M":[.S],
                            "P":[.E, .I, .N, .S],
                            "R":[.E],
                            "S":[.E, .I, .N, .S],
                            "SCR":[.L],
                            "SH":[.L],
                            "SL":[.E, .I, .S],
                            "SPR":[.L],
                            "TH":[.E, .I, .S],
                            "TR":[.L],
                            "Y":[.E, .I, .N, .S]])

let EW = DiphthongBlend(vowel: .E, consonant: .W, start: true, end: true,
                        initFollowers: [.E],
                        interFollowers: [.A, .D, .E, .I, .L, .N, .T, .Y],
                        finFollowers: [.L, .N, .S, .T],
                        followerTable: [
                            "BL":[],
                            "BR":[.E, .I, .S],
                            "CH":[.E, .I, .S, .Y],
                            "CR":[.S],
                            "D":[.Y],
                            "DR":[],
                            "FL":[],
                            "GR":[],
                            "H":[.E, .I, .N, .S],
                            "L":[.D],
                            "M":[.L, .S],
                            "N":[.E, .L, .S],
                            "P":[.S, .T],
                            "PH":[],
                            "S":[.E, .I, .N, .S],
                            "SCR":[.E, .I, .S, .Y],
                            "SHR":[.S],
                            "SL":[.S],
                            "SP":[.E, .I, .N, .S],
                            "ST":[.E, .I, .N, .S, .Y],
                            "Y":[.S]])

let OW = DiphthongBlend(vowel: .O, consonant: .W, start: true, end: true,
                        initFollowers: [.E, .I, .L, .N],
                        interFollowers: [.A, .D, .E, .I, .L, .N, .S, .Y],
                        finFollowers: [.L, .N, .S],
                        followerTable: [
                            "B":[.E, .I, .L, .N, .S],
                            "BL":[.E, .I, .N, .S],
                            "BR":[.E, .I, .N, .S],
                            "C":[.E, .I, .S],
                            "CH":[.E, .I, .S],
                            "CL":[.N],
                            "CR":[.D, .E, .I, .N, .S],
                            "D":[.E, .N, .S],
                            "F":[.L],
                            "FL":[.E, .I, .N, .S],
                            "FR":[.N, .S],
                            "G":[.N],
                            "GL":[.E, .I, .S],
                            "GR":[.I, .L, .N],
                            "H":[.L],
                            "J":[.E],
                            "L":[.E, .I, .L, .S],
                            "M":[.E, .I, .N, .S],
                            "N":[.S],
                            "P":[.E, .S],
                            "PL":[.E, .I, .S],
                            "PR":[.E, .I, .L, .S],
                            "R":[.E, .I, .S],
                            "S":[.E, .I, .N, .S],
                            "SC":[.E, .I, .S],
                            "SH":[.E, .I, .N, .S, .Y],
                            "SL":[.E, .I, .L, .S],
                            "SN":[.E, .I, .S, .Y],
                            "ST":[.E, .I, .N, .S],
                            "T":[.E, .I, .S],
                            "V":[.E, .I, .S],
                            "W":[.E, .I, .S]])

let AY = DiphthongBlend(vowel: .A, consonant: .Y, start: true, end: true,
                        initFollowers: [.E],
                        interFollowers: [.E, .I, .O],
                        finFollowers: [.O, .S],
                        followerTable: [
                            "B":[.E, .I, .S],
                            "BR":[.E, .I, .S],
                            "C":[.S],
                            "CL":[.S],
                            "CR":[.S],
                            "D":[.S],
                            "DR":[.S],
                            "F":[.S],
                            "FL":[.E, .I, .S],
                            "FR":[.E, .I, .S],
                            "G":[.E, .S],
                            "GR":[.E, .I, .S],
                            "H":[.E, .I, .S],
                            "J":[.S],
                            "L":[.E, .I, .S],
                            "M":[.O, .P, .S],       // MAYO(R), MAYPOLE, MAYS
                            "N":[.S],
                            "P":[.E, .I, .D],
                            "PL":[.E, .I, .S],
                            "PR":[.E, .I, .S],
                            "QU":[.S],
                            "R":[.O, .S],           // RAYON
                            "S":[.I, .S],
                            "SH":[.S],
                            "SL":[.E, .I, .S],
                            "SP":[.E, .I, .S],
                            "SPR":[.E, .I, .S],
                            "ST":[.E, .I, .S],
                            "STR":[.E, .I, .S],
                            "SW":[.E, .I, .S],
                            "TR":[.S],
                            "W":[.S],
                            "WR":[.S],
                            "Y":[.S]])

let EY = DiphthongBlend(vowel: .E, consonant: .Y, start: true, end: true,
                        initFollowers: [.E],
                        interFollowers: [.E, .I, .O],
                        finFollowers: [.S],
                        followerTable: [
                            "B":[.O],               // BEYOND
                            "F":[.E, .S],
                            "GR":[.E, .I, .S],
                            "H":[.S],
                            "K":[.E, .I, .R, .S],
                            "PR":[.E, .I, .S],
                            "TR":[.S],
                            "WH":[.S]])

let OY = DiphthongBlend(vowel: .O, consonant: .Y, start: true, end: true,
                        initFollowers: [],
                        interFollowers: [.A, .E, .I, .O],
                        finFollowers: [.S],
                        followerTable: [
                            "B":[.H, .S],       // BOYHOOD, BOYS
                            "C":[.E, .L],
                            "CL":[.I],
                            "D":[.E],           // DOYEN
                            "F":[.E],           // FOYER
                            "G":[.S],
                            "J":[.F, .O, .S],   // JOYFUL, JOYOUS, JOYS
                            "L":[.A],           // LOYAL
                            "PL":[.S],
                            "R":[.A],           // ROYAL
                            "S":[.B, .S],       // SOYBEAN, SOYS
                            "T":[.E, .I, .S],
                            "V":[.E],           // VOYEUR
                            "Y":[.O]])

let UY = DiphthongBlend(vowel: .U, consonant: .Y, start: true, end: true,
                        initFollowers: [],
                        interFollowers: [.E, .I],
                        finFollowers: [.S],
                        followerTable: [
                            "B":[.E, .I, .S],
                            "G":[.S]])

let diphthongBlendMap = ["AH":AH, "EH":EH, "OH":OH,
                         "AW":AW, "EW":EW, "OW":OW,
                         "AY":AY, "EY":EY, "OY":OY, "UY":UY]
