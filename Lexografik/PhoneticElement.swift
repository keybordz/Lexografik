//
//  PhoneticElement.swift
//  Lexografik
//
//  Created by Jay Wright on 2/9/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

enum PositionIndicator: Int {
    case positionFIRST = 0
    case positionMIDDLE = 1
    case positionLAST = 2
}

class PhoneticElement {
    let id: String
    let first: Letter
    let second: Letter?
    let third: Letter?
    let numLetters: Int             // Number of letters in the id string
    let canStart: Bool
    let canEnd: Bool
    let canPlural: Bool
    let dynFollowers: ((SyllabicArray, PositionIndicator) -> [Letter])?
    var verifyEndOfWord: ((PhoneticElementArray) -> Bool)?
    
    init(first: Letter, second: Letter?, third: Letter?,
         canStart: Bool, canEnd: Bool, canPlural: Bool,
         dynFollowers: ((SyllabicArray, PositionIndicator) -> [Letter])?)
    {
        // Set identifier values
        self.first = first
        self.second = second
        self.third = third
        if second == nil {
            self.id = first.rawValue
            self.numLetters = 1
        }
        else if third == nil {
            self.id = "\(first.rawValue)\(second!.rawValue)"
            self.numLetters = 2
        }
        else {
            self.id = "\(first.rawValue)\(second!.rawValue)\(third!.rawValue)"
            self.numLetters = 3
        }
        
        // Set attributes
        self.canStart = canStart
        self.canEnd = canEnd
        self.canPlural = canPlural
        self.dynFollowers = dynFollowers
    }
    
    // Returns the last letter of the identifier 
    func lastLetter() -> Letter {
        if second == nil {
            return first
        }
        else if third == nil {
            return second!
        }
        else {
            return third!
        }
    }
}

class PhoneticElementArray {
    var elements: [PhoneticElement]
    var final: Bool = false
    
    init() {
        elements = []
    }
    
    init(pea: PhoneticElementArray) {
        
        // is this really a copy?
        elements = pea.elements
    }
    
    func numElements() -> Int {
        return elements.count
    }
    
    func numLetters() -> Int {
        var nLetters = 0
        
        for e in elements {
            nLetters += e.numLetters
        }
        
        return nLetters
    }
    
    func numSyllables() -> Int {
        var nSyllables = 0
        
        for e in elements {
            if e is Vowel || e is VowelBlend || e is DiphthongBlend {
                nSyllables += 1
                if e is VowelBlend && (e as! VowelBlend).glottalStop {
                    nSyllables += 1
                }
            }
        }
        
        // Final standlone E's are silent for 4-letter words or longer
        if final && numLetters() > 3 && lastElement()!.id == "E" {
            nSyllables -= 1
        }
        
        return nSyllables
    }
    
    func stringRep() -> String {
        var elementStr: String = ""
        
        for e in elements {
            elementStr.append(e.id)
        }
        
        return elementStr
    }
    
    func appendElement(_ newElement: PhoneticElement) -> () {
        elements.append(newElement)
    }
    
    func removeLastElement() {
//        if elements.count == 0 {
//            return false
//        }
        
        elements.removeLast()
        return
    }
    
    func replaceLastElement(_ newElement: PhoneticElement) -> () {
        if elements.count == 0 {
            return
        }
        
        elements[elements.count - 1] = newElement
    }
    
    func replaceElements(_ newElements: PhoneticElementArray) {
        elements = newElements.elements
    }
    
    func firstElement() -> PhoneticElement? {
        if elements.count == 0 {
            return nil
        }
        
        return elements[0]
    }
    
    func lastElement() -> PhoneticElement? {
        if elements.count == 0 {
            return nil
        }
        
        return elements[elements.count - 1]
    }
    
    func nextToLastElement() -> PhoneticElement? {
        if elements.count < 2 {
            return nil
        }
        
        return elements[elements.count - 2]
    }
    
    func matchesString(_ checkString: String, matchFull: Bool) -> Bool {
        var x = 0
        
        if matchFull && numLetters() != checkString.count {
            return false
        }
    
        for e in elements {
            
            for y in 0...e.id.count - 1 {
                
                if x == checkString.count {
                    return true
                }
                
                let cIndex = checkString.index(checkString.startIndex, offsetBy: x)
                let eIndex = e.id.index(e.id.startIndex, offsetBy: y)
                
                if checkString[cIndex] != e.id[eIndex] {
                    return false
                }
                x += 1
            }
        }
        
        return true
    }
    
    func matchesSet(_ checkSet: [String]) -> Bool {
        for item in checkSet {
            if matchesString(item, matchFull: true) {
                return true
            }
        }
        return false
    }
}
