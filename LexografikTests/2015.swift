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
    
    func test_2015Feb14_gEnuflect() {
        storm = WordStorm(outer: ["G", "N", "U", "F", "L", "E", "C", "T"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TUNE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CENT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FUEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GENE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLEF")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLEET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FENCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELECT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLEFT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLUTEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUCENT")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FULGENT")))
        
//        storm.gatherWords(9)
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GENUFLECT")))
    }
    
    func test_2015Feb11_dialecTic() {
        storm = WordStorm(outer: ["D", "I", "A", "L", "E", "C", "I", "C"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIDE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACTED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TILED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEALT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TILDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIDAL")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DETAIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAILED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELICIT")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIALECT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CITADEL")))
    }
    
    func test_2015Feb17_satinwOod() {
        storm = WordStorm(outer: ["S", "A", "T", "I", "N", "W", "O", "D"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOOD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NODS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WONT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OAST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOOS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOODS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOOD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOWNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOWNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOADS")))
    }
    
    func test_2015Feb18_olfacTory() {
        storm = WordStorm(outer: ["O", "L", "F", "A", "C", "O", "R", "Y"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FORT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FACT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FART")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AFOOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALOFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FORTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLOAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRAFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CROFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOFTY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FACTOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRAFTY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FACTORY")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OLFACTORY")))
    }
    
    func test_2015Feb26_mauSoleum() {
        storm = WordStorm(outer: ["M", "A", "U", "O", "L", "E", "U", "M"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMUS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLUM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUMO")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MALES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOLES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MULES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAMES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALUMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALOES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAULS")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAUSOLEUM")))
    }
    
    func test_2016Feb22_digNifies() {
        storm = WordStorm(outer: ["D", "I", "G", "I", "F", "I", "E", "S"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEND")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FINDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FINES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIEND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FENDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEIGN")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INSIDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIENDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DESIGN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIGNED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SINGED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIDING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEIGNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEIGNS")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIGNIFIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIGNIFIED")))
    }
    
    func test_2016Feb24_caTacombs() {
        storm = WordStorm(outer: ["C", "A", "A", "C", "O", "M", "B", "S"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ATOM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOMS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ATOMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOMA")))
        
        // No BT combinations except DEBT & DOUBT
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "CABTS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "MOBTS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MASCOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMBAT")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMBATS")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CATACOMB")))
    }
    
    func test_2016Feb21_mIlkmaids() {
        storm = WordStorm(outer: ["M", "L", "K", "M", "A", "I", "D", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MILK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLIM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SILK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KIDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SKID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DISK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ILKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SILD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SKIM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MILD")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MILKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAIDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAIMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMAMS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DISMAL")))
        
        storm.filterStops = false
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISLAID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISDIAL")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MILKMAID")))
    }
    
    func test_2015Feb16_justifiEd() {
        storm = WordStorm(outer: ["J", "U", "S", "T", "I", "F", "I", "D"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEUD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JEST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JUTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEFT")))
        
        // No single vowel F enders
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ITEF")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEUDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIDES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EDITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FETID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FETUS")))
        
        // no DJ combinations
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "FUDJE")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TIDJE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUTIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUITED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIFTED")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JUSTIFIED")))
    }
    
    func test_2015Feb20_Affording() {
        storm = WordStorm(outer: ["F", "F", "O", "R", "D", "I", "N", "G"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RANG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DARN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRAG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAGO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FARO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAFF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAFF")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GROAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORGAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ADORN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RADON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARGON")))
        
        storm.filterStops = false       // for INROAD
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AFFORD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRAGON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OARING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INROAD")))
        
        storm.filterStops = true
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ADORING")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AFFORDING")))
    }
    
    func test_2015Feb06_Moonbeams() {
        storm = WordStorm(outer: ["O", "O", "N", "B", "E", "A", "M", "S"], center: "M")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEMO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOMA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMMO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MESA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMEN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAMES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOANS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MASON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEANS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEMOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OMENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAMBO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MESON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOSOM")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEMOAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAMBOS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEMOANS")))
        
        storm.filterStops = false
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOONBEAM")))
    }
    
    func test_2015Mar01_cannibalS() {
        storm = WordStorm(outer: ["C", "A", "N", "N", "I", "B", "A", "L"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCAB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CABS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAAS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNAIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLANS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BASIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BASIL")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CABINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANNALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CABALS")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANNABIS")))
    }
    
    func test_2015Mar12_dashinglY() {
        storm = WordStorm(outer: ["D", "A", "S", "H", "I", "N", "G", "L"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAYS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HANDY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAISY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DINGY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHADY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SANDY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDYLS")))
        
        storm.filterStops = false    // INLAYS
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INLAYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DINGHY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLANGY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHANDY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLAYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHADILY")))
    }
    
    func test_2015Mar13_parTaking() {
        storm = WordStorm(outer: ["P", "A", "R", "A", "K", "I", "N", "G"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KNIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAIT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAKING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PATINA")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRATING")))
    }
    
    func test_2015Mar07_knowleDge() {
        storm = WordStorm(outer: ["K", "N", "O", "W", "L", "E", "G", "E"], center: "D")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOLD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WELD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GELD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DONG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEWD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LODE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GEED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DELE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOLD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EKED")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OWNED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LODGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEDGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEDGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOWED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OGLED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENDOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OLDEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOWEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GEODE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOLDEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LONGED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DONGLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLOWED")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KNOWLEDGE")))
    }
    
    func test_2015Mar07_pedoMeter() {
        storm = WordStorm(outer: ["P", "E", "D", "O", "E", "T", "E", "R"], center: "M")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROMP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEMP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PERM")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "METED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEMPO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOPED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROMP")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEMPER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROMPED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TERMED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PERMED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REDEEM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEMPED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEEMED")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "METERED")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEMPERED")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEDOMETER")))
    }

    func test_2015Apr30_dAshboard() {
        storm = WordStorm(outer: ["D", "S", "H", "B", "O", "A", "R", "D"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DADO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRAB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DABS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DADS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RADS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOARD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DADOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BROAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROADS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABROAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABOARD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOARDS")))
        
        storm.filterStops = false
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DASHBOARD")))
    }

    func test_2015Apr26_asseraNce() {
        storm = WordStorm(outer: ["A", "S", "S", "E", "R", "A", "C", "E"], center: "N")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARENA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCENE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SENSE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARENAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRANES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCREEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCENES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENCASE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANERS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCREENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENCASES")))
    }
    
    func test_2015Apr01_oBscurity() {
        storm = WordStorm(outer: ["O", "S", "C", "U", "R", "I", "T", "Y"], center: "B")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TUBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STUB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CUBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BUST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BUOY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BURST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOUTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCRUB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORBIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BUOYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CURBS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORBITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CUBITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TURBOS")))
        
        storm.filterStops = false
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OBSCURITY")))
    }
    
    func test_2015Apr04_phOsphate() {
        storm = WordStorm(outer: ["P", "H", "S", "P", "H", "A", "T", "E"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POPE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OATHS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOPES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POPES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POETS")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PHOSPHATE")))
    }
    
    func test_2015Apr05_hardbackS() {
        storm = WordStorm(outer: ["H", "A", "R", "D", "B", "A", "C", "K"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SACK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARCS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BASK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARKS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRABS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHARK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRASH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HACKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BACKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHACK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RACKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRADS")))
        
        storm.filterStops = false
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARDBACKS")))
    }

    func test_2015Apr20_faNtastic() {
        storm = WordStorm(outer: ["F", "A", "T", "A", "S", "T", "I", "C"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FANS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TINTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACTIN")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FAINTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANTICS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAINTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAFTAN")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FANATIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAFTANS")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FANATICS")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FANTASTIC")))
    }

    func test_2015Apr24_forMalism() {
        storm = WordStorm(outer: ["F", "O", "R", "A", "L", "I", "S", "M"], center: "M")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FORM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FROM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FARM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIMO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MILS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FARMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FORMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FILMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOAMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIMOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOLAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MORAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROAMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIRMS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOLARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MORALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FORMAL")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FORMALS")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FORMALISM")))
    }
}
