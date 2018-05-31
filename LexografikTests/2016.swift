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
    
    func test_2016Jan14_Parodying() {
        storm = WordStorm(outer: ["A", "R", "O", "D", "Y", "I", "N", "G"], center: "P")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "POND")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DROP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAID")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PONY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRIP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PORN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PANG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRIG")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APRON")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "APING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAPID")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RAPING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARODY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DOPING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARDON")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRAYING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DRAPING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PRODIGY")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARODYING")))
    }
    
    func test_2016Jan01_Triptychs() {
        storm = WordStorm(outer: ["R", "I", "P", "T", "Y", "C", "H", "S"], center: "T")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PITY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIPS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHIRT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PITCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SPIRT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CHITS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRYST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STRIP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TIPSY")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STITCH")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TYPIST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THIRST")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHIRTY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STRIPY")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "THIRSTY")))
        
//        storm.gatherWords(8)
//        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TRIPTYCH")))
    }
    
    func test_2016Jan02_Interwove() {
        storm = WordStorm(outer: ["N", "T", "E", "R", "W", "O", "V", "E"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TWIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WRIT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WIVE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TWINE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WRITE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INERT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIVET")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OVINE")))
        
        storm.filterStops = false
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TWINER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WINTER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INVERT")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INTERWOVE")))
    }
    
    func test_2016Jan09_expiatiNg() {
        storm = WordStorm(outer: ["E", "X", "P", "I", "A", "T", "I", "G"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEXT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PANT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NEAP")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PEIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PANE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NAPE")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PAINT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AXING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INEPT")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "INAPT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAXING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAPING")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXITING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "TAXIING")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EXPIATING")))
    }
    
    func test_2016Jan10_milkinEss() {
        storm = WordStorm(outer: ["M", "I", "L", "K", "I", "N", "S", "S"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MESS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MILE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ELKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "KENS")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIMES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIKEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MILES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIKES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SMILE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLIME")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SKEIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MIKES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINKE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SKIES")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SMILES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LIKENS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SILKEN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SLIMES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SKEINS")))
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MISSILE")))
        
        storm.gatherWords(9)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MILKINESS")))
    }
}
