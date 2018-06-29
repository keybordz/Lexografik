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
    
    func secondFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter] {
        let firstElement = syll.firstElement()               // Should only be one element
        
        if let secondFollowers = followerTable[firstElement!.id] {
            return secondFollowers
        }
        else {
            return []
        }
    }
    
    func midFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter] {
        return interFollowers
    }
    
    func lastFollowers(syll: SyllabicArray) -> [Letter] {
        return finFollowers
    }
    
    func verifyFinal(syll: SyllabicArray) -> Bool {
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
                            "S":[.I],           // SAHIB
                            "SH":[.S]])         // SHAHS

let EH = DiphthongBlend(vowel: .E, consonant: .H, start: false, end: false,
                        initFollowers: [],
                        interFollowers: [],
                        finFollowers: [],
                        followerTable: [
                            "B":[.E],                   // BEHEMOTH
                            "D":[.U],                   // DEHUMIDIFY
                            "R":[.A, .E, .I, .O, .U]])  // REHEAT

let OH = DiphthongBlend(vowel: .O, consonant: .H, start: true, end: false,
                        initFollowers: [.M],
                        interFollowers: [.N],
                        finFollowers: [],       // Need conditional A for ALOHA
                        followerTable: [
                            "J":[.N]])

//let UH = DiphthongBlend(vowel: .A, consonant: .H, start: false, end: false)

let AW = DiphthongBlend(vowel: .A, consonant: .W, start: true, end: true,
                        initFollowers: [.A, .E, .I, .L, .N, .O, .R],
                        interFollowers: [.A, .D, .E, .I, .L, .N, .R, .T],
                        finFollowers: [.L, .N, .S],
                        followerTable: [
                            "B":[.L],               // BAWL
                            "BR":[.N],              // BRAWN
                            "C":[.E, .I, .S],       // CAWED, CAWING, CAWS
                            "CL":[.E, .I, .S],      // CLAWED, CLAWING, CLAWS
                            "CR":[.F, .L, .S],      // CRAWFISH, CRAWL, CRAWS
                            "D":[.D, .N],           // DAWDLE, DAWN
                            "DR":[.B, .E, .I, .N, .S],  // DRAWBACK, DRAWER, DRAWING, DRAWN, DRAWS
                            "F":[.N],               // FAWN
                            "FL":[.E, .L, .S],      // FLAWED, FLAWLESS, FLAWS
                            "G":[.K],               // GAWK
                            "GN":[.E, .I, .N, .S],  // GNAWED, GNAWING, GNAWN, GNAWS
                            "H":[.K, .S],           // HAWK, HAWS
                            "J":[.B, .E, .I, .S],   // JAWBONE, JAWED, JAWING, JAWS
                            "L":[.F, .L, .N, .S, .Y],   // LAWFUL, LAWLESS, LAWN, LAWS, LAWYER
                            "M":[.S],               // MAWS
                            "P":[.E, .I, .N, .S],   // PAWED, PAWING, PAWN, PAWS
                            "PR":[.N],              // PRAWN
                            "R":[.E],               // RAWER
                            "S":[.E, .I, .N, .S],   // SAWED, SAWING, SAWN, SAWS
                            "SCR":[.L],             // SCRAWL
                            "SH":[.L, .M],          // SHAWL, SHAWM
                            "SL":[.E, .I, .S],      // SLAWED, SLAWING, SLAWS
                            "SP":[.N],              // SPAWN
                            "SPR":[.L],             // SPRAWL
                            "SQU":[.K],             // SQUAWK
                            "STR":[.N, .S],         // STRAWN, STRAWS
                            "T":[.N],               // TAWNY
                            "TH":[.E, .I, .N, .S],  // THAWED, THAWING, THAWN, THAWS
                            "TR":[.L],              // TRAWL
                            "Y":[.I, .N, .S]])      // YAWING, YAWN, YAWS

let EW = DiphthongBlend(vowel: .E, consonant: .W, start: true, end: true,
                        initFollowers: [.E],
                        interFollowers: [.A, .D, .E, .I, .L, .N, .T, .Y],
                        finFollowers: [.L, .N, .S, .T],
                        followerTable: [
                            "BL":[],                // BLEW
                            "BR":[.E, .I, .S],      // BREWED, BREWING, BREWS
                            "CH":[.E, .I, .S, .Y],  // CHEWED, CHEWING, CHEWS, CHEWY
                            "CR":[.S],              // CREWS
                            "D":[.S, .Y],           // DEWS, DEWY
                            "DR":[],                // DREW
                            "FL":[],                // FLEW
                            "GR":[],                // GREW
                            "H":[.E, .I, .N, .S],   // HEWED, HEWING, HEWN, HEWS
                            "L":[.D],               // LEWD
                            "M":[.L, .S],           // MEWL, MEWS
                            "N":[.E, .L, .S, .T],   // NEWER, NEWLY, NEWS, NEWT
                            "P":[.S, .T],           // PEWS, PEWTER
                            "PH":[],                // PHEW
                            "S":[.E, .I, .N, .S],   // SEWED, SEWING, SEWN, SEWS
                            "SCR":[.E, .I, .S, .Y], // SCREWED, SCREWING, SCREWS, SCREWY
                            "SHR":[.D, .S],         // SHREWD, SHREWS
                            "SL":[.S],              // SLEWS
                            "SP":[.E, .I, .N, .S],  // SPEWED, SPEWING, SPEWN, SPEWS
                            "ST":[.E, .I, .N, .S, .Y],  // STEWED, STEWING, STEWN, STEWS, STEWY
                            "STR":[.N],             // STREWN
                            "Y":[.S]])              // YEWS

let OW = DiphthongBlend(vowel: .O, consonant: .W, start: true, end: true,
                        initFollowers: [.E, .I, .L, .N],
                        interFollowers: [.A, .D, .E, .I, .L, .N, .S, .Y],
                        finFollowers: [.L, .N, .S],
                        followerTable: [
                            "B":[.E, .I, .L, .N, .S],       // BOWED, BOWING, BOWL, BOWN, BOWS
                            "BL":[.E, .I, .N, .S],          // BLOWED, BLOWING, BLOWN, BLOWS
                            "BR":[.E, .I, .N, .S],          // BROWED, BROWING, BROWN, BROWS
                            "C":[.E, .I, .S],               // COWED, COWING, COWS
                            "CH":[.E, .I, .S],              // CHOWED, CHOWING, CHOWS
                            "CL":[.N],                      // CLOWN
                            "CR":[.D, .E, .I, .N, .S],      // CROWD, CROWED, CROWING, CROWN, CROWS
                            "D":[.A, .D, .E, .N, .S],       // DOWAGER, DOWDY, DOWEL, DOWN, DOWS
                            "DR":[.S],                      // DROWSY
                            "F":[.L],                       // FOWL
                            "FL":[.E, .I, .N, .S],          // FLOWED, FLOWING, FLOWN, FLOWS
                            "FR":[.N],                      // FROWN
                            "G":[.N],                       // GOWN
                            "GL":[.E, .I, .S],              // GLOWED, GLOWING, GLOWS
                            "GR":[.I, .L, .N],              // GROWING, GROWL, GROWN
                            "H":[.L, .S],                   // HOWL, HOWS
                            "J":[.E],                       // JOWEL
                            "K":[.T],                       // KOWTOW
                            "KN":[.I, .L, .S],              // KNOWING, KNOWLEDGE, KNOWS
                            "L":[.E, .I, .L, .S],           // LOWED, LOWING, LOWLY, LOWS
                            "M":[.E, .I, .N, .S],           // MOWED, MOWING, MOWN, MOWS
                            "N":[.S],                       // NOWS
                            "P":[.E, .S],                   // POWER, POWS
                            "PL":[.E, .I, .S],              // PLOWED, PLOWING, PLOWS
                            "PR":[.E, .I, .L, .S],          // PROWED, PROWING, PROWL, PROWS
                            "R":[.D, .E, .I, .N, .S],       // ROWDY, ROWED, ROWING, ROWN, ROWS
                            "S":[.E, .I, .N, .S],           // SOWED, SOWING, SOWN, SOWS
                            "SC":[.E, .I, .L, .S],          // SCOWED, SCOWING, SCOWL, SCOWS
                            "SH":[.E, .I, .N, .S, .Y],      // SHOWED, SHOWING, SHOWN, SHOWS, SHOWY
                            "SL":[.E, .I, .L, .S],          // SLOWED, SLOWING, SLOWLY, SLOWS
                            "SN":[.E, .I, .S, .Y],          // SNOWED, SNOWING, SNOWS, SNOWY
                            "ST":[.E, .I, .N, .S],          // STOWED, STOWING, STOWN, STOWS
                            "T":[.E, .I, .N, .S],           // TOWED, TOWING, TOWN, TOWS
                            "THR":[.I, .N, .S],             // THROWING, THROWN, THROWS
                            "TR":[.E],                      // TROWEL
                            "V":[.E, .I, .S],               // VOWEL/VOWED, VOWING, VOWS
                            "W":[.E, .I, .S]])              // WOWED, WOWING, WOWS

let AY = DiphthongBlend(vowel: .A, consonant: .Y, start: true, end: true,
                        initFollowers: [.E],
                        interFollowers: [.E, .I, .O],
                        finFollowers: [.O, .S],
                        followerTable: [
                            "B":[.E, .I, .S],           // BAYED, BAYING, BAYS
                            "BR":[.E, .I, .S],          // BRAYED, BRAYING, BAYS
                            "C":[.S],                   // CAYS
                            "CL":[.S],                  // CLAYS
                            "CR":[.S],                  // CRAY
                            "D":[.S],                   // DAYS
                            "DR":[.S],                  // DRAYS
                            "FL":[.E, .I, .S],          // FLAYS
                            "FR":[.E, .I, .S],          // FRAYS
                            "G":[.E, .S],               // GAYER, GAYS
                            "GR":[.E, .I, .S],          // GRAYER, GRAYING, GRAYS
                            "H":[.E, .I, .S],           // HAYER, HAYING, HAYS
                            "J":[.S],                   // JAYS
                            "L":[.E, .I, .M, .S],       // LAYER, LAYING, LAYMAN, LAYS
                            "M":[.O, .P, .S],           // MAYO(R), MAYPOLE, MAYS
                            "N":[.S],                   // NAYS
                            "P":[.E, .I, .D, .S],       // PAYER, PAYING, PAYDAY, PAYS
                            "PL":[.B, .E, .I, .S],      // PLAYBOY, PLAYER, PLAYING, PLAYS
                            "PR":[.E, .I, .S],          // PRAYED, PRAYING, PRAYS
                            "QU":[.S],                  // QUAYS
                            "R":[.O, .S],               // RAYON, RAYS
                            "S":[.E, .I, .S],           // SAYER, SAYING, SAYS
                            "SL":[.E, .I, .S],          // SLAYED, SLAYING, SLAYS
                            "SP":[.E, .I, .S],          // SPAYED, SPAYING, SPAYS
                            "SPR":[.E, .I, .S],         // SPRAYED, SPRAYING, SPRAYS
                            "ST":[.E, .I, .S],          // STAYED, STAYING, STAYS
                            "STR":[.E, .I, .S],         // STRAY, STRAYING, STRAYS
                            "SW":[.E, .I, .S],          // SWAYED, SWAYING, SWAYS
                            "TR":[.S],                  // TRAYS
                            "W":[.F, .S],               // WAYFARING, WAYS
                            "WR":[.S],                  // WRAYS
                            "Y":[.S]])                  // YAYS

let EY = DiphthongBlend(vowel: .E, consonant: .Y, start: true, end: true,
                        initFollowers: [.E],
                        interFollowers: [.E, .I, .O],
                        finFollowers: [.S],
                        followerTable: [
                            "B":[.O],                   // BEYOND
                            "F":[.E, .L],               // FEYER, FEYLY
                            "G":[.S],                   // GEYSER
                            "GR":[.E, .I, .S],          // GREYED, GREYING, GREYS
                            "H":[.S],                   // HEYS
                            "K":[.E, .I, .R, .S],       // KEYS, KEYING, KEYRING, KEYS(TONE)
                            "PR":[.E, .I, .S],          // PREYED, PREYING, PREYS
                            "TR":[.S],                  // TREYS
                            "WH":[.S]])                 // WHEYS

let OY = DiphthongBlend(vowel: .O, consonant: .Y, start: true, end: true,
                        initFollowers: [],
                        interFollowers: [.A, .E, .I, .O],
                        finFollowers: [.S],
                        followerTable: [
                            "B":[.F, .H, .S],        // BOYFRIEND, BOYHOOD, BOYS
                            "C":[.E, .L],            // COYER, COYLY
                            "CL":[.E, .I, .S],       // CLOYED, CLOYING, CLOYS
                            "D":[.E],                // DOYEN
                            "F":[.E],                // FOYER
                            "G":[.S],                // GOYS?
                            "J":[.F, .O, .S],        // JOYFUL, JOYOUS, JOYS
                            "L":[.A],                // LOYAL
                            "PL":[.S],               // PLOYS
                            "R":[.A],                // ROYAL
                            "S":[.B, .S],            // SOYBEAN, SOYS
                            "T":[.E, .I, .S],        // TOYED, TOYING, TOYS
                            "V":[.A, .E],            // VOYAGE, VOYEUR
                            "Y":[.O]])               // YOYO

let UY = DiphthongBlend(vowel: .U, consonant: .Y, start: true, end: true,
                        initFollowers: [],
                        interFollowers: [.E, .I],
                        finFollowers: [.S],
                        followerTable: [
                            "B":[.E, .I, .S],            // BUYING, BUYS
                            "G":[.S]])                   // GUYS

let diphthongBlendMap = ["AH":AH, "EH":EH, "OH":OH,
                         "AW":AW, "EW":EW, "OW":OW,
                         "AY":AY, "EY":EY, "OY":OY, "UY":UY]
