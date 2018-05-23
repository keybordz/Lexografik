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
    
    func test_surmisiNg() {
        storm = WordStorm(outer: ["S", "U", "R", "M", "I", "S", "I", "G"], center: "N")
        
        storm.gatherWords(4)
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
    
    func test_hAmburger() {         // May2011
        storm = WordStorm(outer: ["H", "M", "B", "U", "R", "G", "E", "R"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RHEA")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "UREA")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AUGER")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ARGUE")))
    }
    
    func test_2011May03_chromaTic() {       // Date??
        storm = WordStorm(outer: ["C", "H", "R", "O", "M", "A", "I", "C"], center: "T")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CACTI")))
    }

    func test_2011May03_cHopstick() {       // Date??
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
    
    func test_2011May15_wAyfaring() {
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
    
    func test_2011May28_immersiNg() {
        storm = WordStorm(outer: ["I", "M", "M", "E", "R", "S", "I", "G"], center: "N")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "GENMR")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RENMG")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "MIENI")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NIRGI")))
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
    
    func test_2011Jun09_pedigreeD() {
        storm = WordStorm(outer: ["P", "E", "D", "I", "G", "R", "E", "E"], center: "D")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DREG")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EDGE")))
    }
    
    func test_2011Jun01_heaLthily() {
        storm = WordStorm(outer: ["H", "E", "A", "T", "H", "I", "L", "Y"], center: "L")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LATHI")))
    }
    
    func test_2011Jun12_Crediting() {
        storm = WordStorm(outer: ["R", "E", "D", "I", "T", "I", "N", "G"], center: "C")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NITCE")))
    }
    
    func test_2011Jun04_Amazingly() {
        storm = WordStorm(outer: ["M", "A", "Z", "I", "N", "G", "L", "Y"], center: "A")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LAZY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ZANY")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MYNA")))
    }
    
    func test_2011Jun02_inScribes() {
        storm = WordStorm(outer: ["I", "N", "S", "C", "R", "I", "B", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IBIS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRIS")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "NISC")))
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BINC")))
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "BIRCS")))
    }
    
    func test_2011Jun30_vainglorY() {
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
    
    func test_2011Jun13_commonErs() {
        storm = WordStorm(outer: ["C", "O", "M", "M", "O", "N", "R", "S"], center: "E")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EONS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "NOES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ROES")))
    }
    
    func test_2015Apr23_severallY() {
        storm = WordStorm(outer: ["S", "E", "V", "E", "R", "A", "L", "L"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LYRE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AYES")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EYES")))
    }
    
    func test_2011Jun27_cookerieS() {
        storm = WordStorm(outer: ["C", "O", "O", "K", "E", "R", "I", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IRKS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ORCS")))
    }
    
    func test_2011May14_employeeS() {         // 14May2011
        storm = WordStorm(outer: ["E", "M", "P", "L", "O", "Y", "E", "E"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "EELS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ESPY")))
    }
    
    func test_2011May30_mandatOry() {
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
    
    func test_2011May04_broomdiSh() {         // 04May2011
        storm = WordStorm(outer: ["B", "R", "O", "O", "M", "D", "I", "H"], center: "S")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SHOO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BOOS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RIBS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOBS")))
    }
    
    func test_2015Apr29_Requiting() {
        storm = WordStorm(outer: ["E", "Q", "U", "I", "T", "I", "N", "G"], center: "R")
        
        storm.gatherWords(5)
        XCTAssertFalse(storm.allWords.contains(LetterArray(initString: "RINQE")))
    }
    
    func test_2011May17_rigmarOle() {
        storm = WordStorm(outer: ["M", "A", "R", "R", "I", "G", "L", "E"], center: "O")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IMAGO")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MOIRE")))
    }
    
    func test_2011Dec13_scaffoLds() {
        storm = WordStorm(outer: ["S", "C", "A", "F", "F", "O", "D", "S"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "CALF")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LASSO")))
    }
    
    func test_2011Dec16_jaBbering() {
        storm = WordStorm(outer: ["J", "A", "B", "E", "R", "I", "N", "G"], center: "B")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GIBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "JIBE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GARB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GRAB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BARB")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEGIN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "BEING")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "RABBI")))
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
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PACT")))
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

    func test_2013Sep01_academIes() {
        storm = WordStorm(outer: ["A", "C", "A", "D", "E", "M", "E", "S"], center: "I")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DISC")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEISM")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "DEICE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "MEDIA")))
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
    
    func test_2011Dec02_stolIdity() {
        storm = WordStorm(outer: ["S", "T", "O", "L", "D", "I", "T", "Y"], center: "I")
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDIOT")))
        
        storm.gatherWords(6)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDIOTS")))
    }
    
    func test_2011Dec17_coaguLant() {
        storm = WordStorm(outer: ["C", "O", "A", "G", "U", "A", "N", "T"], center: "L")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALGA")))
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

    func test_2013Feb14_cordiallY() {
        storm = WordStorm(outer: ["C", "O", "R", "D", "I", "A", "L", "L"], center: "Y")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "IDLY")))
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
    
    func test_2014Jul19_pReposses() {
        storm = WordStorm(outer: ["P", "E", "P", "O", "S", "S", "E", "S"], center: "R")
        
        storm.gatherWords(4)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PROP")))
        
        storm.gatherWords(5)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PROPS")))
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
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "WINS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWAB")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "HAWS")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "SWAN")))
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
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEAN")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LEAD")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "AGED")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "LADE")))
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "ALEE")))
        
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
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "VEAL")))
        
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
        
        storm.gatherWords(7)
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "PARTIAL")))
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
        XCTAssertTrue(storm.allWords.contains(LetterArray(initString: "GLEAN")))
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
}
