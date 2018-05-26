//
//  2016.swift
//  LexografikTests
//
//  Created by Jay Wright on 5/25/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import UIKit
import XCTest
import Lexografik

class LexografikTests_2016: XCTestCase {
    var storm: WordStorm!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_2016Jan06_hYperbola() {
        storm = WordStorm(outer: ["H", "P", "E", "R", "B", "O", "L", "A"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PLAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "YELP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RELY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BRAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PLOY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ABLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HYPE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROPY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POLY")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REPLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EARLY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RELAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REPAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAYER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HARPY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HYPER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BELAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BERYL")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "REPLAY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PLAYER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLEARY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARLEY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARELY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEARLY")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HYPERBOLA")))
    }
    
    func test_2016Jan23_aquEducts() {
        storm = WordStorm(outer: ["A", "Q", "U", "D", "U", "C", "T", "S"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "USED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DATE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CUED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CUES")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CASED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAUCE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DATES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAUSE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DUETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SATED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STEAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CADET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TUQUE")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CAUSED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SAUCED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CADETS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TUQUES")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AQUEDUCT")))
    }
    
    func test_2016Jan26_juvenileS() {
        storm = WordStorm(outer: ["J", "U", "V", "E", "N", "I", "L", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ISLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEES")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EVILS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LINES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JIVES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEILS")))
        
        storm.filterStops = false    // for ENVIES
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VENUES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SENILE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIVENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ENVIES")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELUSIVE")))

        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JUVENILES")))
    }
    
    func test_2016Jan24_uprootinG() {
        storm = WordStorm(outer: ["U", "P", "R", "O", "O", "T", "I", "N"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOOP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PONG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POGO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRIP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIRT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GROT")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GROUP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRUNT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRONG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GROIN")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OPTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROPING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PORING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRUING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POURING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TOURING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PORTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROOTING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROUTING")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TROUPING")))
    }
    
    func test_2016Jan30_Bellowing() {
        storm = WordStorm(outer: ["E", "L", "L", "O", "W", "I", "N", "G"], center: "B")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BONE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BELL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLEW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BILL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLOB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BONG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOIL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOLL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOWL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLIB")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLOWN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLOBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOBLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELBOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIBEL")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BINGE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BELOW")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BELONG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOWING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BILLOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BELLOW")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GOBLIN")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BLOWING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BELLING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOWLING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IGNOBLE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOLLING")))
        
        storm.gatherWords(8)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELBOWING")))
    }
}
