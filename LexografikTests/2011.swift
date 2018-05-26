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

    func test_hAmburger() {         // May2011
        storm = WordStorm(outer: ["H", "M", "B", "U", "R", "G", "E", "R"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RHEA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UREA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AUGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARGUE")))
    }

    func test_2011May03_chromaTic() {       // Date??
        storm = WordStorm(outer: ["C", "H", "R", "O", "M", "A", "I", "C"], center: "T")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CACTI")))
    }

    func test_2011May03_cHopstick() {       // Date??
        storm = WordStorm(outer: ["C", "O", "P", "S", "T", "I", "C", "K"], center: "H")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PISH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PITH")))
        
        //        storm.gatherWords(6)
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
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWNF")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWNG")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWNI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWNR")))
    }

    func test_2011May28_immersiNg() {
        storm = WordStorm(outer: ["I", "M", "M", "E", "R", "S", "I", "G"], center: "N")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GENMR")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RENMG")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "MIENI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NIRGI")))
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

    func test_2011Dec20_prEshrunk() {
        storm = WordStorm(outer: ["P", "R", "S", "H", "R", "U", "N", "K"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PERK")))
        
        // No N-blends without a vowel
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "SNPE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "USHER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PURSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RERUN")))
    }

    func test_2011Jun09_pedigreeD() {
        storm = WordStorm(outer: ["P", "E", "D", "I", "G", "R", "E", "E"], center: "D")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DREG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EDGE")))
    }

    func test_2011Jun01_heaLthily() {
        storm = WordStorm(outer: ["H", "E", "A", "T", "H", "I", "L", "Y"], center: "L")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATHI")))
    }

    func test_2011Jun12_Crediting() {
        storm = WordStorm(outer: ["R", "E", "D", "I", "T", "I", "N", "G"], center: "C")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NITCE")))
    }

    func test_2011Jun04_Amazingly() {
        storm = WordStorm(outer: ["M", "A", "Z", "I", "N", "G", "L", "Y"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAZY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ZANY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MYNA")))
    }

    func test_2011Jun02_inScribes() {
        storm = WordStorm(outer: ["I", "N", "S", "C", "R", "I", "B", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IBIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRIS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NISC")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BINC")))
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BIRCS")))
    }

    func test_2011Jun30_vainglorY() {
        storm = WordStorm(outer: ["V", "A", "I", "N", "G", "L", "O", "R"], center: "Y", filterStops: false)
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAVY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIRY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OILY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ONLY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VINYL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VYING")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNARLY")))
    }

    func test_2011Jun13_commonErs() {
        storm = WordStorm(outer: ["C", "O", "M", "M", "O", "N", "R", "S"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROES")))
    }

    func test_2015Apr23_severallY() {
        storm = WordStorm(outer: ["S", "E", "V", "E", "R", "A", "L", "L"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LYRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AYES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EYES")))
    }

    func test_2011Jun27_cookerieS() {
        storm = WordStorm(outer: ["C", "O", "O", "K", "E", "R", "I", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORCS")))
    }

    func test_2011May14_employeeS() {         // 14May2011
        storm = WordStorm(outer: ["E", "M", "P", "L", "O", "Y", "E", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ESPY")))
    }

    func test_2011May30_mandatOry() {
        storm = WordStorm(outer: ["M", "A", "N", "D", "A", "T", "R", "Y"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAYO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TARO")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AORTA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAYOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAYON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MORAY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DYNAMO")))
    }

    func test_2011May04_broomdiSh() {         // 04May2011
        storm = WordStorm(outer: ["B", "R", "O", "O", "M", "D", "I", "H"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOBS")))
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
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LASSO")))
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
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDIOT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDIOTS")))
    }
    
    func test_2011Dec17_coaguLant() {
        storm = WordStorm(outer: ["C", "O", "A", "G", "U", "A", "N", "T"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALGA")))
    }
}

