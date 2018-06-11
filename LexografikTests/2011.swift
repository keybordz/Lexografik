//
//  2011.swift
//  LexografikTests
//
//  Created by Jay Wright on 5/24/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import UIKit
import XCTest
import Lexografik

class LexografikTests_2011: XCTestCase {
    var storm: WordStorm!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_2011May26_hAmburger() {
        storm = WordStorm(outer: ["H", "M", "B", "U", "R", "G", "E", "R"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RHEA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UREA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARM")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AUGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARGUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BREAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAREM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UMBRA")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARGUER")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UMBRAGE")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAMBURGER")))
    }

    func test_2011May19_chromaTic() {
        storm = WordStorm(outer: ["C", "H", "R", "O", "M", "A", "I", "C"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MART")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOTH")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CACTI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RATIO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CATCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIRTH")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ATOMIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARCTIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AORTIC")))
    }

    func test_2011May03_cHopstick() {
        storm = WordStorm(outer: ["C", "O", "P", "S", "T", "I", "C", "K"], center: "H")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHIP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PISH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PITH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COSH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOSH")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHIPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THICK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHICK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOCK")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHICKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOCKS")))
        //        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHTICK")))
        //        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KITSCH")))
    }

    func test_2011May15_wAyfaring() {
        storm = WordStorm(outer: ["W", "Y", "F", "A", "R", "I", "N", "G"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AWAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AWRY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RANI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNAW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YAWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAGA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WARN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AFAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WARY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FAWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WAIF")))
        
        // Bad ending letters after AWN
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWNF")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWNG")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWNI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWNR")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANGRY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AWING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RANGY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAINY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YAWING")))
        
        storm.filterStops = false
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WAYFARING")))
    }

    func test_2011May28_immersiNg() {
        storm = WordStorm(outer: ["I", "M", "M", "E", "R", "S", "I", "G"], center: "N")

        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINI")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINIM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINIS")))
        
        // All checks for improper word endings
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GENMR")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RENMG")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "MIENI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NIRGI")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REIGNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RESIGN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SINGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIRING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIMING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINIMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIMING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIGNER")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIMMING")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMMERSING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIMMERING")))
    }

    func test_2011Dec27_chrOmatic() {  //2011Dec27
        storm = WordStorm(outer: ["C", "H", "R", "M", "A", "T", "I", "C"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IOTA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OTIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COCA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TACO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TORI")))
        
        // No 4-letter words starting with CHRO
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "CHRO")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MACHO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MACRO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOCHA")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHAOTIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHARIOT")))
    }

    func test_2011Dec20_prEshrunk() {           // Also 2017Dec06
        storm = WordStorm(outer: ["P", "R", "S", "H", "R", "U", "N", "K"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PERK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PUKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KERN")))
        
        // No N-blends without a vowel
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "SNPE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "USHER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PURSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RERUN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PERKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PUKES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUPER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NUKES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SURER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KERNS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PUSHER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PURSER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HUSKER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HUNKER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRUNES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRUNER")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HUNKERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRUNERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPURNER")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRESHRUNK")))
    }

    func test_2011Jun09_pedigreeD() {
        storm = WordStorm(outer: ["P", "E", "D", "I", "G", "R", "E", "E"], center: "D")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DREG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EDGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIRE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRIED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GREED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRIED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EDGED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REDID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIDGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EDGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRIDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIRGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EIDER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEEPER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEERED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIDGED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEGREE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DREDGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DERIDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRIDED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIRDED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRIPED")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEDIGREE")))
    }

    func test_2011Jun01_heaLthily() {
        storm = WordStorm(outer: ["H", "E", "A", "T", "H", "I", "L", "Y"], center: "L")
 
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TALL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HELL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YELL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATH")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATHI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALLEY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HILLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TALLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATHE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATELY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEALTH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LETHAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALITE")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEALTHY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LITHELY")))
    }

    func test_2011Jun12_Crediting() {
        storm = WordStorm(outer: ["R", "E", "D", "I", "T", "I", "N", "G"], center: "C")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RICE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NICER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRIED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CIDER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ICING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RICED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRICE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DICER")))

        // No final E after TC
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NITCE")))

        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CREDIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INCITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRETIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIRECT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RICING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CITING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DICING")))

        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRINGED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INCITED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INCITER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEICING")))

        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INDIRECT")))

        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CREDITING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIRECTING")))
    }

    func test_2011Jun04_Amazingly() {
        storm = WordStorm(outer: ["M", "A", "Z", "I", "N", "G", "L", "Y"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAZY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ZANY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MYNA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAMA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAZY")))
        
        storm.filterStops = false    // MANLY & LAYMAN
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANGY")))
        
        storm.filterStops = true
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANIMAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAMING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAZING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAYMAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAMINA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANILA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ZANILY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMAZING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANGILY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAZYING")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMAZINGLY")))
    }

    func test_2011Jun02_inScribes() {
        storm = WordStorm(outer: ["I", "N", "S", "C", "R", "I", "B", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IBIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRIS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NISC")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BINC")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIREN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RINSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RISES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RESIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RISEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRIBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RICES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIRES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRESS")))
        
        // No invalid RC plural
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BIRCS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIRENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RINSES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCRIBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRISIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRISES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RESINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INCISE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IBISES")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCRIBES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INCISES")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INSCRIBE")))
    }

    func test_2011Jun15_vainglorY() {
        storm = WordStorm(outer: ["V", "A", "I", "N", "G", "L", "O", "R"], center: "Y", filterStops: false)
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAVY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIRY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OILY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ONLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VARY")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VINYL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGONY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRONY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IVORY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAVY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OVARY")))
        
        storm.filterStops = false       // for VAINLY
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNARLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VAINLY")))

        storm.filterStops = true
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VARYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANGRILY")))
        
        storm.filterStops = false       // hard stop between N & GL
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VAINGLORY")))
    }

    func test_2011Jun13_commonErs() {
        storm = WordStorm(outer: ["C", "O", "M", "M", "O", "N", "R", "S"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CONE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CONES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNORE")))

        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOONER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOROSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRONES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SERMON")))

        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMMONER")))
    }

    func test_2011Jun27_cookerieS() {
        storm = WordStorm(outer: ["C", "O", "O", "K", "E", "R", "I", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORCS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEEK")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REEKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROOKS")))

        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COOKIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COOKERS")))
    }

    func test_2011May14_employeeS() {         // 14May2011
        storm = WordStorm(outer: ["E", "M", "P", "L", "O", "Y", "E", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ESPY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEEM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POSY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YELPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PLOYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOPES")))

        storm.filterStops = false       // SEEMLY
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEEMLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLEEPY")))
        
        storm.filterStops = true
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMPLOYS")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMPLOYEES")))
    }

    func test_2011May30_mandatOry() {
        storm = WordStorm(outer: ["M", "A", "N", "D", "A", "T", "R", "Y"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAYO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TARO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MORN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NORM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DORY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AORTA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAYOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAYON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MORAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TODAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AROMA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROMAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOMAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOADY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DYNAMO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MATRON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOTARY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANATOMY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DORMANT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MATADOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MORDANT")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANDATORY")))
    }

    func test_2011May04_broomdiSh() {         // 04May2011
        storm = WordStorm(outer: ["B", "R", "O", "O", "M", "D", "I", "H"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DISH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RODS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROOMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BIRDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOORS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOODS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOOMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRIMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ODORS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOBOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOORS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BROOMS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOORISH")))
    }

    func test_2011May17_rigmarOle() {
        storm = WordStorm(outer: ["M", "A", "R", "R", "I", "G", "L", "E"], center: "O")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMAGO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOIRE")))
    }

    func test_2011Dec13_scaffoLds() {
        storm = WordStorm(outer: ["S", "C", "A", "F", "F", "O", "D", "S"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CALF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOAL")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LASSO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOCAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COALS")))
    }

    func test_2011Dec16_jaBbering() {
        storm = WordStorm(outer: ["J", "A", "B", "E", "R", "I", "N", "G"], center: "B")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JIBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GARB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARB")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEGIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RABBI")))
    }

    func test_2011Dec02_stolIdity() {
        storm = WordStorm(outer: ["S", "T", "O", "L", "D", "I", "T", "Y"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIDY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDOL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIDO")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDIOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOLID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDOLS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TILTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DITTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STILT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOILY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIDOS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDIOTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOLID")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOLIDITY")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOLIDITY")))
    }
    
    func test_2011Dec17_coaguLant() {
        storm = WordStorm(outer: ["C", "O", "A", "G", "U", "A", "N", "T"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALGA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLUNG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLOAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TALON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TONAL")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNCLOG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ATONAL")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CATALOG")))
    }
    
    func test_2011Jul06_slIppages() {
        storm = WordStorm(outer: ["S", "L", "P", "P", "A", "G", "E", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLIP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PILE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LISP")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLIPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PILES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LISPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AEGIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ISLES")))
        
        // No final E after SP
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GISPE")))
        
        // No final E after PS unless preceded by A or O
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "SIPSE")))

        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AISLES")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APPLIES")))
    }
    
    func test_2011Jul16_pachYderm() {
        storm = WordStorm(outer: ["P", "A", "C", "H", "D", "E", "R", "M"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YARD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARMY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAYED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "READY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARDY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DECAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RHYME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEARY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAYED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEADY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DECRY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MERCY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHARY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HYPED")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRAYED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DREAMY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RHYMED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CREAMY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEACHY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CYPHER")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PREACHY")))
        
        storm.filterStops = false
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PACHYDERM")))
    }
    
    func test_2011Jul19_jailbrEak() {
        storm = WordStorm(outer: ["J", "A", "I", "L", "B", "R", "A", "K"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEAK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BIKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JERK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KALE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KIBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BERK")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAKER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRAKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BREAK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALIKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLEAK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALBER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BALER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BIKER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JAILER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAILER")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JAILBREAK")))
    }
    
    func test_2011Jun22_imPedance() {
        storm = WordStorm(outer: ["I", "M", "E", "D", "A", "N", "C", "E"], center: "P")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APED")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PENCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PANIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEACE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAPED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PACED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PECAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PINED")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAMPED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIECED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAINED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAMPEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMPEDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMPEND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DECAMP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENCAMP")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENCAMPED")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMPEDANCE")))
    }
    
    func test_2011Jun22_eLegantly() {
        storm = WordStorm(outer: ["E", "E", "G", "A", "N", "T", "L", "Y"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LANE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EAGLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEANT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TELLY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GENTLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TANGLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GALLEY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EAGLET")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELEGANT")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELEGANTLY")))
    }

    func test_2011Jun30_wearIsome() {
        storm = WordStorm(outer: ["W", "E", "A", "R", "S", "O", "M", "E"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SARI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWIM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIRS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEMI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SORI")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AERIE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OSIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WIRES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARISE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAISE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WISER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIRES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMIRS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIMES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEIRS")))

        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EASIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARMIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOIRES")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEARISOME")))
    }
}


