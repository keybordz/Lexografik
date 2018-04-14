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
    var id: String = ""
    var numLetters: Int = 0
    var defaultFirst: [Letter]
    var defaultMiddle: [Letter]
    var defaultLast: [Letter]
    
    var instNextLetters: ((PhoneticElementArray, PositionIndicator) -> [Letter])?
    
    func nextLetters(pea: PhoneticElementArray, nRemaining: Int) -> [Letter] {
        var nextLtrs: [Letter]
        var positionIndicator: PositionIndicator
        
        if nRemaining == 2 {
            positionIndicator = .positionLAST
        }
        else if pea.elements.count == 0 {
            positionIndicator = .positionFIRST
        }
        else if pea.elements.count > 1 {
            positionIndicator = .positionMIDDLE
        }
        else {
            let firstIdLetter = self.id[self.id.startIndex]
            let firstWordLetter = pea.elements[0].id[pea.elements[0].id.startIndex]
            if firstIdLetter == firstWordLetter {
                positionIndicator = .positionFIRST
            }
            else {
                positionIndicator = .positionMIDDLE
            }
        }

        switch positionIndicator {
        case .positionFIRST:
            nextLtrs = self.defaultFirst
        case .positionLAST:
            nextLtrs = self.defaultLast
        case .positionMIDDLE:
            nextLtrs =  self.defaultMiddle
        }
        
        if instNextLetters != nil {
            nextLtrs += self.instNextLetters!(pea, positionIndicator)
        }
        
        return nextLtrs
    }
    
    // these can go away
    var verifyEndOfWord: ((PhoneticElementArray) -> Bool)?
    var verifyPlural: ((PhoneticElementArray) -> Bool)?
    
    init(defFirst: [Letter], defMiddle: [Letter], defLast: [Letter]) {
        self.defaultFirst = defFirst
        self.defaultMiddle = defMiddle
        self.defaultLast = defLast
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
