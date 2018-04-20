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

class LexografikTests: XCTestCase {
    var storm: WordStorm!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_cluttereD() {
        
        storm = WordStorm(outer: ["C", "L", "U", "T", "T", "E", "R", "E"], center: "D")
        
        // No liquid blends after double vowel
        storm.gatherWords(6)
//        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "CREELD")))
        
        storm.gatherWords(7)
        
        // U-consonant words
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UTTERED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ULCERED")))
    }
    
    func test_furbisHes() {
        storm = WordStorm(outer: ["F", "U", "R", "B", "I", "S", "E", "S"], center: "H")
        storm.gatherWords(5)
        
        // No plural of SH words
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BUSHS")))
        
        // No plural of RH words
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BERHS")))
        
        // No final EH
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "USSEH")))
        
        // do we have SUSHI
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUSHI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BUSHI")))
    }
    
//    func test_moonStone() {
//        storm = WordStorm(outer: ["M", "O", "O", "N", "T", "O", "N", "E"], center: "S")
//
//    }
    
    func test_bouffAnts() {
        storm = WordStorm(outer: ["B", "O", "U", "F", "F", "N", "T", "S"], center: "A")
        storm.gatherWords(4)
    
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OAFS")))
    }
    
    func test_sprayDish() {
        storm = WordStorm(outer: ["S", "P", "R", "A", "I", "S", "H", "Y"], center: "D")
        storm.gatherWords(4)
        
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAYS")))
        
    }
    
    func test_lumbErily() {
        storm = WordStorm(outer: ["L", "U", "M", "B", "I", "R", "L", "Y"], center: "E")

        // Assert final UE vowel combinations
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLUE")))
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMBUE")))
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
    
    func test_2012Aug01_undertaKe() {
        storm = WordStorm(outer: ["U", "N", "D", "E", "R", "T", "A", "E"], center: "K")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DARK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KNEE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TANK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KEEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REEK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUNK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RANK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TREK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEAK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NUKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DANK")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAKEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRANK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAKED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAKER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAKED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRUNK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRUNK")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRAKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KNEED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KNEAD")))
        
        // exceptions - no single vowel-K endings
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RADEK")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TENAK")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NETUK")))
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
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STIX")))
        
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
    
    func test_2012Sep16_squabbLes() {
        storm = WordStorm(outer: ["S", "Q", "U", "A", "B", "B", "E", "S"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LABS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LESS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLAB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BALE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LASS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BULB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLAB")))
        
        // No final B followers after E
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BLEB")))
        
        // No Q starters unless followed by U
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "QEAL")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "QELS")))
        
        // QU must have a blending vowel
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "QULE")))
        
        // No words ending in Q
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "LEAQ")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EQUAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SALES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BULBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLESS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BALES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SABLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BABEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLABS")))
        
        // If the singular E follower isn't allowed, the plural shouldn't be either
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BLEBS")))
        
        // No Q plurals
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "LEAQS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EQUALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SQUEAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAUBLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "USABLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLAQUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LASQUE")))
        
        // No interior Q's without U's
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ABLEQU")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "USQELS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "LASQUS")))
    }

    func test_2012Sep29_Reviewing() {
        storm = WordStorm(outer: ["E", "V", "I", "E", "W", "I", "N", "G"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GREW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WERE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WREN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EWER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEIR")))
        
        // No R blends with V
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "VRIG")))
        
        // No final N blends with W
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RENW")))
        
        // No WG blends
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "REWG")))
        
        // No IW dipthongs
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RIWN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GREEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VERGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RENEW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WRING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REIGN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIVER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIVEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEWER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NERVE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REVIEW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIEWER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRIEVE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WINGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WIRING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEERING")))
    }
    
    func test_rEviewing() {
        storm = WordStorm(outer: ["R", "V", "I", "E", "W", "I", "N", "G"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIEW")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RIEW")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GIEW")))
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
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "URGE")))
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
    
    func test_2012May05_coxSwains() {
        storm = WordStorm(outer: ["C", "O", "X", "S", "W", "A", "I", "N"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OWNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AXIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SANS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SACS")))
        
        // No words starting with X
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "XANS")))
        
        // No XS plurals
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "SAXS")))
        
        // No final SS after a consonant
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ANSS")))
        
        // No final SC except after I vowels
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NASC")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "WOSC")))
        
        // No final short SC plurals
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ASCS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWANS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCANS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ICONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AXONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SONIC")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OASIS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASINO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SONICS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWAINS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASINOS")))
    }

    func test_tHreesome() {   // self-generated
        storm = WordStorm(outer: ["T", "R", "E", "E", "S", "O", "M", "E"], center: "H")
    
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THREE")))
    }
    
    func test_firsTborn() {   // self-generated
        storm = WordStorm(outer: ["F", "I", "R", "S", "B", "O", "R", "N"], center: "T")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIRST")))
    }
    
    func test_preOpeant() {   // self-generated
        storm = WordStorm(outer: ["P", "R", "E", "P", "E", "A", "N", "T"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRON")))
    }
    
    func test_shOulders() {   // self-generated
        storm = WordStorm(outer: ["S", "H", "U", "L", "D", "E", "R", "S"], center: "O")
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOULD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHROUD")))
    }
    
    func test_2012Sep16_struGgles() {   //2012Sep16
        storm = WordStorm(outer: ["S", "T", "R", "U", "G", "L", "E", "S"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EGGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLUG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLUE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GUST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "URGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TUGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GELS")))
        
        // No liquid blends without final E
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RUGL")))
    
        // No double G's at the end
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TUGG")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GUEST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GUESS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SURGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLUGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GUSTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "URGES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUGES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRUEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLUTS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GUESTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GURGLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SURGES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRUELS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUGGEST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GURGLES")))
    
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STRUGGLE")))
    }

    func test_2013Feb18_passCetty() {   //2013Feb18
        storm = WordStorm(outer: ["P", "A", "S", "S", "E", "T", "T", "Y"], center: "C")
        
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
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PACT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SECT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SACS")))
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
    
    func test_2012Sep21_shOemaker() {  //2012Sep21
        storm = WordStorm(outer: ["S", "H", "E", "M", "A", "K", "E", "R"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMOK")))
    }
    
    func test_2012Sep04_tHickened() {  //2012Sep04
        storm = WordStorm(outer: ["T", "I", "C", "K", "E", "N", "E", "D"], center: "H")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ETCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THEE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DITCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NICHE")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "KECTH")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INCHED")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "CHEEKI")))
    }
    
    func test_2014Nov15_authEntic() {  //2014Nov15
        storm = WordStorm(outer: ["A", "U", "T", "H", "N", "T", "I", "C"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EACH")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEATH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TENTH")))        
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
    
    func test_2011May03_chromaTic() {
        storm = WordStorm(outer: ["C", "H", "R", "O", "M", "A", "I", "C"], center: "T")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CACTI")))
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
    
    func test_strandIng() {  // self-generated
        storm = WordStorm(outer: ["S", "T", "R", "A", "N", "D", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STIR")))
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NADIR")))
    }
    
    func test_22Oct2014_Pesticide() {
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

    func test_01Sep2013_academIes() {
        storm = WordStorm(outer: ["A", "C", "A", "D", "E", "M", "E", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DISC")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEISM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEICE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEDIA")))
    }
    
    func test_05Oct2012_crocodIle() {
        storm = WordStorm(outer: ["C", "R", "O", "C", "O", "D", "L", "E"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OLIO")))
    }
    
    func test_20Nov2012_compLexes() {
        storm = WordStorm(outer: ["C", "O", "M", "P", "E", "X", "E", "S"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELSE")))

        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELOPE")))
    }
    
    func test_Reamabled() {
        storm = WordStorm(outer: ["E", "A", "M", "A", "B", "L", "E", "D"], center: "R")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEARD")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BEERD")))
    }
    
    func test_beaUtiful() {
        storm = WordStorm(outer: ["B", "E", "A", "T", "I", "F", "U", "L"], center: "U")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAU")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIEU")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLUB")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "LEAU")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TIEU")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "FLEB")))
    }
    
    func test_08Apr2013_truantIng() {      // 08Apr2013
        storm = WordStorm(outer: ["T", "R", "U", "A", "N", "T", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANTI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TIGN")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NITT")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RINN")))
    }
    
    func test_surmisiNg() {
        storm = WordStorm(outer: ["S", "U", "R", "M", "I", "S", "I", "G"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNUS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GIIN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIGNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINUS")))
    }
    
    func test_03Apr2013_fReckling() {
        storm = WordStorm(outer: ["F", "E", "C", "K", "L", "I", "N", "G"], center: "R")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ERGLK")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RINLK")))
    }
    
    func test_07Apr2013_sorrowiNg() {       // 07Apr2013
        storm = WordStorm(outer: ["S", "O", "R", "R", "O", "W", "I", "G"], center: "N")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INGOO")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ORIRN")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "WRORN")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WOOING")))
    }
    
    func test_17Nov2013_hankerIng() {        // 17Nov2013
        storm = WordStorm(outer: ["H", "A", "N", "K", "E", "R", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAKI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NIGH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AKIN")))
    
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INNEA")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RINEG")))
    }
    
    func test_groaninGs() {
        storm = WordStorm(outer: ["G", "R", "O", "A", "N", "I", "N", "S"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGOG")))
    }
    
//    func test_17Dec2011_coaguLant() {
//        storm = WordStorm(outer: ["C", "O", "A", "G", "U", "A", "N", "T"], center: "L")
//        
//        storm.gatherWords(4)
//    }
    
    func test_encouraGe() {
        storm = WordStorm(outer: ["E", "N", "C", "O", "U", "R", "A", "E"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OGRE")))
    }
    
    func test_embossinG() {
        storm = WordStorm(outer: ["E", "M", "B", "O", "S", "S", "I", "N"], center: "G")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNOME")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNOMES")))
    }
    
    func test_yEarnings() {
        storm = WordStorm(outer: ["Y", "A", "R", "N", "I", "N", "G", "S"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NEAY")))
    }
    
    func test_vocatIons() {
        storm = WordStorm(outer: ["V", "O", "C", "A", "T", "O", "N", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "COOI")))
    }
    
    func test_09Jun2011_pedigreeD() {
        storm = WordStorm(outer: ["P", "E", "D", "I", "G", "R", "E", "E"], center: "D")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DREG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EDGE")))
    }
    
    func test_wearIsome() {
        storm = WordStorm(outer: ["W", "E", "A", "R", "S", "O", "M", "E"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SARI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIRE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AERIE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OSIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOIRE")))
    }
    
    func test_justifiEd() {
        storm = WordStorm(outer: ["J", "U", "S", "T", "I", "F", "I", "D"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEUD")))
        // XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STEF")))   is that really a word?
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ITEF")))
    }
    
    func test_01Jun2011_heaLthily() {
        storm = WordStorm(outer: ["H", "E", "A", "T", "H", "I", "L", "Y"], center: "L")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATHI")))
    }
    
    func test_12Jun2011_Crediting() {
        storm = WordStorm(outer: ["R", "E", "D", "I", "T", "I", "N", "G"], center: "C")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NITCE")))
    }
    
    func test_04Jun2011_Amazingly() {
        storm = WordStorm(outer: ["M", "A", "Z", "I", "N", "G", "L", "Y"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAZY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ZANY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MYNA")))
    }
    
    func test_02Jun2011_inScribes() {
        storm = WordStorm(outer: ["I", "N", "S", "C", "R", "I", "B", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IBIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRIS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NISC")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BINC")))
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BIRCS")))
    }
    
    func test_logIstics() {
        storm = WordStorm(outer: ["L", "O", "G", "S", "T", "I", "C", "S"], center: "I")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOIC")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TISOC")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "CIOSS")))
    }
    
    func test_30Jun2011_vainglorY() {             // 30Jun2011
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
    
    func test_13Jun2011_commonErs() {        // 13Jun2011
        storm = WordStorm(outer: ["C", "O", "M", "M", "O", "N", "R", "S"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROES")))
    }
    
    func test_remItters() {
        storm = WordStorm(outer: ["R", "E", "M", "T", "T", "E", "R", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MITT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIES")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIERS")))
    }
    
    func test_Terminals() {
        storm = WordStorm(outer: ["E", "R", "M", "I", "N", "A", "L", "S"], center: "T", filterStops: false)
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INLET")))
    }
    
    func test_23Apr2015_severallY() {
        storm = WordStorm(outer: ["S", "E", "V", "E", "R", "A", "L", "L"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LYRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AYES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EYES")))
    }
    
    func test_27Jun2011_cookerieS() {
        storm = WordStorm(outer: ["C", "O", "O", "K", "E", "R", "I", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORCS")))
    }
    
    func test_14May2011_employeeS() {         // 14May2011
        storm = WordStorm(outer: ["E", "M", "P", "L", "O", "Y", "E", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ESPY")))
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
    
    func test_30May2011_mandatOry() {
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
    
    func test_04May2011_broomdiSh() {         // 04May2011
        storm = WordStorm(outer: ["B", "R", "O", "O", "M", "D", "I", "H"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOBS")))
    }
        
    func test_29Apr2015_Requiting() {
        storm = WordStorm(outer: ["E", "Q", "U", "I", "T", "I", "N", "G"], center: "R")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RINQE")))
    }
    
    func test_fUntastic() {
        storm = WordStorm(outer: ["F", "N", "T", "A", "S", "T", "I", "C"], center: "U")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNAFU")))
    }
    
    func test_17May2011_rigmarOle() {
        storm = WordStorm(outer: ["M", "A", "R", "R", "I", "G", "L", "E"], center: "O")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMAGO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOIRE")))
    }
    
    func test_21Apr2014_chainestY() {         // 21Apr2014
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

    func test_triyearlY() {
        storm = WordStorm(outer: ["T", "R", "I", "Y", "E", "A", "R", "L"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "YYER")))
    }
    
    func test_Ambulance() {
        storm = WordStorm(outer: ["M", "B", "U", "L", "A", "N", "C", "E"], center: "A", filterStops: true)
        
        storm.gatherWords(4)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ACME")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ACNE")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ULNA")))
        
        storm.filterStops = false
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACNE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ULNA")))
    }
    
    func test_amplifiEs() {
        storm = WordStorm(outer: ["M", "P", "L", "I", "F", "I", "A", "S"], center: "E")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMPLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AISLE")))
    }
    
    func test_sCorching() {
        storm = WordStorm(outer: ["S", "O", "R", "C", "H", "I", "N", "G"], center: "C")
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNOCCHI")))
    }
    
    func test_unishaKer() {
        storm = WordStorm(outer: ["U", "N", "I", "S", "H", "A", "E", "R"], center: "K")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAIKU")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAIKUS")))
    }

    func test_fOrtunate() {
        storm = WordStorm(outer: ["F", "R", "T", "U", "N", "A", "T", "E"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOFU")))
    }
    
    func test_shuTtered() {
        storm = WordStorm(outer: ["S", "H", "U", "T", "E", "R", "E", "D"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THRU")))

        storm.gatherWords(6)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TTHREE")))
    }
        
    func test_Columnist() {
        storm = WordStorm(outer: ["O", "L", "U", "M", "N", "I", "S", "T"], center: "C")
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COLUMN")))
    }
    
    func test_28May2011_immersiNg() {
        storm = WordStorm(outer: ["I", "M", "M", "E", "R", "S", "I", "G"], center: "N")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GENMR")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RENMG")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "MIENI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NIRGI")))
    }
    
    func test_28Jun2014_Beverages() {
        storm = WordStorm(outer: ["E", "V", "E", "R", "A", "G", "E", "S"], center: "B")
        
        storm.gatherWords(4)
        
        // Verify plural for final A
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRAS")))
    }
    
    func test_siGhtings() {
        storm = WordStorm(outer: ["S", "I", "H", "T", "I", "N", "G", "S"], center: "G")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NIGHT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIGHT")))
        
        // Make sure GH can plural
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIGHS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NIGHTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIGHTS")))
        
        // ending restrictions on IGH
//        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "SISIGH")))
//        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "SITIGH")))
        
        // ending restrictions on IG
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NISSIG")))
    }
    
    func test_naugHtier() {
        storm = WordStorm(outer: ["N", "A", "U", "G", "T", "I", "E", "R"], center: "H")
        
        storm.gatherWords(4)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AGHN")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AGHT")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "IGHN")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "UGHN")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "UGHR")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "UGHT")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EIGHT")))
    }
    
    func test_15May2011_wAyfaring() {
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
    
    func test_03May2011_cHopstick() {
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
    
    func test_07Jun2014_Squirrels() {
        storm = WordStorm(outer: ["Q", "U", "I", "R", "R", "E", "L", "S"], center: "S")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ESSLQ")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ISSLQ")))
    }
    
    func test_26Jun2014_skInflint() {
        storm = WordStorm(outer: ["S", "K", "N", "F", "L", "I", "N", "T"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KILN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KILN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIFT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIFT")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "IFTK")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "IFTN")))
    
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIFTS")))
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KILNS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INTLI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INTLS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ISTLI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INSKI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INSKL")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "INSKT")))
    }
    
    func test_09Jun2014_bypassinG() {
        storm = WordStorm(outer: ["B", "Y", "P", "A", "S", "S", "I", "N"], center: "G")
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASSIGN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPYING")))
    }
    
    func test_21Jun2014_hAndballs() {
        storm = WordStorm(outer: ["H", "N", "D", "B", "A", "L", "L", "S"], center: "A")
        
        storm.gatherWords(4)
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLAH")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLAHS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BALSA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HALAL")))
    }

    func test_11Jun2014_shiNbones() {
        storm = WordStorm(outer: ["S", "H", "I", "B", "O", "N", "E", "S"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNOB")))
    }
    
    func test_14Jun2014_Stalwarts() {
        storm = WordStorm(outer: ["T", "A", "L", "W", "A", "R", "T", "S"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "AWRS")))
    }
    
    func test_02Dec2011_stolIdity() {
        storm = WordStorm(outer: ["S", "T", "O", "L", "D", "I", "T", "Y"], center: "I")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDIOT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDIOTS")))
    }
}
