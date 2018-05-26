//
//  2015.swift
//  LexografikTests
//
//  Created by Jay Wright on 5/24/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import UIKit
import XCTest
import Lexografik

class LexografikTests_2015: XCTestCase {
    var storm: WordStorm!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_2015Jan13_spritziNg() {
        storm = WordStorm(outer: ["S", "P", "R", "I", "T", "Z", "I", "G"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIGN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NIPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ZING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNIP")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RINGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PINTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PINGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ZINGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STING")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRINTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STRING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPRING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIZING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RISING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPRINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SITING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIRING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPITING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRIZING")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STRIPING")))
    }
    
    func test_2015Jan18_sColdings() {
        storm = WordStorm(outer: ["S", "O", "L", "D", "I", "N", "G", "S"], center: "C")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COGS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DISCO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCION")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DISCOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLINGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CODING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCIONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COSIGN")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOSING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COSIGNS")))
    }
    
    func test_2015Jan01_hicKories() {
        storm = WordStorm(outer: ["H", "I", "C", "O", "R", "I", "E", "S"], center: "K")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SICK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RISK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HIKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOCK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HICK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RICK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HECK")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROCKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HIKER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HIKES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOCK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COKES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SKIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HICKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOCKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHEIK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RICKS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HIKERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOKES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SICKER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KOSHER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOKER")))
        //        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KIRSCH")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOKERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOCKER")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HICKORIES")))
    }
    
    func test_2015Jan05_corroSive() {
        storm = WordStorm(outer: ["C", "O", "R", "R", "O", "I", "V", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ERRS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VISOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OVERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VICES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SERVO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VERSO")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIVERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COVERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VOICES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCORER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROVERS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORRIES")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORROSIVE")))
    }
    
    func test_2015Jan27_troPicial() {
        storm = WordStorm(outer: ["T", "R", "O", "I", "C", "I", "A", "L"], center: "P")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLIP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PLOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PART")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CROP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PICA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ATOP")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POLAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOPIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PATIO")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROPIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PORTAL")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APRICOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOPICAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPTICAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAPITOL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POLITIC")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROPICAL")))
    }
    
    func test_2015Jan30_enlighTen() {
        storm = WordStorm(outer: ["E", "N", "L", "I", "G", "H", "E", "N"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TINE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NINTH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TINGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THINE")))
        
        storm.gatherWords(6)
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LENGTH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEEING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIGHTEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LENIENT")))
        
//        storm.gatherWords(8)
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LENGTHEN")))
    }
    
    func test_2015Jan07_clAmpdown() {
        storm = WordStorm(outer: ["C", "L", "M", "P", "D", "O", "W", "N"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAMP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PLAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CALM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAMP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAMP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WAND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PALM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAMN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CODA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAPO")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLAMP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MODAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAPON")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALMOND")))
    }
    
    func test_2015Jan09_Shipshape() {
        storm = WordStorm(outer: ["H", "I", "P", "S", "H", "A", "P", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PASS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASPS")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHIPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHAPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIPES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEAPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PHASE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APSES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HASPS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHAPES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PHASES")))
    }
    
    func test_2015Jan08_Arbitrate() {
        storm = WordStorm(outer: ["R", "B", "I", "T", "R", "A", "T", "E"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AREA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TART")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TARE")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TREAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRIAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TETRA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TATER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRAIT")))

        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BATTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TARTAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TARTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RATTER")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARBITER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BATTIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RATTIER")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARBITRATE")))
    }
    
    func test_2015Feb27_reFraying() {
        storm = WordStorm(outer: ["R", "E", "R", "A", "Y", "I", "N", "G"], center: "F")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FERN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FAIRY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FERRY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIERY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRIAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIFER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRYER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FARER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIRER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FAIRER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FARING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FINERY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEARING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRAYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REFRAIN")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FERRYING")))
    }
    
    func test_2015Feb19_Crocklese() {
        storm = WordStorm(outer: ["R", "O", "C", "K", "L", "E", "S", "E"], center: "C")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOCK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COCK")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOCKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOCK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COCKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CREEK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLERK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CROCK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCREE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOCKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOSER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CREEKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLERKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CROCKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COERCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COCKLE")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOCKERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COERCES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COCKLES")))
    }
    
    func test_2015Feb01_vassalagE() {
        storm = WordStorm(outer: ["V", "A", "S", "S", "A", "L", "A", "G"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VASE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEAL")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAVEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GALES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VASES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLAVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAGES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VALES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GASES")))

        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAVELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLAVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAVAGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALVES")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAVAGES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALVAGE")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALVAGES")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VASSALAGE")))
    }
    
    func test_2015Feb03_foreBodes() {
        storm = WordStorm(outer: ["F", "O", "R", "E", "O", "D", "E", "S"], center: "B")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEEF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BODE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEBS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BORES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BORED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROBES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BREED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROBED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOORS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BODES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BROOD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOBER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OBESE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEEFS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEFORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BREEDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BROODS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOBERED")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOREBODE")))
    }
    
    func test_2015Feb04_fRizziest() {
        storm = WordStorm(outer: ["F", "I", "Z", "Z", "I", "E", "S", "T"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIRS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRIZ")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIRES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIRES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RITES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIFTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRIZZ")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIZER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RESIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REFIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRITZ")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STRIFE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REFITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIFEST")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRIZZES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIZZIER")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRIZZIEST")))
    }
    
    func test_2015Feb07_oversHoot() {
        storm = WordStorm(outer: ["O", "V", "E", "R", "S", "O", "O", "T"], center: "H")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HERO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOES")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HORSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHORT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OTHER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOOTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THROE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ETHOS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OTHERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOVERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOOVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOOTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOOVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOOTHE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THROES")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOOTERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOOTHER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOOTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOOVERS")))
        
//        storm.gatherWords(9)
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OVERSHOOT")))
    }
    
    func test_2015Feb10_barisTicy() {
        storm = WordStorm(outer: ["B", "A", "R", "I", "S", "I", "C", "Y"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CITY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRIT")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASTIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRAYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STAIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SITAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIBIA")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIBIAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RACIST")))
    }
}
