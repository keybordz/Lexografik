//
//  2017.swift
//  LexografikTests
//
//  Created by Jay Wright on 5/24/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import UIKit
import XCTest
import Lexografik

class LexografikTests_2017: XCTestCase {
    var storm: WordStorm!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_2017Dec01_thRowback() {
        storm = WordStorm(outer: ["T", "H", "O", "W", "B", "A", "C", "K"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROCK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRAB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CROW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WORK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BROW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RACK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OKRA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HART")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACTOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THROW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHART")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TORCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WORTH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WRATH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CROAK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BROTH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WRACK")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BROACH")))
    }
    
    func test_2017Dec16_projecteD() {
        storm = WordStorm(outer: ["P", "R", "O", "J", "E", "C", "T", "E"], center: "D")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEEP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CODE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PROD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CEDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRED")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEPOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DETER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CREED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COPED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DECOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CODER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TREED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PORED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPTED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROPED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOPER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEJECT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PORTED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEPORT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RECODE")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PROCEED")))
    }
    
    func test_2017Dec28_haLlowing() {
        storm = WordStorm(outer: ["H", "A", "L", "O", "W", "I", "N", "G"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HILL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LONG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WILL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WALL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOWL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GALL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WAIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OLLA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALONG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALLOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGLOW")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOLING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOWING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GALLON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALLOW")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOWLING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WALLING")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALLOWING")))
    }
    
    func test_2017Dec31_comPlexes() {
        storm = WordStorm(outer: ["C", "O", "M", "L", "E", "X", "E", "S"], center: "P")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEEP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLOP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXPO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PECS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POXES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXPEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLOPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COPES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCOPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POLES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOPES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COPSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXPOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLEEP")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXPOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXPELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMPEL")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMPELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMPLEX")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COMPLEXES")))
    }
    
    func test_2017Jul20_myStifies() {
        storm = WordStorm(outer: ["M", "Y", "T", "I", "F", "I", "E", "S"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STEM")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ITEMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FISTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SITES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIFTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIMES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MITES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISSY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STEMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MESSY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SMITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STIES")))
        
        storm.filterStops = false    // MISFIT
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISFIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SYSTEM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STYMIE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEISTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SMITES")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISFITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STYMIES")))
        
        storm.filterStops = true
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MYSTIFIES")))
    }
    
    func test_2017Jul04_crAnberry() {
        storm = WordStorm(outer: ["C", "R", "N", "B", "E", "R", "R", "Y"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RACE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACRE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RARER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARRY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRACE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RERAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CABER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YEARN")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRACER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARNEY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARREN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRAYER")))

        storm.filterStops = false
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRANBERRY")))
    }

    func test_2017Jul28_whOlesale() {
        storm = WordStorm(outer: ["W", "H", "L", "E", "S", "A", "L", "E"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OWLS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHOA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALOE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AWOL")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOLES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HELLO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHOLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOWLS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALLO")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALLOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALLOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALLOS")))

        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHALLOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALLOWS")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHOLESALE")))
    }

    func test_2017Nov15_opporTune() {
        storm = WordStorm(outer: ["O", "P", "P", "O", "R", "U", "N", "E"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROTE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OUTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TENOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TONER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROOP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROUTE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRONTO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UPROOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOPPER")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPPORTUNE")))
    }

    func test_2017Nov03_Shovelful() {
        storm = WordStorm(outer: ["H", "O", "V", "E", "L", "F", "U", "L"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SELL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SELF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUSH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOES")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHELL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLESH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLUSH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHELF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOULS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOLVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FUELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FELLS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HELLS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HULLS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VOLES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLOES")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOVEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOVELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HELLOS")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOVELFUL")))
    }

    func test_2017Nov06_exCavator() {
        storm = WordStorm(outer: ["E", "X", "A", "V", "A", "T", "O", "R"], center: "C")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COAX")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORCA")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXACT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRACE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRAVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COVET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RECTO")))

        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OXCART")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VECTOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORTEX")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAVORT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VACATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRAVAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COAXER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COVERT")))

        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXCAVATOR")))
    }

    func test_2017Nov07_juNctures() {
        storm = WordStorm(outer: ["J", "U", "C", "T", "U", "R", "E", "S"], center: "N")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCENT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RENTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CENTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STERN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TERNS")))
        
        storm.filterStops = false
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNJUST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNSURE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNREST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNTRUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TUNERS")))
        
        storm.filterStops = true
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENCRUST")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JUNCTURE")))
    }

    func test_2017Nov17_extOrting() {
        storm = WordStorm(outer: ["E", "X", "T", "R", "T", "I", "N", "G"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OXEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOER")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOXIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GONER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROTTEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXTORT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOITER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOTTEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIGON")))

        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROTTING")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXTORTING")))
    }
}
