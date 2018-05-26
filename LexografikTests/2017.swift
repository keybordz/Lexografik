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
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DROP")))
        
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
}
