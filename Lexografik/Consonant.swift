//
//  Consonant.swift
//  Lexografik
//
//  Created by Jay Wright on 2/14/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class Consonant: LexicalLetter, PhoneticFollowers {
    let blendStart: [Letter]
    let blendInto: [Letter]
    let defFinal: [Letter]
    let hardStops: [Letter]
    let allowedVowels: [Letter]
    let blendsWithY: Bool
    let dipthong: Bool
    let liquidBlend: Bool
    let followerTable: [String:[Letter]]
    
    func initialFollowers(nRemain: Int) -> [Letter] {
        var initFollowers: [Letter] = blendStart + allowedVowels
        if blendsWithY {
            initFollowers += [.Y]
        }
        return initFollowers
    }
    
    func secondFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter] {
        let firstElement: PhoneticElement?
        
        // Y's operating as vowels in the middle of a word
        if self.id == "Y" {
            firstElement = syll.firstElement()
        }
            
        else {
            firstElement = syll.initialVowel()
        }
        
        if let secondFollowers = followerTable[firstElement!.id] {
            return secondFollowers
        }
        else {
            return []
        }
    }
    
    func midFollowers(syll: SyllabicArray, nRemain: Int) -> [Letter] {
        let lastElement = syll.lastElement()
        var midFollowers: [Letter]
        
        // Only vowels allowed if this follows a diphthong like AW, AH
        if lastElement is DiphthongBlend {
            midFollowers = allowedVowels
        }
        else {
            midFollowers = blendInto + allowedVowels
        }
        
        if blendsWithY {
            midFollowers += [.Y]
        }
        
        if dynFollowers != nil {
            midFollowers += self.dynFollowers!(syll, .positionMIDDLE)
        }
        return midFollowers
    }
    
    func lastFollowers(syll: SyllabicArray) -> [Letter] {
        let lastElement = syll.lastElement()
        var lastFollowers: [Letter]
        
        // If following a diphthong, only allow final E
        if lastElement is DiphthongBlend {
            if allowedVowels.contains(.E) {
                lastFollowers = [.E]
            }
            else {
                lastFollowers = []
            }
        }
        else {
            lastFollowers = defFinal
        }
        if blendsWithY {
            lastFollowers += [.Y]
        }
        if canPlural {
            lastFollowers += [.S]
        }
        if dynFollowers != nil {
            lastFollowers += self.dynFollowers!(syll, .positionLAST)
        }
        return lastFollowers
    }
    
    init(id: Letter,
         blendStart: [Letter],
         blendInto: [Letter],
         defFinal: [Letter],
         hardStops: [Letter],
         allowedVowels: [Letter],
         blendsWithY: Bool,
         canStart: Bool,
         canEnd: Bool,
         canPlural: Bool,
         dipthong: Bool,
         liquidBlend: Bool,
         followerTable: [String:[Letter]],
         dynamicFollowers: ((SyllabicArray, PositionIndicator) -> [Letter])?)
    {
        self.blendStart = blendStart
        self.blendInto = blendInto
        self.defFinal = defFinal
        self.hardStops = hardStops
        self.allowedVowels = allowedVowels
        self.blendsWithY = blendsWithY
        self.dipthong = dipthong
        self.liquidBlend = liquidBlend
        self.followerTable = followerTable
        super.init(first: id, second: nil, third: nil,
                   canStart: canStart, canEnd: canEnd, canPlural: canPlural,
                   dynFollowers: dynamicFollowers)
        
        self.verifyEndOfWord = { (phonemes:PhoneticElementArray) -> Bool in return true }
    }
}

// CONSONANTS
let B = Consonant(id: .B,
                  blendStart: [.L, .R],
                  blendInto: [.B, .L, .R],
                  defFinal: [.E],
                  hardStops: [.C, .D, .F, .J, .N, .S, .T],   // ABCESS, ABDICATE, ABNEGATE, OBFUSCATE, OBJECT, OBSTRUCT, OBTAIN
                  allowedVowels: allVowels,
                  blendsWithY: true,
                  canStart: true,
                  canEnd: true,
                  canPlural: true,
                  dipthong: false,
                  liquidBlend: true,
                  followerTable: [
                    "A":[.A, .B, .D, .E, .H, .I, .L, .N, .O, .R, .U, .Y],
                    "E":[.B, .U],
                    "I":[.E, .I],
                    "O":[.D, .E, .F, .J, .L, .O, .S, .T]],          // OBOE
                  dynamicFollowers: { (syll: SyllabicArray, posIndicator: PositionIndicator) in
                        var followers: [Letter] = []
                    
                        // Allow T follower only for DEBT, DOUBT
                        if syll.matchesSet(["DE", "DOU"]) {
                            followers += [.T]
                        }
                    
                        if posIndicator == .positionLAST {
                            
                            // Approve A follower for TUBA
                            if syll.matchesString("TU", matchFull: true) {
                                followers += [.A]
                            }
                            
                            // Approve I follower for ALIBI
                            if syll.matchesString("ALI", matchFull: true) {
                                followers += [.I]
                            }
                        }
                        return followers
                    })

let C = Consonant( id: .C,
    blendStart: [.H, .L, .R],
    blendInto: [.C, .H, .K, .L, .R, .T],
    defFinal: [.E, .H, .K],
    hardStops: [.M, .N, .S],                           
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.C, .E, .H, .I, .M, .N, .O, .R, .T, .U],   // ACCOUNT, ACES, ACHE, ACID, ACME, ACNE, ACORN, ACROSS, ACTIVE, ACUTE
        "E":[.C, .O, .R, .S, .T],                   // ECCENTRIC, ECONOMY, ECRU, ECSTASY, ECTOPLASM
        "EA":[.H],                                  // EACH
        "I":[.E, .I, .O, .T],                       // ICES, ICIER, ICON, ICTHYS
        "O":[.C, .H, .R, .T, .U],                   // OCCUR, OCHRE, OCRA, OCTAGON, OCULAR
        "OU":[.H]],                                 // OUCH
    dynamicFollowers: { (syll: SyllabicArray, posIndicator: PositionIndicator) in
        var followers: [Letter] = []
        
        if posIndicator == .positionLAST {
            let lastElement = syll.lastElement()
            let prevElement = syll.nextToLastElement()
            
            // Allow final I for FOCI & LOCI
            if syll.matchesString("FO", matchFull: true) || syll.matchesString("LO", matchFull: true) {
                followers += [.I]
            }
            
            // Allow final A & O if preceding vowel is I, or (PICA/PICO or COCA/LOCO)
            if (lastElement!.id == "I" || lastElement!.id == "O") {
                followers += [.A, .O]
            }
            
            // Allow final O if preceding vowel is A (TACO)
            else if lastElement!.id == "A" {
                followers += [.O]
            }
            
            // Approve all final CT words that don't have an O or U preceder
            // (except for DUCT, want all varities like INDUCT, CONDUCT, AQUEDUCT
            if lastElement is Vowel && lastElement!.id != "O" &&
                (lastElement!.id != "U" || prevElement!.lastLetter() == .D) {
                followers += [.T]
            }
                
            // Only vowel blend with CT follower is EA (ex. REACT)
            else if lastElement is VowelBlend && lastElement!.id == "EA" {
                followers += [.T]
            }
            
        }
        return followers
    })

let D = Consonant( id: .D,
    blendStart: [.R, .W],
    blendInto: [.D, .G, .L, .R, .W],
    defFinal: [.E],
    hardStops: [.B, .F, .H, .J, .N],            // CARDBOARD, GADFLY, BLOODHOUND, GOODNESS
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: ["A":[.A, .B, .D, .E, .J, .O, .R, .U, .V, .Z],
                    "AI":[.E, .I, .S],                  // AIDE, AIDING, AIDS
                    "E":[.D, .G, .I, .U],               // EDDY, EDGE, EDIT/EDICT, EDUCATE
                    "EI":[.E],                          // EIDER
                    "I":[.E, .I, .L, .O, .Y],           // IDES, IDIOT, IDLE, IDOL, IDYL(L)
                    "O":[.D, .E, .I, .O],               // ODDS, ODES, ODIOUS, ODOR/ODOMETER
                    "U":[.D]],                          // UDDER
    dynamicFollowers: { (syll: SyllabicArray, posIndicator: PositionIndicator) in
        var followers:[Letter] = []
        

        if posIndicator == .positionLAST {
            
            // Allow final A for CODA, SODA
            if syll.matchesSet(["CO", "SO"]) {
                followers += [.A]
            }
            
            // Allow final I for WADI
            if syll.matchesString("WA", matchFull: true) {
                followers += [.I]
            }
            
            // Approve final O for DADO, KUDO, LIDO, REDO, UNDO, OUTDO
            if syll.matchesSet(["DA", "KU", "LI", "RE", "UN", "OUT"]) {
                followers += [.O]
            }
            
            // Approve final A for CICADA
            if syll.matchesSet(["CICA"]) {
                followers += [.A]
            }
        }

        return followers
    })

let F = Consonant( id: .F,
    blendStart: [.L, .R],
    blendInto: [.F, .R, .T],            // do we need L here for WAFFLE?
    defFinal: [.E, .F, .T],
    hardStops: [.B, .H, .S],            // OFFBEAT, OFFHAND, OFFSITE
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.A, .F, .I, .L, .O, .R, .T],   // AFAR, AFFABLE, AFIRE, AFLAME, AFOOT, AFRAID, AFTER
        "E":[.F],                           // EFFECT
        "I":[.F],                           // IFFY
        "O":[.F, .T],                       // OFFING, OFTEN
        "OA":[.S]],                         // OAFS
    dynamicFollowers: { (syll: SyllabicArray, posIndicator: PositionIndicator) in
        var followers:[Letter] = []
        
        if posIndicator == .positionLAST {
            
            // Approve final A for SOFA
            if syll.matchesString("SO", matchFull: true) {
                followers += [.A]
            }
            
            // Allow final U for SNAFU, TOFU
            if syll.matchesString("SNA", matchFull: true) || syll.matchesString("TO", matchFull: true) {
                followers += [.U]
            }
        }
        
        return followers
    })

let G = Consonant( id: .G,
    blendStart: [.L, .N, .R],
    blendInto: [.G, .L, .N, .R],
    defFinal: [.E],
    hardStops: [.M],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.A, .E, .G, .H, .L, .I, .O, .R, .U],
        "AE":[.I],              // AEGIS
        "AU":[.E],              // AUGER
        "E":[.A, .G, .O, .R],   // EGAD, EGGS, EGOS, EGRET
        "EA":[.E, .L],          // EAGER, EAGLE
        "EI":[.H],              // EIGHT
        "I":[.L, .N],           // IGLOO, IGNORE
        "O":[.D, .L, .R],       // OGDEN, OGLE, OGRE
        "U":[.G]],              // UGLY
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = syll.lastElement()
        let prevElement = syll.nextToLastElement()      // assuming this will be not be nil

        // GH followers: I (NIGH), EI (WEIGH), AU (CAUGHT), OU (COUGH)
        if lastElement!.id == "I" || lastElement!.id == "EI" || lastElement!.id == "AU" || lastElement!.id == "OU" {
            followers += [.H]
        }
        
        // GN followers for I vowel: ALIGN, ASSIGN, SIGN, DESIGN, RESIGN, BENIGN, DIGNIFY
        if lastElement!.id == "I" &&
            (prevElement!.id == "D" || prevElement!.id == "L" || prevElement!.id == "N" ||
                prevElement!.id == "S" || prevElement!.id == "SS") {
            followers += [.N]
        }
            
        // GN followers for EI blend: DEIGN, REIGN, FEIGN, PEIGNOIR
        else if lastElement!.id == "EI" &&
            (prevElement!.id == "D" || prevElement!.id == "F" || prevElement!.id == "R" || prevElement!.id == "P") {
            followers += [.N]
        }
        
        // GN followers for U vowel: IMPUGN
        else if lastElement!.id == "U" && prevElement!.id == "P" {
            followers += [.N]
        }
        
        if pos == .positionLAST {
            
            // Approve final followers for YOGA, YOGI
            if syll.matchesString("YO", matchFull: true) {
                followers += [.A, .I]
            }
            
            // If preceding vowel is A or O, then allow both A & O to follow at the end (SAGO, SAGA, LOGO, TOGA)
            if syll.lastElement()!.id == "A" || syll.lastElement()!.id == "O" {
                followers += [.A, .O]
            }
        }
        
        return followers
    })

let H = Consonant( id: .H,
    blendStart: [],
    blendInto: [.M, .R, .T],                      // M blend only for OHM
    defFinal: [.M, .N, .T],                       // JOHN, may need other blends with L, R
    hardStops: [.B, .D, .F, .H, .L, .M, .S],      // DASHBOARD, WITHDRAWN, MOUTHFUL, WITHHOLD, ASTHMA, RICHLY, WITHSTOOD
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: true,
    liquidBlend: false,
    followerTable: [:],          // no vowels here since this is a diphthong
    dynamicFollowers: nil)

let J = Consonant( id: .J,
    blendStart: [],
    blendInto: [],
    defFinal: [.A, .O, .J],             // RAJA, BANJO, HAJJ?
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: false,
    canStart: true,
    canEnd: false,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A],           // AJAR
        "E":[.A, .E]],      // EJACULATE, EJECT
    dynamicFollowers: nil)

let K = Consonant( id: .K,
    blendStart: [.L, .N, .R],
    blendInto: [.L, .N, .R],
    defFinal: [.E],
    hardStops: [.M, .W],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.I],       // AKIN
        "E":[.E],       // EKES/EKED
        "I":[.O],       // IKON (yes)
        "O":[.A, .R],   // OKAY, OKRA
        "OA":[.E, .S],  // OAKEN, OAKS
        "U":[.E]],      // UKELELE
    dynamicFollowers: { (syll: SyllabicArray, posIndicator: PositionIndicator) in
    
        if posIndicator == .positionLAST {
            
            // Allow final U for HAIKU
            if syll.matchesString("HAI", matchFull: true)  {
                return [.U]
            }
            
            // Allow final I for RAKI, SAKI
            else if syll.matchesSet(["RA", "SA"]) {
                return [.I]
            }
            
            // Allow final O for SHAKO
            else if syll.matchesString("SHA", matchFull: true)  {
                return [.O]
            }
            
            // final A's?
            else {
                return []
            }
        }
        else {
            return []
        }
    })

let L = Consonant( id: .L,
    blendStart: [.L],                   // only for LLAMA
    blendInto: [.B, .C, .D, .F, .G, .K, .L, .M, .P, .S, .T, .V],
    defFinal: [.E, .F, .K, .L, .M, .T],
    hardStops: [.N],                    // ULNA
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .B, .D, .E, .G, .I, .K, .L, .M, .O, .P, .S, .T, .U, .V, .W],
        "AI":[.E, .I, .S],
        "AW":[.S],
        "E":[.A, .B, .D, .E, .F, .G, .I, .K, .L, .M, .O, .P, .S, .T, .U, .V],
        "EE":[.S, .Y],                      // EELS, EELY
        "I":[.I, .K, .L],                   // ILIA, ILKS, ILLS
        "O":[.D, .E, .F, .I, .L],           // OLDER, OLEANDER, OLFACTORY, OLIO, OLLA
        "OI":[.E, .I, .S, .Y],              // OILED, OILING, OILS, OILY
        "U":[.C, .N, .S, .T]],
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers:[Letter] = []
        
        if pos == .positionLAST {
            let lastElement = syll.lastElement()
            let prevElement = syll.nextToLastElement()
            
            // Only allow LC blend at end for TALC and A follower for TALA
            if syll.matchesString("TA", matchFull: true) {
                followers += [.A, .C]
            }
            
            // Other A followers: COLA, GALA, VIOLA and any BOLA (EBOLA, PARABOLA, HYPERBOLA), NILA (MANILA, VANILLA)
            if syll.matchesSet(["CO", "GA", "VIO"]) ||
                (lastElement!.id == "O" && prevElement!.lastLetter() == .B) ||
                (lastElement!.id == "I" && prevElement!.lastLetter() == .N) {
                followers += [.A]
            }
            
            // Approve LB ending for BULB
            if syll.matchesString("BU", matchFull: true) {
                followers += [.B]
            }

            // Approve LD ending for all single vowel preceders and OU (COULD/WOULD), IE (FIELD/YIELD), UI (BUILD, GUILD)
            if lastElement is Vowel || lastElement!.id == "OU" || lastElement!.id == "IE" || lastElement!.id == "UI" {
                followers += [.D]
            }
            
            // Approve final I for DELI, SOLI
            if syll.matchesSet(["DE", "SO"]) {
                followers += [.I]
            }
            
            // Approve final O for HALO, KILO, SILO, SOLO
            if syll.matchesSet(["HA", "KI", "SO", "SI"]) {
                followers += [.O]
            }
            
            // Final LP words: HELP, KELP, WHELP, YELP, GULP, PULP
            if syll.matchesSet(["HE", "KE", "WHE", "YE", "GU", "PU"]) {
                followers += [.P]
            }
        }
        
        // Only allow LN blend for KILN
        if syll.matchesString("KI", matchFull: true) {
            followers += [.N]
        }

        return followers
    })

let M = Consonant( id: .M,
    blendStart: [],
    blendInto: [.B, .M, .P],
    defFinal: [.B, .E, .O, .P],
    hardStops: [.H, .L, .N],                     // HAMLET, OMNIBUS
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .B, .E, .H, .I, .M, .O, .P, .U, .Y],
        "AI":[.E, .I, .S],
        "E":[.A, .B, .C, .E, .I, .M, .O, .P, .U],
        "I":[.A, .B, .I, .M, .P],
        "O":[.E, .I, .N],
        "OH":[.S],
        "U":[.B]],
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            let lastElement = syll.lastElement()
            
            // Final A words: LIMA, MAMA, COMA, MELANOMA, MAGMA, PUMA
            if lastElement!.id == "A" || lastElement!.id == "I" || lastElement!.id == "O" ||
                syll.matchesSet(["MAG", "PU"]) {
                followers += [.A]
            }
            
            // Allow final I for SALAMI, SEMI & SWAMI
            if syll.matchesSet(["SALA", "SE", "SWA"]) {
                followers += [.I]
            }
        }
        
        // Allow N follower for AUTUMN, COLUMN, DAMN, SOLEMN
        if syll.matchesSet(["AUTU", "COLU", "DA", "SOLE"]) {
            followers += [.N]
        }
        
        return followers
    })

let N = Consonant( id: .N,
    blendStart: [.Y],
    blendInto: [.C, .D, .K, .N, .Q, .S, .T],
    defFinal: [.E, .K],

    // INBRED, INFER, BANJO, INLET, INMATE, INPUT, UNRIG, INVITE, ENZYME, WAINWRIGHT
    hardStops: [.B, .F, .G, .J, .L, .M, .P, .R, .V, .W, .Z],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .C, .D, .G, .E, .I, .K, .N, .O, .S, .T, .U, .V, .Y],
        "AW":[.I, .S],                   // AWNING, AWNS
        "E":[.A, .C, .D, .E, .G, .I, .J, .L, .M, .N, .O, .S, .T, .U, .V, .Z],
        "EO":[.S],                       // EONS
        "EU":[.U],                       // EUNUCH
        "I":[.A, .C, .D, .E, .F, .G, .I, .J, .K, .L, .N, .O, .P, .Q, .S, .T, .U, .V],
        "IO":[.S],                       // IONS
        "O":[.C, .E, .L, .S, .T, .U],    // ONCE, ONES, ONLY, ONSET, ONTO, ONUS
        "OE":[.O],                       // OENOPHILE
        "OU":[.C],                       // OUNCE
        "OW":[.E, .I, .S],               // OWNER, OWNING, OWNS
        "U":[.A, .B, .C, .D, .E, .F, .G, .H, .I, .K, .L, .M, .N, .O, .P, .R, .S, .T, .U, .V, .W, .Y, .Z]],
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = syll.lastElement()
        
        if pos == .positionLAST {
                
            // Final A after vowels E (ARENA, HYENA), I (CHINA, VINA, PATINA), O (KONA, CORONA), AU (FAUNA, SAUNA), and Y (MYNA)
            if lastElement!.id == "E" || lastElement!.id == "I" || lastElement!.id == "O" ||
                lastElement!.id == "AU" || lastElement!.id == "Y" {
                followers += [.A]
            }
            
            // Only NC ender is ZINC
            if syll.matchesSet(["ZI"]) {
                followers += [.C]
            }
            
            // Final D's for all vowels plus IE for FIEND, FRIEND
            if lastElement is Vowel || lastElement!.id == "IE" {
                followers += [.D]
            }

            // Approve final I for MINI, RANI
            if syll.matchesSet(["MI", "RA"]) {
                followers += [.I]
            }
            
            // Only allow final NN for INN & CONN
            if syll.matchesSet(["I", "CO"]) {
                followers += [.N]
            }

            // Approve final O for words like VOLCANO, KENO, ALBINO, CASINO, MONO, PIANO, VINO
            if lastElement!.id != "U" {
                followers += [.O]
            }
            
            // Approve final NT for all regular vowels plus these blends
            // ex. PANT, RENT, PINT, FONT, BUNT, PAINT, FEINT, POINT, GIANT, GRADIENT, COUNT, TRUANT, FLUENT, LEANT
            if lastElement is Vowel ||
                (lastElement!.id == "AI" || lastElement!.id == "EI" || lastElement!.id == "OI" ||
                 lastElement!.id == "IA" || lastElement!.id == "IE" || lastElement!.id == "OU" ||
                 lastElement!.id == "UA" || lastElement!.id == "UE" || lastElement!.id == "EA") {
                followers += [.T]
            }
            
            // U follower for MENU
            if syll.matchesString("ME", matchFull: true) {
                followers += [.U]
            }
        }
        
        // Approve G followers for any preceding vowels, and for certain blends using EI, II, OI, UI
        if lastElement is Vowel ||
                (lastElement!.id == "EI" && syll.matchesSet(["ANTEI", "BEI"])) ||           // ANTEING, BEING
                (lastElement!.id == "II" && syll.matchesSet(["SKII", "TAXII"])) ||          // SKIING, TAXIING
                (lastElement!.id == "OI" && syll.matchesSet(["BOI", "DOI", "GOI"])) ||      // BOING, DOING, GOING
                (lastElement!.id == "UI" && syll.matchesSet(["ENSUI", "IMBUI", "RUI", "SUI", "TRUI"])) {
                                                                                    // ENSUING, IMBUING, RUING, SUING, TRUING
            followers += [.G]
            }

        return followers
    })

let P = Consonant( id: .P,
    blendStart: [.H, .L, .R, .S],
    blendInto: [.P, .H, .L, .S, .T],
    defFinal: [.E, .H],
    hardStops: [.D, .F],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.A, .E, .H, .I, .L, .N, .O, .P, .R, .S, .T, .U],
        "E":[.A, .H, .I, .S],
        "O":[.A, .E, .I, .P, .T, .U],
        "OO":[.S],
        "U":[.B, .D, .E, .L, .O, .R, .S, .T, .V]],
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Approve final T for KEPT, LEAPT, RAPT, WEPT, INAPT, INEPT
            if syll.matchesSet(["ERU", "INA", "INE", "KE", "LEA", "RA", "WE"]) {
                followers += [.T]
            }
            
            // Approve final O for CAPO
            if syll.matchesSet(["CA"]) {
                followers += [.O]
            }
        }
        
        // T follower anywhere for ERUPT
        if syll.matchesSet(["ERU"]) {
            followers += [.T]
        }
        
        return followers
    })

let Q = Consonant( id: .Q,
    blendStart: [],
    blendInto: [],
    defFinal: [],
    hardStops: [],
    allowedVowels: [.U],
    blendsWithY: false,
    canStart: true,
    canEnd: false,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    followerTable: ["A":[.U], "E":[.U]],
    dynamicFollowers: nil)

let R = Consonant( id: .R,
    blendStart: [.H],                       // RH can only generate Y followers, ex. RHYME, RHYTHM
    blendInto: [.B, .C, .D, .F, .G, .H, .K, .L, .M, .N, .P, .R, .S, .T, .V],
    defFinal: [.E, .K, .M, .N, .P, .T],
    hardStops: [.W],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .B, .C, .D, .E, .F, .G, .I, .K, .L, .M, .O, .P, .R, .S, .T, .U],
        "AA":[.D],                                  // AARDVARK
        "AE":[.A, .I, .O],                          // AERATE, AERIE, AEROBIC
        "AI":[.E, .I, .S, .Y],                      // AIRED, AIRING, AIRS, AIRY
        "AO":[.T],                                  // AORTA(L)
        "AU":[.A, .O],                              // AURA, AURORA
        "E":[.A, .E, .G, .I, .O, .R, .S, .U],       // ERASE, ERECT, ERGS, ERIN, EROTIC, ERRS, ERST, ERUPT
        "EA":[.G, .L, .N, .S, .T],                  // EAGER, EARL, EARN, EARS, EARTH
        "EE":[.I],                                  // EERIE
        "I":[.A, .E, .I, .K, .O, .R],               // IRATE, IRES, IRIDESCENT, IRKS, IRON, IRRITATE
        "O":[.A, .B, .C, .D, .E, .G, .I, .N, .P],   // ORANGE, ORBS, ORCA, ORDER, ORES, ORGAN, ORIGIN, ORNATE, ORPHAN
        "OA":[.E, .I, .S],                          // OARED, OARING, OARS
        "OU":[.S],                                  // OURS
        "U":[.A, .E, .G, .I, .N, .O, .S, .U]],      // URANUS, UREA, URGE, URIC/URINE, URNS, UROLOGY, URSING, URSU?
    
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = syll.lastElement()
        
        if pos == .positionLAST {
            
            // Approve final A for LIRA, TIARA, OPERA, SERA, others?
            if syll.matchesSet(["LI", "TIA", "OPE", "SE"]) {
                followers += [.A]
            }
            
            // Final RB words: ADVERB, BARB, BLURB, CARB, CURB, DISTURB, GARB, HERB, VERB
            if syll.matchesSet(["ADVE", "BA", "BLU", "CA", "CU", "DISTU", "GA", "HE", "VE"]) {
                followers += [.B]
            }
            
            // Approve RD blend for any preceding single vowels
            // also for vowel blends: EA (BEARD), EI (WEIRD), IO (FIORD), OA (BOARD), OU (GOURD)
            if lastElement is Vowel ||
                (lastElement!.id == "EA" || lastElement!.id == "EI" || lastElement!.id == "IO" ||
                 lastElement!.id == "OA" || lastElement!.id == "OU") {
                followers += [.D]
            }
            
            // Final RF words: BARF, NERF, SCARF, SERF, SMURF, SURF, TURF
            if syll.matchesSet(["BA", "NE", "SCA", "SE", "SMU", "SU", "TU"]) {
                followers += [.F]
            }
            
            // Final RG words: BERG, BORG, BURG
            if syll.matchesSet(["BE", "BO", "BU"]) {
                followers += [.G]
            }
            
            // Final RL words: GIRL, GNARL, FURL, CURL, WHORL, PEARL
            if syll.matchesSet(["CU", "FU", "GI", "GNA", "PEA", "WHO"]) {
                followers += [.L]
            }
            
            // Allow final I for SAFARI, SARI, SORI, TORI
            if syll.matchesSet(["SA", "SAFA", "SO", "TO"]) {
                followers += [.I]
            }
            
            // Final RO words incude: TARO, HERO, TORO
            if lastElement!.id == "A" || lastElement!.id == "E" || lastElement!.id == "O" {
                followers += [.O]
            }
            
            // Final RR words: BURR, PURR, WHIRR
            if syll.matchesSet(["BU", "PU", "WHI"]) {
                followers += [.R]
            }
        }
        
        else {
            
            // Middle RG blend allowed after any vowel (except I) and after OU (SCOURGE)
            if (lastElement is Vowel && lastElement!.id != "I") || lastElement!.id == "OU" {
                followers += [.G]
            }
        }

        return followers
    })

let S = Consonant(id: .S,
    blendStart: [.C, .H, .K, .L, .M, .N, .P, .Q, .T, .W],
    blendInto: [.C, .H, .K, .L, .M, .N, .P, .Q, .S, .T, .W],
    defFinal: [.E, .H, .K, .T],
    hardStops: [.D, .F],                    // MISDIAL, MISFIT
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.B, .C, .G, .H, .I, .K, .L, .P, .S, .T, .W],
        "AI":[.L],
        "E":[.C, .H, .P, .Q, .S, .T],
        "EA":[.E, .I, .T, .Y],              // EASE(L), EASILY, EAST, EASY
        "I":[.L, .S],
        "O":[.I, .P, .S],                   // OSIER, OSPREY, OSSIFY
        "OA":[.E, .I, .T],                  // OASES, OASIS, OAST
        "OU":[.T],                          // OUST
        "U":[.A, .E, .H, .I, .U]],          // USABLE, USED, USHER, USING, USUAL
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = syll.lastElement()
        
        if pos == .positionLAST {
            let lastElement = syll.lastElement()
            
            // Approve A follower for MESA
            if syll.matchesSet(["ME"]) {
                followers += [.A]
            }
            
            // Approve C follower for DISC
            if syll.matchesSet(["DI"]) {
                followers += [.C]
            }
            
            // Approve SM enders for all ISM combinations and for ASM (CHASM/ORGASM/PHANTASM)
            if lastElement!.id == "A" || lastElement!.id == "I" ||
                lastElement!.id == "EI" || lastElement!.id == "OI" || lastElement!.id == "UI" {
                followers += [.M]
            }
            
            // Approve O follower for MISO, PESO
            if syll.matchesSet(["MI", "PE"]) {
                followers += [.O]
            }
            
            // Final SP words: CLASP, CRISP, HASP, LISP, WASP, WISP
            if syll.matchesSet(["CLA", "CRI", "HA", "LI", "WA", "WI"]) {
                followers += [.P]
            }
                
            // Approve SS ender for any vowel and for GUESS
            if lastElement is Vowel || syll.matchesString("GUE", matchFull: true) {
                followers += [.S]
            }
        }
        return followers
    })

let T = Consonant( id: .T,
    blendStart: [.H, .R, .S, .W, .Y],
    blendInto: [.C, .H, .L, .R, .T, .Z],
    defFinal: [.E, .H],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.L, .O, .R, .T],           // ATLAS, ATONE, ATRIA, ATTEST
        "AU":[.H, .O],                  // AUTHOR/AUTHENTIC, AUTO
        "E":[.C, .H, .N],               // ETCH, ETHER, ETNA,
        "EA":[.E, .I, .S],              // EATEN, EATING, EATS
        "EU":[.H],                      // EUTHENIZE
        "I":[.A, .C, .E, .I, .S, .T],   // ITALIC, ITCH, ITEM, ITINERANT, ITSY, ITTY
        "IO":[.A],                      // IOTA
        "O":[.H, .I, .T],               // OTHER, OTIC, OTTER
        "OA":[.E, .H, .S],              // OATEN, OATH, OATS
        "OU":[.S],                      // OUTS
        "U":[.T]],                      // UTTER
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Final A followers: BETA, SETA, ERRATA
            if syll.matchesSet(["BE", "SE", "ERRA"]) {
                followers += [.A]
            }
            
            // Approve I follower for COATI, SATI, YETI
            if syll.matchesSet(["COA", "SA", "YE"]) {
                followers += [.I]
            }
            
            // Approve A follower for PITA
            if syll.matchesSet(["PI"]) {
                followers += [.A]
            }
            
            // Approve O follower for VETO
            if syll.matchesSet(["VE"]) {
                followers += [.O]
            }
            
            // Final TT words: BUTT, MATT, MITT, MUTT, SETT, WATT
            if syll.matchesSet(["BU", "MA", "MI", "MU", "SE", "WA"]) {
                followers += [.T]
            }
            
            // Final TZ words: BLITZ, DITZ, FRITZ, LUTZ, PUTZ, RITZ
            if syll.matchesSet(["BLI", "DI", "FRI", "LU", "PU", "RI"]) {
                followers += [.Z]
            }
        }
        
        return followers
    })

let V = Consonant( id: .V,
    blendStart: [],
    blendInto: [],
    defFinal: [.E],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: false,
    canPlural: false,
    dipthong: false,
    liquidBlend: false,
    followerTable: [
        "A":[.A, .E, .I, .O, .U],   // AVAIL, AVER, AVID, AVOCATION, AVUNCULAR
        "E":[.A, .E, .I, .O],       // EVACUATE, EVES, EVIDENT, EVOKE
        "EA":[.E],                  // EAVES
        "I":[.E, .I, .O],           // IVES, IVIED, IVORY
        "O":[.A, .E, .I, .O],       // OVATION, OVER, OVIATE, OVOID
        "U":[.U]],                  // UVULA
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            let lastElement = syll.lastElement()
            
            // Approve final A for LAVA, CAVA, DIVA, NOVA etc.
            if syll.matchesSet(["CA", "DI", "LA", "NO"]) {
                followers += [.A]
            }
            
            // Approve final O for BRAVO
            if syll.matchesSet(["BRA"]) {
                followers += [.O]
            }
        }
        return followers
    })

let W = Consonant( id: .W,
    blendStart: [.H, .R],
    blendInto: [.D, .H, .K, .L, .N, .R, .S, .T],
    defFinal: [.D, .K, .L, .N, .T],         // LEWD, HAWK, HOWL, SOWN, NEWT
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: true,
    liquidBlend: false,
    followerTable: [:],         // no vowels since this is a diphthong
    dynamicFollowers: nil)

let X = Consonant( id: .X,
    blendStart: [],
    blendInto: [.A, .C, .E, .I, .O, .P, .T, .U],    // EXACT, EXCEL, EXIST, TAXONOMY, EXPEL, EXTENT, EXULT
    defFinal: [],
    hardStops: [],
    allowedVowels: [],
    blendsWithY: true,
    canStart: false,
    canEnd: true,
    canPlural: false,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.E, .I, .L, .O],
        "E":[.A, .C, .E, .I, .O, .P, .T, .U],
        "O":[.E, .I, .T, .Y]],
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        // Allow I follower for TAXI
        if syll.matchesString("TA", matchFull: true)  {
            followers += [.I]
        }
            
        // Allow final T only for NEXT, SEXT, TEXT
        if syll.matchesSet(["NE", "SE", "TE"]) {
            followers += [.T]
        }
        
        return followers
    })

let Y = Consonant( id: .Y,
    blendStart: [],
    blendInto: [.L, .M, .N, .R, .S, .T],
    defFinal: [],
    hardStops: [.C, .D, .P, .V, .W],
    allowedVowels: allVowels,
    blendsWithY: false,
    canStart: true,
    canEnd: true,
    canPlural: false,
    dipthong: true,
    liquidBlend: true,
    followerTable: [
        "B":[.E, .P, .S, .T, .Z],   // BYES, BYPASS, BYSTANDER, BYTE, BYZANTINE
        "C":[.A, .B, .C, .G, .P, .S, .T],   // CYANIDE, CYBER, CYCLE, CYGNET, CYPHER, CYST, CYTOSIS
        "CHR":[.S],                 // CHRYSALIS/CHRYSANTHEMUM
        "CR":[.I],                  // CRYING
        "D":[.E, .I, .N, .S],       // DYES, DYING, DYSTOPIA, DYNOMITE
        "DR":[.E, .I, .S],          // DRYING, DRYER, DRYS
        "FL":[.I],                  // FLYING
        "FR":[.E, .I],              // FRYER, FRYING
        "G":[.M, .N, .P, .R],       // GYMS, GYNECOLOGY, GYPSY, GYRO
        "GL":[.P],                  // GLYPH
        "GR":[.P],                  // GRYPHON
        "H":[.A, .E, .M, .P],       // HYACINTH, HYENA, HYMN, HYSTERIA, HYPER
        "L":[.E, .I, .M, .N, .R],   // LYES, LYING, LYME, LYNCH, LYRIC
        "M":[.N, .O, .R, .S],       // MYNA, MYOPIA, MYRRH/MYRTLE, MYSTERY
        "N":[.L],                   // NYLON
        "P":[.L, .R, .T],           // PYLON, PYROTECHNIC/PYRRIC?, PYTHON
        "PH":[.L],                  // PHYLUM
        "PHR":[.G],                 // PHRYGIAN
        "PR":[.I],                  // PRYING
        "PS":[.C],                  // PSYCHO
        "R":[.E],                   // RYES
        "RH":[.M, .T],              // RHYME, RHYTHM
        "S":[.C, .L, .M, .N, .P, .R, .S],   // SYCOPHANT, SYLLABUS, SYMBOL, SYNERGY, SYPHILIS, SYRUP, SYSTEM
        "SC":[.T],                  // SCYTHE
        "SH":[.E, .I, .L],          // SHYER, SHYING, SHYLY
        "SL":[.E, .I, .L],          // SLYER, SLYING, SLYLY
        "SP":[.I],                  // SPYING
        "ST":[.E, .M, .R],          // STYE, STYMIE, STYROFOAM
        "T":[.I, .P, .R],           // TYING, TYPE, TYRANT
        "TH":[.M],                  // THYME
        "TR":[.I, .S],              // TRYING
        "V":[.I],                   // VYING
        "W":[.V],                   // WYVERN
        "Z":[.G]],                  // ZYGOTE
        
    dynamicFollowers: { (syll: SyllabicArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = syll.lastElement()
        let prevElement = syll.nextToLastElement()    // assuming will be non-nil
        
        if pos == .positionLAST {
            
            // Approve final L for BERYL, IDYL, VINYL
            if syll.matchesSet(["BER", "ID", "VIN"]) {
                followers += [.L]
            }
            
            // Approve final M for ANTONYM, SYNONYM
            if lastElement!.id == "N" && prevElement!.id == "O" {
                followers += [.M]
            }
            
            // Approve final O for YOYO
            if syll.matchesString("YO", matchFull: true) {
                followers += [.O]
            }
            
            // Approve final R for MARTYR, SATYR
            if syll.matchesSet(["MART", "SAT"]) {
                followers += [.R]
            }
            
        }
        return followers
    })

let Z = Consonant( id: .Z,
    blendStart: [],
    blendInto: [.Z],
    defFinal: [.A, .E, .Z],
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: false,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.I, .U],       // AZIMUTH, AZURE
        "E":[.R],           // EZRA
        "OO":[.E],          // OOZE
        "OU":[.O]],         // OUZO
    dynamicFollowers: nil)

let consonantMap: [Letter:Consonant] = [.B:B, .C:C, .D:D, .F:F, .G:G, .H:H, .J:J, .K:K, .L:L, .M:M, .N:N,
                                        .P:P, .Q:Q, .R:R, .S:S, .T:T, .V:V, .W:W, .X:X, .Y:Y, .Z:Z]
