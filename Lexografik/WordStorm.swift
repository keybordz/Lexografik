//
//  WordStorm.swift
//  Lexografik
//
//  Created by Jay Wright on 1/25/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

class WordStorm {
    var outer: LetterArray
    var center: Letter
    var mask: LetterArray?
    var full: LetterArray
    var unique: [Letter] = []
    var sectionIndices = [String: Int]()
    var sectionTotals = [String:Int]()
    let filterVowels: Bool = false
    let filterUncommon: Bool = true
    var filterStops: Bool = true
    var wordSize = 4
    var wordCount: Int = 0
    var allWords: [LetterArray] = []
    
    init(outer: [String], center: String) {
        var outerLetters: [Letter] = []
        
        if let cLetter = Letter(rawValue: center) {
            self.center = cLetter
            self.full = LetterArray(initLetters: [self.center])
        }
        else {
            self.center = .A
            self.full = LetterArray(initLetters: [])
        }
        
        for letter in outer {
            if let eLetter = Letter(rawValue: letter) {
                outerLetters.append(eLetter)
            }
        }
        
        self.outer = LetterArray(initLetters: outerLetters)
        self.mask = nil;
        self.full.appendLetters(self.outer.letters)
        self.full.sortLetters()
        for letter in full.letters {
            if unique.index(of: letter) == nil {
                unique.append(letter)
                sectionIndices[letter.rawValue] = 0
                sectionTotals[letter.rawValue] = 0
            }
        }
    }
    
    init(outer: [String], center: String, mask: [String]) {
        var outerLetters: [Letter] = []
        var maskLetters: [Letter] = []
        
        if let cLetter = Letter(rawValue: center) {
            self.center = cLetter
            self.full = LetterArray(initLetters: [self.center])
        }
        else {
            self.center = .A
            self.full = LetterArray(initLetters: [])
        }
        
        for letter in outer {
            if let eLetter = Letter(rawValue: letter) {
                outerLetters.append(eLetter)
            }
        }
        
        for letter in mask {
            if let eLetter = Letter(rawValue: letter) {
                maskLetters.append(eLetter)
            }
        }
        
        self.outer = LetterArray(initLetters: outerLetters)
        self.mask = LetterArray(initLetters: maskLetters)
        self.full.appendLetters(self.outer.letters)
        self.full.sortLetters()
        for letter in full.letters {
            if unique.index(of: letter) == nil {
                unique.append(letter)
                sectionIndices[letter.rawValue] = 0
                sectionTotals[letter.rawValue] = 0
            }
        }
    }
    
    init(outer: [Letter], center: Letter) {
        self.outer = LetterArray(initLetters: outer)
        self.center = center
        self.mask = nil
        self.full = LetterArray(initLetters: [self.center])
        self.full.appendLetters(self.outer.letters)
        self.full.sortLetters()
        for letter in full.letters {
            if unique.index(of: letter) == nil {
                unique.append(letter)
                sectionIndices[letter.rawValue] = 0
                sectionTotals[letter.rawValue] = 0
            }
        }
    }
    
    func recurseWords(_ input: LetterArray, partialWord: LetterArray, length: Int) {
        
        if length <= 0 {
            allWords.append(partialWord)
            wordCount += 1
        }
            
        else {
            let topLevel = partialWord.letters.isEmpty
            
            for i in 0..<input.numLetters() {
                
                let c: Letter = input[i]
                
                if filterVowels && c.isVowel() && partialWord.hasNoLetters() {
                    continue
                }
                
                // skip duplicates
                if let _ = input.findLetter(c, startIndex: i + 1) {
                    continue
                }
                
                // if there's a mask field, check if the letter matches
                if mask != nil {
                    let maskLetter = mask?.letterAtPosition(self.wordSize - length)
                    if maskLetter != .any && maskLetter != c {
                        continue
                    }
                }
                
                // update the position index for each new character
                if topLevel {
                    sectionIndices[c.rawValue] = wordCount
                }
                
                // If we're about to pass a complete word (length is 1) and it doesn't have the key letter, forget about it
                if length == 1 && partialWord.findLetter(center) == nil && c != center {
                    continue
                }
                
                // Make a new copy of the current word
                let newPartialWord = LetterArray(initLetters: partialWord.letters)

                newPartialWord.sylState = partialWord.sylState
                newPartialWord.nextBias = partialWord.nextBias
                newPartialWord.expecting = partialWord.expecting
                newPartialWord.phonemes.replaceElements(partialWord.phonemes)
                newPartialWord.filterStops = partialWord.filterStops
                newPartialWord.exactMatches = partialWord.exactMatches
                
                // Does adding the new character maintain the "wordability" of the array
                if newPartialWord.testLexical(c, endOfWord: length == 1) {
                    newPartialWord.appendLetters([c])
                    newPartialWord.phonemes.final = true
                }
                else {
                    continue
                }
                
                let newInput = input.partial(0, toIndex: i)!
                let right = input.partial(i + 1)!
                newInput.appendLetters(right.letters)
                recurseWords(newInput, partialWord: newPartialWord, length: length - 1)
            }
        }
    }
    
    func gatherWords(_ wordLength: Int) {
        wordCount = 0
        
        let partialWord = LetterArray()
        partialWord.filterStops = filterStops
        recurseWords(full, partialWord: partialWord, length: wordLength)
        
        for word in allWords {
            word.printLetters()
            print(" (\(word.phonemes.numSyllables()) syllables)")
        }
        print("\(wordCount) words in total", terminator: "\n")
    }
}
