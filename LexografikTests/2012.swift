//
//  2012.swift
//  LexografikTests
//
//  Created by Jay Wright on 5/24/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import UIKit
import XCTest
import Lexografik

class LexografikTests_2012: XCTestCase {
    var storm: WordStorm!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
        //        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BLEBS")))
        
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
    
    func test_2012Oct05_crocodIle() {
        storm = WordStorm(outer: ["C", "R", "O", "C", "O", "D", "L", "E"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OLIO")))
    }
    
    func test_2012Nov20_compLexes() {
        storm = WordStorm(outer: ["C", "O", "M", "P", "E", "X", "E", "S"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELSE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELOPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXCEL")))
    }
    
    func test_2012Mar28_mainGames() {
        storm = WordStorm(outer: ["M", "A", "I", "N", "A", "M", "E", "S"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SANG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GEMS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAGA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNAG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAIN")))
        
        storm.filterStops = false
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMAGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SINGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAGMA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAMMA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGAIN")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENIGMA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAGMAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAMMAS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENIGMAS")))
    }
    
    func test_2012Mar15_archanGel() {
        storm = WordStorm(outer: ["A", "R", "C", "H", "A", "N", "E", "L"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRAG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GALA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GALE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAGE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALGAE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLANG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LARGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REGAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RANGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAGER")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "REAGH")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "LARGH")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REHANG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANGLER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHANGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HANGAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HANGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLANCE")))
    }
    
    func test_2012Mar01_Extremity() {
        storm = WordStorm(outer: ["X", "T", "R", "E", "M", "I", "T", "Y"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TERM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TEXT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ITEM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIER")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMERY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "METER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REMIX")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXERT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REMIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIXER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MERIT")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "MIREX")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RETIX")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TERMITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMITTER")))
    }
    
    func test_2012Mar06_toolbOxes() {
        storm = WordStorm(outer: ["T", "O", "O", "L", "B", "X", "E", "S"], center: "O")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOLO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OBOE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLOE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOLT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLOB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OXES")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "STOX")))
        //        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "OXET")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OBOES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOXES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOLTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLOTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOBES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXTOL")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "MIREX")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RETIX")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXTOLS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOOLBOX")))
    }
    
    func test_2012Mar20_calibraGe() {
        storm = WordStorm(outer: ["C", "A", "L", "I", "B", "R", "A", "E"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIRL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLIB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BERG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRAG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAGE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARGIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CIGAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGILE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BAGEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BILGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRACE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GERBIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GARBLE")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REGALIA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLACIER")))
    }
    
    func test_2012Mar13_Muttering() {
        storm = WordStorm(outer: ["U", "T", "T", "E", "R", "I", "N", "G"], center: "M")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MENU")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRIM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GERM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MUTT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MUTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MITT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIMER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MUTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRIME")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINUET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINUTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MITTEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MUTTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MUTING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINUTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TERMING")))
    }
    
    func test_2012Mar31_Affecting() {
        storm = WordStorm(outer: ["F", "F", "E", "C", "T", "I", "N", "G"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAIF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FANG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAFF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FACE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAFFE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FAINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FACET")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AFFECT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FACING")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EFFACING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FACETING")))
    }
    
    func test_2012Mar24_eMbargoed() {
        storm = WordStorm(outer: ["E", "B", "A", "R", "G", "O", "E", "D"], center: "M")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MADE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MODE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BERM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEEM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MERE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRAM")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMBER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMBER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARMED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DREAM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MERGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMBED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAMER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAMED")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEAMED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROAMED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REMADE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MERGED")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMBARGO")))
    }
    
    func test_2012Mar12_jaundIces() {
        storm = WordStorm(outer: ["J", "A", "U", "N", "D", "C", "E", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DAIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ICES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DINS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "DIJE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDEAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANISE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JUICE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SINCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DINES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DICES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNIDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIDES")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JUICED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JUICES")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JAUNDICE")))
    }
    
    func test_2012Apr17_Barnstorm() {
        storm = WordStorm(outer: ["A", "R", "N", "S", "T", "O", "R", "M"], center: "B")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BORN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STAB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRAT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TABS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOMB")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARBOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BATON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOAST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABORT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOARS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOMBS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARBORS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BATONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABORTS")))
    }
    
    func test_2012Apr25_arBormute() {
        storm = WordStorm(outer: ["A", "R", "O", "R", "M", "U", "T", "E"], center: "B")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BURR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TUBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUBE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABOUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TABOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUMBA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TUBER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TURBO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRUTE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REBUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BORER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARTER")))
    }
    
    func test_2012Apr21_superIors() {
        storm = WordStorm(outer: ["S", "U", "P", "E", "R", "O", "R", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIPS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RISE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PISS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIRE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRIOR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POISE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIOUS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIPER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RISER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PIERS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROSIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROPIER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RISERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POSIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPIRES")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SURPRISE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUPERIOR")))
    }
    
    func test_2012May31_branchIng() {
        storm = WordStorm(outer: ["B", "R", "A", "N", "C", "H", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RICH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRIB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INCH")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHINA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHAIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CABIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BIRCH")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARCING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ACHING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RACING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARCHING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRACING")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RANCHING")))
    }
    
    func test_2012May28_Phoneture() {
        storm = WordStorm(outer: ["H", "O", "N", "E", "T", "U", "R", "E"], center: "P")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POUR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PORT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PURE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PERT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PUNT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PENT")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ERUPT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PREEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PHONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PETER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PUREE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUPEE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROUPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPENER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POUTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REPENT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PUNTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REPUTE")))
    }
    
    func test_2012May23_flyweighT() {
        storm = WordStorm(outer: ["F", "L", "Y", "W", "E", "I", "G", "H"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WITH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TWIG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TILE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HILT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WELT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WILT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THEW")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WITHE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EIGHT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIGHT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIGHT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THIEF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FILTH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LITHE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEFTY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EIGHTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLIGHT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEIGHT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FILTHY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEIGHTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLIGHTY")))
    }
    
    func test_2012May22_journEyed() {
        storm = WordStorm(outer: ["J", "O", "U", "R", "N", "Y", "E", "D"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUDE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RODE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EYED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUNE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JOEY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DYER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DYNE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DENY")))
        
        storm.filterStops = false       // for ENJOY
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ERODE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENJOY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENURE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REEDY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEEDY")))
        
        storm.filterStops = true
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENDURE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YONDER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REDONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENURED")))
        
        storm.filterStops = false
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JOURNEY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENJOYED")))
    }
    
    func test_2012May19_trialliNg() {
        storm = WordStorm(outer: ["T", "R", "I", "A", "L", "L", "I", "G"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TARN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RANT")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNARL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRANT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALIGN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRAIN")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIRING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RATING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AILING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIRING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAILING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAILING")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRAILING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRILLING")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIALLING")))
    }
    
    func test_2012May10_gEography() {
        storm = WordStorm(outer: ["G", "O", "G", "R", "A", "P", "H", "Y"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REAP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PREY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GORE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PYRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPERA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAYER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAYER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GROPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GORGE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOPHER")))
    }
    
    func test_2012May09_elauNcher() {
        storm = WordStorm(outer: ["E", "L", "A", "U", "C", "H", "E", "R"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EARN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNCLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLEAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUNCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CRANE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEARN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LUNAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HENCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHURN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LANCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RENAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CANER")))
        
        storm.filterStops = false       // for UNLACE, UNREAL
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAREEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEANER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LANCER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNREAL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNLACE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAUNCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEURAL")))
        
        storm.filterStops = true
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UNCLEAR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NUCLEAR")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAUNCHER")))
    }
    
    func test_2012May13_notoRious() {
        storm = WordStorm(outer: ["N", "O", "T", "O", "I", "O", "U", "S"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TURN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROUT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SORT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOUR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOUR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TORN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUNT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TORS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROOTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TURNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TORSO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROOST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIOTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOURS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUNTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROUTS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUITOR")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NITROUS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIOTOUS")))
    }
    
    func test_2012Jun27_maInframe() {
        storm = WordStorm(outer: ["M", "A", "N", "F", "R", "A", "M", "E"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FAIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIRM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAIM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMAM")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AFIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AMINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MARIA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAFIA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MANIA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIMER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REMAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FAMINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MARINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MAIMER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANEMIA")))
    }
    
    func test_2012Jun14_Scaffolds() {
        storm = WordStorm(outer: ["C", "A", "F", "F", "O", "L", "D", "S"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOSS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOLD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OAFS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OFFS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOFA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SOFAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOAFS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOALS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CODAS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLASS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FOLDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCOFF")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCOLD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCALD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "COLDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FLOSS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOFFS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOADS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CLODS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCOFFS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCALDS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCOLDS")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SCAFFOLD")))
    }
    
    func test_2012Dec21_boWshines() {
        storm = WordStorm(outer: ["B", "O", "S", "H", "I", "N", "E", "S"], center: "W")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WISH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WISE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WEBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HEWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WINO")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WINES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWISH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SINEW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHOSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WINOS")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WISHES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WHINES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SINEWS")))
    }
    
    func test_2012Dec04_sequesteR() {
        storm = WordStorm(outer: ["S", "E", "Q", "U", "E", "S", "T", "E"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TREE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TREES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "USERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RESTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUSTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RESET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STEER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUSES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TERSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRUSS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRESS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ESTER")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RESETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUEERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STEERS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RUSSET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REUSES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SUREST")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REQUEST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUESTER")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REQUESTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "QUEEREST")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SEQUESTER")))
    }
    
    func test_2012Dec17_Assisting() {
        storm = WordStorm(outer: ["S", "S", "I", "S", "T", "I", "N", "G"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STAG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SATI")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STAGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SATIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNATS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GAITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNAGS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANTIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SATIS")))
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ANGST")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASSIST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAINTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STAINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SATINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIANTS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SATING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STASIS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ASSIGNS")))
    }
    
    func test_2012Dec28_mooNlight() {
        storm = WordStorm(outer: ["M", "O", "O", "L", "I", "G", "H", "T"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ONTO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TONG")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INGOT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THONG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MONTH")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOTION")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOTION")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOOING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOMING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOOLING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HOOTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOOTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOOMING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LOOTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOLTING")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MONOLITH")))
        
        storm.filterStops = false
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOONLIGHT")))
    }
}
