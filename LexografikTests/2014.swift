//
//  LexografikTests.swift
//  LexografikTests
//
//  Created by Jay Wright on 9/15/15.
//  Copyright (c) 2015 Keybordz. All rights reserved.
//

import UIKit
import XCTest
import Lexografik

class LexografikTests_2014: XCTestCase {
    var storm: WordStorm!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_2014Sep27_Oligarchy() {   //2014Sep27
        storm = WordStorm(outer: ["L", "I", "G", "A", "R", "C", "H", "Y"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAOL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GORY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OILY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YOGA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YOGI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOCI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORGY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AHOY")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "CHRO")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NAOL")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAROL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROYAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLORY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROACH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOGIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOARY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORGI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ROYIA")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ROLYA")))
    
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHORAL")))
    }
    
    func test_2014Sep11_extenSive() {
        storm = WordStorm(outer: ["E", "X", "T", "E", "N", "I", "V", "E"], center: "S")
    
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SENT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VISE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SINE")))
        
        // Valid X uses
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEXT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXES")))
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STIX")))
        
        // No V plurals
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TEVS")))
        
        // No X starters
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "XEST")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEVEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXIST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EVENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VINES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIEVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VENTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEXES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TINES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STEIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEXES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TENSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INSET")))
        
        storm.filterStops = false       // have to do this for INVEST to work
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EVENTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INVEST")))
    }
    
    func test_2014Sep19_gRuffness() {   //2014Sep19
        storm = WordStorm(outer: ["G", "U", "F", "F", "N", "E", "S", "S"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "USER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUNG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FERN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SURE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SURF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FURS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUFF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUNE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SERF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "URNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUER")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRUFF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUFFS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNUFFER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUFFERS")))
    }

    func test_2014Sep23_mOuthwash() {   //2014Sep23
        storm = WordStorm(outer: ["M", "U", "T", "H", "W", "A", "S", "H"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OHMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TWOS")))
    }
    
    func test_2014Sep19_pollutIng() {   //2014Sep19
        storm = WordStorm(outer: ["P", "O", "L", "L", "U", "T", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INTO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PILL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LION")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TILL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GILL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LILT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LING")))
        
        // No final LP blends, except for E
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GILP")))
        
        // No final LN blends
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "PILN")))
        
        storm.filterStops = false      // for INPUT and UNLIT
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNTIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PILOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INPUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TULIP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNLIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PINTO")))
        
        // No final NP blends
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GLINP")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POUTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POLLING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PULLING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOLLING")))
    }

    func test_2014Nov15_authEntic() {  //2014Nov15
        storm = WordStorm(outer: ["A", "U", "T", "H", "N", "T", "I", "C"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EACH")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEATH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TENTH")))        
    }

    func test_2014Oct22_Pesticide() {
        storm = WordStorm(outer: ["E", "S", "T", "I", "C", "I", "D", "E"], center: "P")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EPIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STEP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIED")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIECE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIECES")))
    }

    func test_2014Apr21_chainestY() {         // 21Apr2014
        storm = WordStorm(outer: ["C", "H", "A", "I", "N", "E", "S", "T"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EASY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YEAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASHY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACHY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YETI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STYE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YEAH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CYAN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HYENA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YETIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ITCHY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHINY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HASTY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCYTHE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NICETY")))

        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHANTEY")))
    }

    func test_2014Jun07_Squirrels() {
        storm = WordStorm(outer: ["Q", "U", "I", "R", "R", "E", "L", "S"], center: "S")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ESSLQ")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ISSLQ")))
    }
    
    func test_2014Jun26_skInflint() {
        storm = WordStorm(outer: ["S", "K", "N", "F", "L", "I", "N", "T"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KILN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIFT")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "IFTK")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "IFTN")))
    
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIFTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KILNS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INTLI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INTLS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ISTLI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INSKI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INSKL")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INSKT")))
    }
    
    func test_2014Jun09_bypassinG() {
        storm = WordStorm(outer: ["B", "Y", "P", "A", "S", "S", "I", "N"], center: "G")
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASSIGN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPYING")))
    }
    
    func test_2014Jun21_hAndballs() {
        storm = WordStorm(outer: ["H", "N", "D", "B", "A", "L", "L", "S"], center: "A")
        
        storm.gatherWords(4)
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLAH")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLAHS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BALSA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALAL")))
    }

    func test_2014Jun11_shiNbones() {
        storm = WordStorm(outer: ["S", "H", "I", "B", "O", "N", "E", "S"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNOB")))
    }
    
    func test_2014Jun14_Stalwarts() {
        storm = WordStorm(outer: ["T", "A", "L", "W", "A", "R", "T", "S"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWRS")))
    }
    
    func test_2014Jun23_psychotIc() {
        storm = WordStorm(outer: ["P", "S", "Y", "C", "H", "O", "T", "C"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TICS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ITCH")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "HISP")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TISP")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PSYCHIC")))
    }
    
    func test_2014Jun27_daStardly() {
        storm = WordStorm(outer: ["D", "A", "T", "A", "R", "D", "L", "Y"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ADDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRYS")))
        //        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TSAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLAY")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ATLAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRAYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STRAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YARDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SADLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SATYR")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALTARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASTRAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASTRAY")))
    }

    func test_2014Jul19_pReposses() {
        storm = WordStorm(outer: ["P", "E", "P", "O", "S", "S", "E", "S"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PROP")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PROPS")))
    }
    
    func test_2014Jul17_Overtaxed() {
        storm = WordStorm(outer: ["V", "E", "R", "T", "A", "X", "E", "D"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VETO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REDO")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DETOX")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OVERT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VORTEX")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEVOTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VETOED")))
    }
    
    func test_2015Apr29_Requiting() {
        storm = WordStorm(outer: ["E", "Q", "U", "I", "T", "I", "N", "G"], center: "R")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RINQE")))
    }
    
    func test_2014Jul02_binOcular() {
        storm = WordStorm(outer: ["B", "I", "N", "C", "U", "L", "A", "R"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOAN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACORN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BROIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COBRA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CURIO")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALBINO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAILOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OCULAR")))
    }
    
    func test_2014Jul14_stoDgiest() {
        storm = WordStorm(outer: ["S", "T", "O", "G", "I", "E", "S", "T"], center: "D")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ODES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SODS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIED")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DITTO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEIST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SITED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIETS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIGEST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DESIST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STODGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DITTOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEISTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOSSED")))
    }
    
    func test_2014Jul31_volTmeter() {
        storm = WordStorm(outer: ["V", "O", "L", "M", "E", "T", "E", "R"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEEM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TORT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "METE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOLT")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOTEM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TORTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OTTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOTEL")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MELTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "METEOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REMOTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "METTLE")))
    }

    func test_2014Jul03_Urologist() {
        storm = WordStorm(outer: ["R", "O", "L", "O", "G", "I", "S", "T"], center: "U")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OUTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OURS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OUST")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GROUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GUILT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOTUS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUITOR")))

        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLORIOUS")))
    }

    func test_2014Jul10_spOkesmen() {
        storm = WordStorm(outer: ["S", "P", "K", "E", "S", "M", "E", "N"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POEM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PESO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OMEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MONK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPEN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SMOKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPOKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POEMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POSSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MONKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEONS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPOKEN")))
    }
    
    func test_2014Jul28_calcifiEd() {
        storm = WordStorm(outer: ["C", "A", "L", "C", "I", "F", "I", "D"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLEA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DELI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEAF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LACE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDEAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DECAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIELD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FECAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LACED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AILED")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ICICLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEIFIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FACILE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AFIELD")))
    }
    
    func test_2014Jul07_clAvicles() {
        storm = WordStorm(outer: ["C", "L", "V", "I", "C", "L", "E", "S"], center: "A")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALIVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LILAC")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALLIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LILACS")))
    }
    
    func test_2014Jul29_saLacious() {
        storm = WordStorm(outer: ["S", "A", "A", "C", "I", "O", "U", "S"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SILO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOUL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COLS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALSO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LASS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOIL")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALIAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOCUS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COLAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALSA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COILS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASSAIL")))
    }
    
    func test_2014Aug26_Arduously() {
        storm = WordStorm(outer: ["R", "D", "U", "O", "U", "S", "L", "Y"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LADY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SODA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAUD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LARD")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "USUAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOLAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LARDY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARDUOUS")))
    }
    
    func test_2014Jul04_cherWoman() {
        storm = WordStorm(outer: ["C", "H", "E", "R", "O", "M", "A", "N"], center: "W")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANEW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHEW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRAW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WORM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WARM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHOM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHAM")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOMAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOMEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OWNER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CROWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COWER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOWER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WENCH")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WRENCH")))
    }
    
    func test_2014Aug27_lunardIly() {
        storm = WordStorm(outer: ["L", "U", "N", "A", "R", "D", "L", "Y"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDYL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LILY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RILL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAIN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAILY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAIRY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIARY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDYLL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LURID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAINY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARIDLY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LURIDLY")))
    }
    
    func test_2014Aug22_procupiNe() {
        storm = WordStorm(outer: ["P", "O", "R", "C", "U", "P", "I", "E"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UPON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ONCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CORN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NICE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INCUR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRUNE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OUNCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUNIC")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PURINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NIPPER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PINCER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POUNCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRINCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PUNIER")))
    }
    
    func test_2014Aug21_careTaker() {
        storm = WordStorm(outer: ["C", "A", "R", "E", "A", "K", "E", "R"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KART")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TACK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RATE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REACT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ERECT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KARAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EATER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RATER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CATER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRACK")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RETAKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AERATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ERRATA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CREATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRACER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRATER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RACKET")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CATERER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RETRACE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TERRACE")))
    }
    
    func test_2014Aug09_purveyiNg() {
        storm = WordStorm(outer: ["P", "U", "R", "V", "E", "Y", "I", "G"], center: "N")
        
        storm.filterStops = false   // for ENVY, UNRIG
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PUNY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PINY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENVY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NERVY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNRIG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIPEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIVEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEINY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PENURY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GURNEY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRYING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PREYING")))
    }
    
    func test_2014Aug28_cLawature() {
        storm = WordStorm(outer: ["C", "A", "W", "A", "T", "U", "R", "E"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EARL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CULT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLAW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CURL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LURE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEAL")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLEAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRAWL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRUEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUCRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRAWL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALERT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLARET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CARTEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CURLEW")))
    }
    
    func test_2014Aug06_disavOwed() {
        storm = WordStorm(outer: ["D", "I", "S", "A", "V", "W", "E", "D"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OWES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OWED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ODDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AVOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOAD")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AVOID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOSED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VOWED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIODE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOWED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AVOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AVOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIDEO")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VOIDED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AVOWED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AVOIDS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DISAVOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AVOIDED")))
    }

    func test_2014Aug02_filleTing() {
        storm = WordStorm(outer: ["F", "I", "L", "L", "E", "I", "N", "G"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FELT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LENT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GILT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GENT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TELL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LITE")))
        
        storm.filterStops = false   // try to generate LINLT
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INLET")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "LINLT")))
        
        storm.filterStops = true
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FINITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LENTIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TINGLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TILING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FELTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIFTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TILLING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LILTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TELLING")))
    }

    func test_2014Aug16_paRtially() {
        storm = WordStorm(outer: ["P", "A", "T", "I", "A", "L", "L", "Y"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAPT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRAY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ATRIA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RALLY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LARIAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARITY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARTLY")))
    }

    func test_2014Aug24_paviliOns() {
        storm = WordStorm(outer: ["P", "A", "V", "I", "L", "I", "N", "S"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOLI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOAP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OVAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIOL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PONS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIOLS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIOLA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIANO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPOIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOVAS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VISION")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIOLIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIANOS")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAVILION")))
    }

func test_2014Aug25_sunbuRned() {
        storm = WordStorm(outer: ["S", "U", "N", "B", "U", "N", "E", "D"], center: "R")
    
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BURS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRUB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BURN")))
    
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRUBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NUDER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NURSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUNES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RENDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BURNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNDER")))
    
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUNNER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NURSED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BURDEN")))
    
        storm.filterStops = false
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUNBURN")))
    
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNBURDEN")))
    }

    func test_2014Sep05_addIctive() {
        storm = WordStorm(outer: ["A", "D", "D", "C", "T", "I", "V", "E"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EDIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIVA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AVID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ICED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DICE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VICE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDEA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CITED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAVIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DICTA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EVICT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EDICT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ADDICT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CADDIE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIVIDE")))
    }

    func test_2014Sep25_quEasiest() {
        storm = WordStorm(outer: ["Q", "U", "A", "S", "I", "E", "S", "T"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EAST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EASE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SETA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEASE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUIET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUEST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASSET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EASES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUITE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUESTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EQUATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEASES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUITES")))
    }

    func test_2014Nov08_imbactUre() {
        storm = WordStorm(outer: ["I", "M", "B", "A", "C", "T", "R", "E"], center: "U")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "URIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CURT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CURB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TUBA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CUTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CUBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARUM")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMBUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACUTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CUBIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CUTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UMBER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRUCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRUMB")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RECTUM")))
    }

    func test_2014Nov21_refuLgent() {
        storm = WordStorm(outer: ["R", "E", "F", "U", "G", "E", "N", "T"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLEE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLEE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUNG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GULF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FURL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLUE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUNGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLUNG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLUTE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENGULF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GENTLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RELENT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUNGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLUENT")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GENTLER")))
    }

    func test_2014Nov22_yachTsman() {
        storm = WordStorm(outer: ["Y", "A", "C", "H", "S", "M", "A", "N"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TANS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANT")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHANT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCANT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YACHT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SATAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NASTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MATCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANTA")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASTHMA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNATCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCANTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHANTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANTAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YACHTS")))
    }

    func test_2014Nov02_perfumiNg() {
        storm = WordStorm(outer: ["P", "E", "R", "F", "U", "M", "I", "G"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FINE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FINER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMPUGN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FUMING")))
        
        storm.filterStops = false   // for GUNFIRE
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GUNFIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PERMING")))
    }
    
    func test_2014Nov12_brUsquely() {
        storm = WordStorm(outer: ["B", "R", "S", "Q", "U", "E", "L", "Y"], center: "U")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BUSY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BUYS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BURY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RULE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUBY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLUR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLUR")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BURLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BUYER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RULES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LURES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLURS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUERY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUBLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLUER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SURLY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUBLES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLUESY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SURELY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BUYERS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRUSQUE")))
    }
    
    func test_2014Dec26_Ancillary() {
        storm = WordStorm(outer: ["N", "C", "I", "L", "L", "A", "R", "Y"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CALL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RACY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YARN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LACY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAIC")))
        
        storm.filterStops = false    // for INLAY
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALLAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INLAY")))
        
        storm.filterStops = true
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANARY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRANIAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LYRICAL")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RACIALLY")))
    }
    
    func test_2014Dec05_cuLtivate() {
        storm = WordStorm(outer: ["C", "U", "T", "I", "V", "A", "T", "E"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TALE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EVIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LICE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VILE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TILT")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VITAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CALVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATTE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CATTLE")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATTICE")))
    }
    
    func test_2014Dec11_jackbOots() {
        storm = WordStorm(outer: ["J", "A", "C", "K", "B", "O", "T", "S"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOOK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COOK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOCK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JOBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JOTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JOCK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOAK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOCK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COOKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COAST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TACOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASCOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCOOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TABOO")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TABOOS")))
    }
    
    func test_2014Dec29_harShness() {
        storm = WordStorm(outer: ["H", "A", "R", "H", "N", "E", "S", "S"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RASH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SASH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HASH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SANE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ERAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SERA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHAH")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EARNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARSH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASHES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASHEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASSES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SANER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RHEAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHAHS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHARES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HASHES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RASHES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHEARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNARES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REHASH")))
    }
    
    func test_2014Dec13_paracHute() {
        storm = WordStorm(outer: ["P", "A", "R", "A", "C", "U", "T", "E"], center: "H")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHAP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HURT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PATH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEAP")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEART")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHEAP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PATCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEACH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHEAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REACH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEACH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RETCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHUTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HATER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PERCH")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARACHUTE")))
    }
    
    func test_2014Dec03_jettisOns() {
        storm = WordStorm(outer: ["J", "E", "T", "T", "I", "S", "N", "S"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ONES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JOIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOSS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TONE")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOSES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOTES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JOINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ONSET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JOINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TONES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOISE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STONES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ONSETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JOINTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOISES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOSIES")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOSIEST")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STONIEST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JETTISON")))
    }
    
    func test_2014Dec19_Equitably() {
        storm = WordStorm(outer: ["Q", "U", "I", "T", "A", "B", "L", "Y"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BELT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BYTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIEU")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAU")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BILE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BETA")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TIEU")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "LEAU")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TABLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLEAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLUEY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAUTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EQUITY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALBEIT")))

        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUIETLY")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EQUALITY")))
    }
    
    func test_2014Dec15_sHipboard() {
        storm = WordStorm(outer: ["S", "I", "P", "B", "O", "A", "R", "D"], center: "H")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHIP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HIPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HODS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HASP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DASH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BASH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POSH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHAD")))
        
        storm.filterStops = false       // for ABHOR
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAIRS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOARD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHARD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APHID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABHOR")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BISHOP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOARDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RADISH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APHIDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABHORS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARISH")))
    }
    
    func test_2014Dec21_forsWears() {
        storm = WordStorm(outer: ["F", "O", "R", "S", "E", "A", "R", "S"], center: "W")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AWES")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARROW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WORSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROWER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RESOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOWER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAWER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAWER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARROWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWEARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROWERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RESOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOWERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAWERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FARROW")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FORSWEAR")))
    }
    
    func test_2014Dec20_rAdiology() {
        storm = WordStorm(outer: ["R", "D", "I", "O", "L", "O", "G", "Y"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRAG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAD")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARGOL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RADIO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAILY")))
        
//        storm.gatherWords(9)
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RADIOLOGY")))
    }
    
    func test_2014Dec30_halItosis() {
        storm = WordStorm(outer: ["H", "A", "L", "T", "O", "S", "I", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SILT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HISS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SISAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LISTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOIST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SILOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SILTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HILTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOILS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOISTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATHIS")))
    }
    
    func test_2014Aug04_chOcolate() {
        storm = WordStorm(outer: ["C", "H", "C", "O", "L", "A", "T", "E"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COCA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COLA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COLT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOLT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOOL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COOL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OATH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHOC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALTO")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COCOA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COACH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOATH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OCTAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOTH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOTEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOACH")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOCHE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOATHE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLOTHE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOCATE")))
    }    
}
