//
//  2013.swift
//  LexografikTests
//
//  Created by Jay Wright on 5/24/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import UIKit
import XCTest
import Lexografik

class LexografikTests_2013: XCTestCase {
    var storm: WordStorm!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_2013Feb18_typeCasts() {   //2013Feb18
        storm = WordStorm(outer: ["T", "Y", "P", "E", "A", "S", "T", "S"], center: "C")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PACE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CYST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TACT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SECT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAYS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPACE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAPES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PACES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CATTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SECTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PACTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CYSTS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPACES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASPECT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPACEY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASTES")))
        
        storm.filterStops = false       // to make ECSTASY work
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ECSTASY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASPECTS")))
    }
    
    func test_2013Sep01_academIes() {
        storm = WordStorm(outer: ["A", "C", "A", "D", "E", "M", "E", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DISC")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEISM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEICE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEDIA")))
    }
    
    func test_2013Apr08_truantIng() {
        storm = WordStorm(outer: ["T", "R", "U", "A", "N", "T", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANTI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TIGN")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NITT")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RINN")))
    }
    
    func test_2013Apr03_fReckling() {
        storm = WordStorm(outer: ["F", "E", "C", "K", "L", "I", "N", "G"], center: "R")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ERGLK")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RINLK")))
    }
    
    func test_2013Apr07_sorrowiNg() {       // 07Apr2013
        storm = WordStorm(outer: ["S", "O", "R", "R", "O", "W", "I", "G"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WORN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GROIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OWING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWOON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWORN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WRONG")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INGOO")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ORIRN")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "WRORN")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOWING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROWING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOOING")))
    }
    
    func test_2013Nov17_hankerIng() {        // 17Nov2013
        storm = WordStorm(outer: ["H", "A", "N", "K", "E", "R", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAKI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NIGH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AKIN")))
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INNEA")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RINEG")))
    }
    
    func test_2013Feb27_impOtence() {
        storm = WordStorm(outer: ["I", "M", "P", "T", "E", "N", "C", "E"], center: "O")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPTIC")))
    }
    
    func test_2013Feb16_embOdying() {
        storm = WordStorm(outer: ["E", "M", "B", "D", "Y", "I", "N", "G"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OBEY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BINGO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DINGO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOYEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NODGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOING")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEYOND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BODING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMBODY")))
    }
    
    func test_2013Mar09_geriaTric() {
        storm = WordStorm(outer: ["G", "E", "R", "I", "A", "R", "I", "C"], center: "T")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RECTA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIER")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRITERIA")))
    }
    
    func test_2013Mar25_carNation() {
        storm = WordStorm(outer: ["C", "A", "R", "A", "T", "I", "O", "N"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANON")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANION")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CONTRA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRANIA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CITRON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANNOT")))
    }
    
    func test_2013Mar07_Nunneries() {
        storm = WordStorm(outer: ["U", "N", "N", "E", "R", "I", "E", "S"], center: "N")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENSUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "URINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENNUI")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "URSINE")))
    }
    
    func test_2013Mar31_ingeniouS() {
        storm = WordStorm(outer: ["I", "N", "G", "E", "N", "I", "O", "U"], center: "S")
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENSUING")))
    }
    
    func test_2013Feb14_cordiallY() {
        storm = WordStorm(outer: ["C", "O", "R", "D", "I", "A", "L", "L"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDLY")))
    }
    
    func test_2013Mar21_pAtricial() {
        storm = WordStorm(outer: ["P", "T", "R", "I", "C", "I", "A", "L"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRAP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLAP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TARP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CART")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIRA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARIA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PACT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TALC")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CILIA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PLAIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAPIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALTAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIARA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APART")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RACIAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ITALIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARPAL")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARTIAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAPITAL")))
    }
    
    func test_2013Mar23_brainwaSh() {
        storm = WordStorm(outer: ["B", "R", "A", "I", "N", "W", "A", "H"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AWNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NIBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWAB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NABS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BANS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BIAS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BASIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AWASH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARIAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRASH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAHIB")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRAINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BANISH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHARIA")))
    }
    
    func test_2013Mar24_glAddened() {
        storm = WordStorm(outer: ["G", "L", "D", "D", "E", "N", "E", "D"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LADE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALEE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLAD")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANGEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANGLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLAND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELAND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ADDLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLEAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LADEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ADDED")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DANDLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEADEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANGLED")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLADDEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLEANED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DANGLED")))
    }
    
    func test_2013Apr18_evocAtion() {
        storm = WordStorm(outer: ["E", "V", "O", "C", "T", "I", "O", "N"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOVA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VANE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VINA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANOE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANTIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OATEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENACT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ATONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAIVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OVATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COATI")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OCTANE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OCTAVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACTION")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACTIVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AVOCET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NATIVE")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OVATION")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VOCATION")))
    }
    
    func test_2013Apr17_bufferIng() {
        storm = WordStorm(outer: ["B", "U", "F", "F", "E", "R", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIFE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRIG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIFF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIFE")))
        
        storm.filterStops = false   // For INFER to work
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRIEF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRIEF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FUNGI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIBER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEIGN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INFER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BURIN")))
        
        storm.filterStops = true
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FINGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIGURE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FRINGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EFFING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BUFFING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUFFING")))
    }
    
    func test_2013Apr01_famiLiars() {
        storm = WordStorm(outer: ["F", "A", "M", "I", "I", "A", "R", "S"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ILIA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FILM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAIL")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALARM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIARS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALAMI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLAIRS")))
    }
    
    func test_2013Apr04_sandbLast() {
        storm = WordStorm(outer: ["S", "A", "N", "D", "B", "A", "S", "T"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BALD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LADS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TALA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BALSA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NATAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BANAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BASAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLAND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TALAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NASAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TABLA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLAST")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BASALT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SANDAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TABLAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLASTS")))
    }
    
    func test_2013Apr29_decantinG() {
        storm = WordStorm(outer: ["D", "E", "C", "A", "N", "T", "I", "N"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TANG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DING")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGENT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAGED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIANT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACING")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CEDING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GINNED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TINGED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EATING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DATING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENDING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACTING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANTEING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DANCING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DENTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TENDING")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENACTING")))
    }
    
    func test_2013Apr16_Evaluated() {
        storm = WordStorm(outer: ["V", "A", "L", "U", "A", "T", "E", "D"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DALE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VELD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VALE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DELTA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DELVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELUTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EVADE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEAVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VALET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VALUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VELDT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEAVED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELATED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VALUED")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEVALUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VAULTED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VALETED")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EVALUATE")))
    }
    
    func test_2013Apr13_Revelness() {
        storm = WordStorm(outer: ["E", "V", "E", "L", "N", "E", "S", "S"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEER")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SERVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REVEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VERSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REELS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VENEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SERENE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SERVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REVELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELVERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LESSER")))
    }
    
    func test_2013Apr23_synThesis() {
        storm = WordStorm(outer: ["S", "Y", "N", "H", "E", "S", "I", "S"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THEY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STYES")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THESIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHYEST")))
    }
    
    func test_2013Apr02_Grotesque() {
        storm = WordStorm(outer: ["R", "O", "T", "E", "S", "Q", "U", "E"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GEES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OGRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EGOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ERGO")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GUSTO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROGUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GREET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EGRET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GORES")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GROUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROGUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROUGES")))
    }
    
    func test_2013Apr05_affordIng() {
        storm = WordStorm(outer: ["A", "F", "F", "O", "R", "D", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIRD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIND")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DINAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIORD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRIND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRAIN")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DARING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FADING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OFFING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FORDING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOFFING")))
    }
}
