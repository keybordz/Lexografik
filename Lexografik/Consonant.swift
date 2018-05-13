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
        let lastElement = pea.lastElement()
        var midFollowers: [Letter]
        
        // Only vowels allowed if this follows a diphthong like AW, AH
        if lastElement is DiphthongBlend {
            midFollowers = allowedVowels
        }
        else {
            midFollowers = blendInto + allowedVowels + hardStops
        }
        
        if blendsWithY {
            midFollowers += [.Y]
        }
        
        if dynFollowers != nil {
            midFollowers += self.dynFollowers!(pea, .positionMIDDLE)
        }
        return midFollowers
    }
    
    func lastFollowers(pea: PhoneticElementArray) -> [Letter] {
        let lastElement = pea.lastElement()
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
            lastFollowers += self.dynFollowers!(pea, .positionLAST)
        }
        return lastFollowers
    }
    
    func verifyFinal(pea: PhoneticElementArray) -> Bool {
        return true;
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
         dynamicFollowers: ((PhoneticElementArray, PositionIndicator) -> [Letter])?)
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
        self.verifyPlural = { (phonemes:PhoneticElementArray) -> Bool in return canPlural }
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
                    "O":[.D, .E, .F, .J, .L, .S, .T]],
                  dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
                    
                        // Allow T follower only for DEBT, DOUBT
                        if phonemes.matchesSet(["DE", "DOU"]) {
                            return [.T]
                        }
                    
                        // Allow final I for ALIBI
                        else if posIndicator == .positionLAST && phonemes.matchesString("ALI", matchFull: true) {
                            return [.I]
                        }
                            
                        else {
                            return []
                        }
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
        "A":[.C, .E, .H, .I, .M, .N, .O, .R, .T],   // ACCOUNT, ACES, ACHE, ACID, ACME, ACNE, ACORN, ACROSS, ACTIVE
        "E":[.C, .O, .R, .S, .T, .U],               // ECCENTRIC, ECONOMY, ECRU, ECSTASY, ECTOPLASM, ECUMENICAL
        "EA":[.H],                                  // EACH
        "I":[.E, .I, .O, .T],                       // ICES, ICIER, ICON, ICTHYS
        "O":[.C, .H, .R, .T, .U],                   // OCCUR, OCHRE, OCRA, OCTAGON, OCULAR
        "OU":[.H]],                                 // OUCH
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        var followers: [Letter] = []
        
        if posIndicator == .positionLAST {
            let lastElement = phonemes.lastElement()
            let prevElement = phonemes.nextToLastElement()
            
            // Allow final I for FOCI & LOCI
            if phonemes.matchesString("FO", matchFull: true) || phonemes.matchesString("LO", matchFull: true) {
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
            
            // Final CT words: ASPECT, DUCT, ENACT, ERECT, PACT, REACT, SECT, TACT, TRACT, plus OVERACT?
            if phonemes.matchesSet(["ASPE", "DU", "ENA", "ERE", "PA", "REA", "SE", "TA", "TRA"]) ||
                (lastElement!.id == "A" && prevElement!.id == "R") {
                followers += [.T]
            }
            
        }
        return followers
    })

let D = Consonant( id: .D,
    blendStart: [.R],
    blendInto: [.D, .G, .J, .L, .R],
    defFinal: [.E],
    hardStops: [.B, .F, .H, .N],            // CARDBOARD, GADFLY, BLOODHOUND, GOODNESS
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
                    "I":[.E, .I, .L, .O, .Y],           // IDES, IDIOT, IDLE, IDOL, IDYL(L)
                    "O":[.D, .E, .I, .O],               // ODDS, ODES, ODIOUS, ODOR/ODOMETER
                    "U":[.D]],                          // UDDER
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        var followers:[Letter] = []
        

        if posIndicator == .positionLAST {
            
            // Allow final A for CODA, SODA
            if phonemes.matchesSet(["CO", "SO"]) {
                followers += [.A]
            }
            
            // Allow final I for WADI
            if phonemes.matchesString("WA", matchFull: true) {
                followers += [.I]
            }
            
            // Approve final O for KUDO, LIDO, REDO, UNDO, OUTDO
            if phonemes.matchesSet(["KU", "LI", "RE", "UN", "OUT"]) {
                followers += [.O]
            }
            
            // Approve final A for CICADA
            if phonemes.matchesSet(["CICA"]) {
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
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
        var followers:[Letter] = []
        
        // Allow final U for SNAFU, TOFU
        if posIndicator == .positionLAST {
            
            if phonemes.matchesString("SNA", matchFull: true) || phonemes.matchesString("TO", matchFull: true) {
                followers += [.U]
            }
        }
        
        return followers
    })

let G = Consonant( id: .G,
    blendStart: [.L, .N, .R],
    blendInto: [.G],
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
        "A":[.A, .E, .G, .L, .I, .O, .R, .U],
        "AE":[.I],              // AEGIS
        "AU":[.E],              // AUGER
        "E":[.A, .G, .O, .R],   // EGAD, EGGS, EGOS, EGRET
        "EA":[.E],              // EAGER
        "EI":[.H],              // EIGHT
        "I":[.L],               // IGLOO
        "O":[.D, .L, .R],       // OGDEN, OGLE, OGRE
        "U":[.G]],              // UGLY
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = phonemes.lastElement()
        let prevElement = phonemes.nextToLastElement()      // assuming this will be not be nil

        // GH followers: I (NIGH), EI (WEIGH), AU (CAUGHT), OU (COUGH)
        if lastElement!.id == "I" || lastElement!.id == "EI" || lastElement!.id == "AU" || lastElement!.id == "OU" {
            followers += [.H]
        }
        
        // GN followers for I vowel: ALIGN, ASSIGN, SIGN, DESIGN, RESIGN, BENIGN
        if lastElement!.id == "I" &&
            (prevElement!.id == "L" || prevElement!.id == "N" || prevElement!.id == "S" || prevElement!.id == "SS") {
            followers += [.N]
        }
            
        // GN followers for EI blend: DEIGN, REIGN, FEIGN, PEIGNOIR
        else if lastElement!.id == "EI" &&
            (prevElement!.id == "D" || prevElement!.id == "F" || prevElement!.id == "R" || prevElement!.id == "P") {
            followers += [.N]
        }
        
        if pos == .positionLAST {
            
            // Approve final followers for YOGA, YOGI
            if phonemes.matchesString("YO", matchFull: true) {
                followers += [.A, .I]
            }
            
            // If preceding vowel is A or O, then allow both A & O to follow at the end (SAGO, SAGA, LOGO, TOGA)
            if phonemes.lastElement()!.id == "A" || phonemes.lastElement()!.id == "O" {
                followers += [.A, .O]
            }
        }
        
        return followers
    })

let H = Consonant( id: .H,
    blendStart: [],
    blendInto: [.M, .R, .T],              // M blend only for OHM
    defFinal: [.M, .N, .T],               // JOHN, may need other blends with L, R
    hardStops: [.D, .H, .S],              // WITHDRAWN, WITHHOLD, WITHSTOOD,
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
    hardStops: [],
    allowedVowels: allVowels,
    blendsWithY: true,
    canStart: true,
    canEnd: true,
    canPlural: true,
    dipthong: false,
    liquidBlend: true,
    followerTable: [
        "A":[.I],       // AKIN
        "I":[.O],       // IKON (yes)
        "O":[.A],       // OKAY
        "OA":[.E, .S],  // OAKEN, OAKS
        "U":[.E]],      // UKELELE
    dynamicFollowers: { (phonemes: PhoneticElementArray, posIndicator: PositionIndicator) in
    
        if posIndicator == .positionLAST {
            
            // Allow final U for HAIKU
            if phonemes.matchesString("HAI", matchFull: true)  {
                return [.U]
            }
            
            // Allow final I for RAKI, SAKI
            else if phonemes.matchesSet(["RA", "SA"]) {
                return [.I]
            }
            
            // Allow final O for SHAKO
            else if phonemes.matchesString("SHA", matchFull: true)  {
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
    defFinal: [.E, .F, .L, .M, .T],
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
        "I":[.I, .L],                       // ILIA, ILLS
        "O":[.D, .E, .I, .L],
        "OI":[.E, .I, .S, .Y],              // OILED, OILING, OILS, OILY
        "U":[.C, .N, .S, .T]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers:[Letter] = []
        
        if pos == .positionLAST {
            let lastElement = phonemes.lastElement()
            
            // Only allow LC blend at end for TALC and A follower for TALA
            if phonemes.matchesString("TA", matchFull: true) {
                followers += [.A, .C]
            }
            
            // Other A followers: COLA, VIOLA
            if phonemes.matchesSet(["CO", "VIO"]) {
                followers += [.A]
            }
            
            // Approve LB ending for BULB
            if phonemes.matchesString("BU", matchFull: true) {
                followers += [.B]
            }

            // Approve LD ending for all single vowel preceders and OU (COULD/WOULD), IE (FIELD/YIELD), UI (BUILD, GUILD)
            if lastElement is Vowel || lastElement!.id == "OU" || lastElement!.id == "IE" || lastElement!.id == "UI" {
                followers += [.D]
            }
            
            // Approve final I for DELI, SOLI
            if phonemes.matchesSet(["DE", "SO"]) {
                followers += [.I]
            }
            
            // Only allow LN blend at end for KILN
            if phonemes.matchesString("KI", matchFull: true) {
                followers += [.N]
            }
            
            // Approve final O for HALO, KILO, SILO, SOLO, VELO
            if phonemes.matchesSet(["HA", "KI", "SO", "SI", "VE"]) {
                followers += [.O]
            }
            
            // Final LP words: HELP, KELP, WHELP, YELP, GULP, PULP
            if phonemes.matchesSet(["HE", "KE", "WHE", "YE", "GU", "PU"]) {
                followers += [.P]
            }
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
        "I":[.A, .B, .I, .M],
        "O":[.E, .I, .N],
        "OH":[.S],
        "U":[.B]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            let lastElement = phonemes.lastElement()
            
            // Final A words: LIMA, MAMA, COMA, MELANOMA, MAGMA
            if lastElement!.id == "A" || lastElement!.id == "I" || lastElement!.id == "O" ||
                phonemes.matchesString("MAG", matchFull: true) {
                followers += [.A]
            }
            
            // Allow final I for SALAMI & SWAMI
            if phonemes.matchesSet(["SALA", "SWA"]) {
                followers += [.I]
            }
                
            // Allow N follower for AUTUMN, COLUMN, SOLEMN
            if phonemes.matchesSet(["AUTU", "COLU", "SOLE"]) {
                followers += [.N]
            }
        }

        return followers
    })

let N = Consonant( id: .N,
    blendStart: [.Y],
    blendInto: [.C, .D, .K, .N, .S, .T],
    defFinal: [.D, .E, .K],
    hardStops: [.B, .F, .J, .L, .M, .P, .R, .V, .W, .Z],   // INBRED, INFER, BANJO, INLET, INMATE, INPUT, UNRIG, INVITE, ENZYME, WAINWRIGHT
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
        "E":[.A, .C, .D, .E, .I, .L, .M, .N, .O, .S, .T, .U, .V, .Z],
        "EO":[.S],                       // EONS
        "EU":[.U],                       // EUNUCH
        "I":[.A, .C, .D, .E, .F, .G, .I, .J, .K, .L, .N, .O, .P, .S, .T, .V],
        "IO":[.S],                       // IONS
        "O":[.C, .E, .L, .S, .T, .U],    // ONCE, ONES, ONLY, ONSET, ONTO, ONUS
        "OE":[.O],                       // OENOPHILE
        "OU":[.C],                       // OUNCE
        "OW":[.E, .I, .S],               // OWNER, OWNING, OWNS
        "U":[.A, .B, .C, .D, .E, .F, .G, .H, .I, .K, .L, .M, .N, .O, .P, .R, .S, .T, .U, .V, .W, .Y, .Z]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = phonemes.lastElement()
        
        if pos == .positionLAST {
            
            // Final NA words: CORONA, HYENA, MYNA, SAUNA, VINA (might need to make this more general)
            if phonemes.matchesSet(["COR", "HYE", "MY", "SAU", "VI"]) {
                followers += [.A]
            }
            
            // Only NC ender is ZINC
            if phonemes.matchesSet(["ZI"]) {
                followers += [.C]
            }

            // Approve final I for RANI
            if phonemes.matchesString("RA", matchFull: true) {
                followers += [.I]
            }
            
            // Only allow final NN for INN & CONN
            if phonemes.matchesSet(["I", "CO"]) {
                followers += [.N]
            }

            // Approve final O for words like VOLCANO, KENO, ALBINO, CASINO, MONO, PIANO, VINO
            if lastElement!.id != "U" {
                followers += [.O]
            }
            
            // Approve final NT for all regular vowels plus these blends
            // ex. PANT, RENT, PINT, FONT, BUNT, PAINT, FEINT, POINT, GIANT, GRADIENT, COUNT, TRUANT, FLUENT
            if lastElement is Vowel ||
                (lastElement!.id == "AI" || lastElement!.id == "EI" || lastElement!.id == "OI" ||
                 lastElement!.id == "IA" || lastElement!.id == "IE" || lastElement!.id == "OU" ||
                 lastElement!.id == "UA" || lastElement!.id == "UE") {
                followers += [.T]
            }
        }
        
        // Approve G followers for any preceding vowels, and for certain blends using EI, II, OI, UI
        if lastElement is Vowel ||
                (lastElement!.id == "EI" && phonemes.matchesSet(["ANTEI", "BEI"])) ||           // ANTEING, BEING
                (lastElement!.id == "II" && phonemes.matchesSet(["SKII"])) ||                   // SKIING
                (lastElement!.id == "OI" && phonemes.matchesSet(["BOI", "DOI", "GOI"])) ||      // BOING, DOING, GOING
                (lastElement!.id == "UI" && phonemes.matchesSet(["ENSUI", "IMBUI", "RUI", "SUI"])) {  // ENSUING, IMBUING, RUING, SUING
            followers += [.G]
            }

        return followers
    })

let P = Consonant( id: .P,
    blendStart: [.H, .L, .R, .S],
    blendInto: [.P, .S, .T],
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
        "A":[.A, .E, .H, .I, .L, .N, .O, .P, .R, .S, .T, .U],
        "E":[.A, .H, .I, .S],
        "O":[.A, .E, .I, .P, .T, .U],
        "OO":[.S],
        "U":[.B, .D, .E, .L, .O, .R, .S, .T, .V]],
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        if phonemes.matchesSet(["KE", "LEA", "RA"]) {
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
    blendInto: [.B, .C, .D, .F, .H, .K, .L, .M, .N, .P, .R, .S, .T, .V],
    defFinal: [.E, .K, .M, .N, .O, .P, .T],
    hardStops: [],
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
        "AI":[.E, .S, .Y],                          // AIRE, AIRS, AIRY
        "AO":[.T],                                  // AORTA(L)
        "AU":[.A, .O],                              // AURA, AURORA
        "E":[.A, .E, .G, .I, .O, .R, .S],           // ERASE, ERECT, ERGS, ERIN, EROTIC, ERRS, ERST
        "EA":[.G, .L, .N, .S, .T],                  // EAGER, EARL, EARN, EARS, EARTH
        "EE":[.I],                                  // EERIE
        "I":[.A, .E, .I, .K, .O, .R],               // IRATE, IRES, IRIDESCENT, IRKS, IRON, IRRITATE
        "O":[.A, .B, .C, .D, .E, .G, .I, .N, .P],   // ORANGE, ORBS, ORCA, ORDER, ORES, ORGAN, ORIGIN, ORNATE, ORPHAN
        "OA":[.E, .I, .S],                          // OARED, OARING, OARS
        "OU":[.S],                                  // OURS
        "U":[.A, .E, .G, .I, .N, .O, .S, .U]],      // URANUS, UREA, URGE, URINE, URNS, UROLOGY, URSING, URSU?
    
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = phonemes.lastElement()
        
        if pos == .positionLAST {
            
            // Approve final A for LIRA, TIARA, others?
            if phonemes.matchesSet(["LI", "TIA"]) {
                followers += [.A]
            }
            
            // Final RB words: ADVERB, BARB, BLURB, CARB, CURB, DISTURB, GARB, HERB, VERB
            if phonemes.matchesSet(["ADVE", "BA", "BLU", "CA", "CU", "DISTU", "GA", "HE", "VE"]) {
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
            if phonemes.matchesSet(["BA", "NE", "SCA", "SE", "SMU", "SU", "TU"]) {
                followers += [.F]
            }
            
            // Final RG words: BERG, BORG, BURG
            if phonemes.matchesSet(["BE", "BO", "BU"]) {
                followers += [.G]
            }
            
            // Final RL words: GIRL, CURL, WHORL, PEARL
            if (lastElement is Vowel && (lastElement!.id == "I" || lastElement!.id == "O" || lastElement!.id == "U")) ||
                (lastElement! is VowelBlend && lastElement!.id == "EA") {
                followers += [.L]
            }
            
            // Allow final I for SAFARI, SARI, TORI
            if phonemes.matchesSet(["SA", "SAFA", "TO"]) {
                followers += [.I]
            }
            
            // Final RO words incude: TARO, HERO, TORO
            if lastElement!.id == "A" || lastElement!.id == "E" || lastElement!.id == "O" {
                followers += [.O]
            }
            
            // Final RR words: BURR, PURR, WHIRR
            if phonemes.matchesSet(["BU", "PU", "WHI"]) {
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
    hardStops: [],
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
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = phonemes.lastElement()
        
        if pos == .positionLAST {
            let lastElement = phonemes.lastElement()
            
            // Approve A follower for MESA
            if phonemes.matchesSet(["ME"]) {
                followers += [.A]
            }
            
            // Approve C follower for DISC
            if phonemes.matchesSet(["DI"]) {
                followers += [.C]
            }
            
            // Approve SM enders for all ISM combinations and for ASM (CHASM/ORGASM/PHANTASM)
            if lastElement!.id == "A" || lastElement!.id == "I" ||
                lastElement!.id == "EI" || lastElement!.id == "OI" || lastElement!.id == "UI" {
                followers += [.M]
            }
            
            // Approve O follower for PESO
            if phonemes.matchesSet(["PE"]) {
                followers += [.O]
            }
            
            // Final SP words: CLASP, CRISP, HASP, LISP, WASP, WISP
            if phonemes.matchesSet(["CLA", "CRI", "HA", "LI", "WA", "WI"]) {
                followers += [.P]
            }
                
            // Approve SS ender for any vowel and for GUESS
            if lastElement is Vowel || phonemes.matchesString("GUE", matchFull: true) {
                followers += [.S]
            }
        }
        return followers
    })

let T = Consonant( id: .T,
    blendStart: [.H, .R, .W, .Y],
    blendInto: [.C, .H, .R, .T, .Z],
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
        "A":[.E, .L, .O, .R, .T],       // ATENUATE, ATLAS, ATONE, ATRIA, ATTEST
        "AU":[.H],                      // AUTHOR/AUTHENTIC
        "E":[.C, .H, .N],               // ETCH, ETHER, ETNA,
        "EA":[.E, .I, .S],              // EATEN, EATING, EATS
        "EU":[.H],                      // EUTHENIZE
        "I":[.A, .C, .E, .I, .S, .T],   // ITALIC, ITCH, ITEM, ITINERANT, ITSY, ITTY
        "IO":[.A],                      // IOTA
        "O":[.H, .I, .T],               // OTHER, OTIC, OTTER
        "OA":[.E, .H, .S],              // OATEN, OATH, OATS
        "OU":[.S],                      // OUTS
        "U":[.T]],                      // UTTER
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            
            // Final A followers: BETA, SETA, ERRATA
            if phonemes.matchesSet(["BE", "SE", "ERRA"]) {
                followers += [.A]
            }
            
            // Approve I follower for SATI, YETI
            if phonemes.matchesSet(["SA", "YE"]) {
                followers += [.I]
            }
            
            // Approve A follower for PITA
            if phonemes.matchesSet(["PI"]) {
                followers += [.A]
            }
            
            // Approve O follower for VETO
            if phonemes.matchesSet(["VE"]) {
                followers += [.O]
            }
            
            // Final TT words: BUTT, MATT, MITT, SETT, WATT
            if phonemes.matchesSet(["BU", "MA", "MI", "SE", "WA"]) {
                followers += [.T]
            }
            
            // Final TZ words: BLITZ, DITZ, LUTZ, PUTZ, RITZ
            if phonemes.matchesSet(["BLI", "DI", "LU", "PU", "RI"]) {
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
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        
        if pos == .positionLAST {
            let lastElement = phonemes.lastElement()
            
            // Approve final A for LAVA, CAVA, NOVA etc.
            if phonemes.matchesSet(["CA", "LA", "NO"]) {
                followers += [.A]
            }
            
            // Approve final O for BRAVO
            if phonemes.matchesSet(["BRA"]) {
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
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        
        // Allow final I for TAXI
        if pos == .positionLAST && phonemes.matchesString("TA", matchFull: true)  {
            return [.I]
        }
            
        // Allow final T only for NEXT, SEXT
        else if pos == .positionLAST && phonemes.matchesSet(["NE", "SE"]) {
            return [.T]
        }
        
        else {
            return []
        }
    })

let Y = Consonant( id: .Y,
    blendStart: [],
    blendInto: [.L, .M, .N, .R, .S, .T],
    defFinal: [],
    hardStops: [.C, .P, .V, .W],
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
        "G":[.M, .N, .P, .R],       // GYMS, GYNECOLOGY, GYPSY, GYRO
        "GL":[.P],                  // GLYPH
        "GR":[.P],                  // GRYPHON
        "H":[.A, .E, .M],           // HYACINTH, HYENA, HYMN, HYSTERIA
        "L":[.E, .I, .M, .R],       // LYES, LYING, LYME, LYRIC
        "M":[.N, .O, .S],           // MYNA, MYOPIA, MYSTERY
        "N":[.L],                   // NYLON
        "P":[.L, .R, .T],           // PYLON, PYROTECHNIC/PYRRIC?, PYTHON
        "PH":[.L],                  // PHYLUM
        "PR":[.I],                  // PRYING
        "PS":[.C],                  // PSYCHO
        "R":[.E],                   // RYES
        "RH":[.M, .T],              // RHYME, RHYTHM
        "S":[.C, .L, .M, .N, .P, .R, .S],   // SYCOPHANT, SYLLABUS, SYMBOL, SYNERGY, SYPHILIS, SYRUP, SYSTEM
        "SC":[.T],                  // SCYTHE
        "SH":[.E, .I, .L],          // SHYER, SHYING, SHYLY
        "SP":[.I],                  // SPYING
        "ST":[.E, .R],              // STYE, STYROFOAM
        "T":[.I, .P, .R],           // TYING, TYPE, TYRANT
        "TH":[.M],                  // THYME
        "V":[.I],                   // VYING
        "W":[.V],                   // WYVERN
        "Z":[.G]],                  // ZYGOTE
        
    dynamicFollowers: { (phonemes: PhoneticElementArray, pos: PositionIndicator) in
        var followers: [Letter] = []
        let lastElement = phonemes.lastElement()
        let prevElement = phonemes.nextToLastElement()    // assuming will be non-nil
        
        if pos == .positionLAST {
            
            // Approve final E for STYE - this is handled in followerTable
//            if phonemes.matchesString("ST", matchFull: true) {
//                followers += [.E]
//            }
            
            // Approve final L for IDYL, VINYL
            if phonemes.matchesSet(["ID", "VIN"]) {
                followers += [.L]
            }
            
            // Approve final M for ANTONYM, SYNONYM
            if lastElement!.id == "N" && prevElement!.id == "O" {
                followers += [.M]
            }
            
            // Approve final O for YOYO
            if phonemes.matchesString("YO", matchFull: true) {
                followers += [.O]
            }
            
            // Approve final R for MARTYR, SATYR
            if phonemes.matchesSet(["MART", "SAT"]) {
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
