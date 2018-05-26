//
//  Undated.swift
//  LexografikTests
//
//  Created by Jay Wright on 5/24/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import UIKit
import XCTest
import Lexografik

class LexografikTests_Undated: XCTestCase {
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
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "CREELD")))
        
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
    
    func test_firsTborn() {   // self-generated
        storm = WordStorm(outer: ["F", "I", "R", "S", "B", "O", "R", "N"], center: "T")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FIRST")))
    }
    
    func test_shOulders() {   // self-generated
        storm = WordStorm(outer: ["S", "H", "U", "L", "D", "E", "R", "S"], center: "O")
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOULD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHROUD")))
    }
    
    func test_strandIng() {  // self-generated
        storm = WordStorm(outer: ["S", "T", "R", "A", "N", "D", "N", "G"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STIR")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NADIR")))
    }
    
    func test_rEviewing() {
        storm = WordStorm(outer: ["R", "V", "I", "E", "W", "I", "N", "G"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VIEW")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RIEW")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GIEW")))
    }
    
    func test_Reamabled() {
        storm = WordStorm(outer: ["E", "A", "M", "A", "B", "L", "E", "D"], center: "R")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEARD")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BEERD")))
    }
    
    func test_surmisiNg() {
        storm = WordStorm(outer: ["S", "U", "R", "M", "I", "S", "I", "G"], center: "N")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GUNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GNUS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GIIN")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SIGNS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MINUS")))
    }
    
    func test_groaninGs() {
        storm = WordStorm(outer: ["G", "R", "O", "A", "N", "I", "N", "S"], center: "G")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGOG")))
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
    
    func test_wearIsome() {
        storm = WordStorm(outer: ["W", "E", "A", "R", "S", "O", "M", "E"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SARI")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EMIR")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AIRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWIM")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AERIE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "OSIER")))
    }
    
    func test_justifiEd() {
        storm = WordStorm(outer: ["J", "U", "S", "T", "I", "F", "I", "D"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "FEUD")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ITEF")))
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
        // XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "ULNA")))
        
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
    
    func test_cacOphany() {
        storm = WordStorm(outer: ["C", "A", "C", "P", "H", "A", "N", "Y"], center: "O")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CACAO")))
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
    
    func test_fUntastic() {
        storm = WordStorm(outer: ["F", "N", "T", "A", "S", "T", "I", "C"], center: "U")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SNAFU")))
    }
    
    func test_logIstics() {
        storm = WordStorm(outer: ["L", "O", "G", "S", "T", "I", "C", "S"], center: "I")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "STOIC")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "TISOC")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "CIOSS")))
    }
    
    func test_phOnogram() {
        storm = WordStorm(outer: ["P", "H", "N", "O", "G", "R", "A", "M"], center: "O")
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORPHAN")))
    }
}

