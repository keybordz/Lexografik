//
//  ViewController.swift
//  Lexografik
//
//  Created by Jay Wright on 9/15/15.
//  Copyright (c) 2015 Keybordz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var textFieldArray: [UITextField] = []
    var inputSwitches: [Bool] = [false, false, false, false, false, false, false, false, false]
    var currentWordLength: Int = 4

    @IBOutlet weak var letter1: UITextField!
    @IBOutlet weak var letter2: UITextField!
    @IBOutlet weak var letter3: UITextField!
    @IBOutlet weak var letter4: UITextField!
    @IBOutlet weak var letter5: UITextField!
    @IBOutlet weak var letter6: UITextField!
    @IBOutlet weak var letter7: UITextField!
    @IBOutlet weak var letter8: UITextField!
    @IBOutlet weak var letterKey: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var lengthControl: UISegmentedControl!
    @IBOutlet weak var filterStops: UISwitch!
    @IBOutlet weak var mask1: UITextField!
    @IBOutlet weak var mask2: UITextField!
    @IBOutlet weak var mask3: UITextField!
    @IBOutlet weak var mask4: UITextField!
    @IBOutlet weak var mask5: UITextField!
    @IBOutlet weak var mask6: UITextField!
    @IBOutlet weak var mask7: UITextField!
    @IBOutlet weak var mask8: UITextField!
    @IBOutlet weak var mask9: UITextField!
    
    @IBAction func clearFields(_ sender: Any) {
        self.letter1!.text = ""
        self.letter2!.text = ""
        self.letter3!.text = ""
        self.letter4!.text = ""
        self.letter5!.text = ""
        self.letter6!.text = ""
        self.letter7!.text = ""
        self.letter8!.text = ""
        self.letterKey!.text = ""
        self.mask1!.text = ""
        self.mask2!.text = ""
        self.mask3!.text = ""
        self.mask4!.text = ""
        self.mask5!.text = ""
        self.mask6!.text = ""
        self.mask7!.text = ""
        self.mask8!.text = ""
        self.mask9!.text = ""
        
        self.letterKey?.becomeFirstResponder()
    }
    
    @IBAction func clearMask(_ sender: Any) {
        self.mask1!.text = ""
        self.mask2!.text = ""
        self.mask3!.text = ""
        self.mask4!.text = ""
        self.mask5!.text = ""
        self.mask6!.text = ""
        self.mask7!.text = ""
        self.mask8!.text = ""
        self.mask9!.text = ""
    }
    
    func setMaskFields() {
        let wordLength = lengthControl!.selectedSegmentIndex + 4
        
        // disable all mask fields beyond the word length
        for arrayIndex in 13...17 {
            if arrayIndex - 8 <= wordLength {
                textFieldArray[arrayIndex].isHidden = false
            }
            else {
                textFieldArray[arrayIndex].isHidden = true
            }
        }
        
        // how much is the length changing?
        let lengthDiff = wordLength - currentWordLength
        
        // if length is increasing, move all existing mask letters one field to the right
        // and make sure the added fields are all blank
        if wordLength > currentWordLength {
            for arrayIndex in (9...8 + currentWordLength).reversed() {
                textFieldArray[arrayIndex + lengthDiff].text! = textFieldArray[arrayIndex].text!
            }
            for arrayIndex in 9...8 + lengthDiff {
                textFieldArray[arrayIndex].text! = ""
            }
        }
        
        // if length is decreasing, move all existing mask letters one field to the left
        else if wordLength < currentWordLength {
            for arrayIndex in 9...8 + wordLength {
                textFieldArray[arrayIndex].text! = textFieldArray[arrayIndex - lengthDiff].text!
            }
        }

        
        currentWordLength = wordLength
        return
    }
    
    @IBAction func lengthChanged(_ sender: Any) {
        setMaskFields()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldArray.append(letterKey!)
        textFieldArray.append(letter1!)
        textFieldArray.append(letter2!)
        textFieldArray.append(letter3!)
        textFieldArray.append(letter4!)
        textFieldArray.append(letter5!)
        textFieldArray.append(letter6!)
        textFieldArray.append(letter7!)
        textFieldArray.append(letter8!)
        textFieldArray.append(mask1!)
        textFieldArray.append(mask2!)
        textFieldArray.append(mask3!)
        textFieldArray.append(mask4!)
        textFieldArray.append(mask5!)
        textFieldArray.append(mask6!)
        textFieldArray.append(mask7!)
        textFieldArray.append(mask8!)
        textFieldArray.append(mask9!)
        
        setMaskFields()
        letterKey!.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (range.length + range.location > textField.text!.count) {
            return false;
        }
        
        // Which text field are we working with?
        let arrayIndex = textFieldArray.index(of: textField)
        
        // At every character in this "inverseSet" contained in the string,
        // split the string up into components which exclude the characters
        // in this inverse set
        let inverseSet = CharacterSet.uppercaseLetters.inverted
        let components = string.components(separatedBy: inverseSet)
        
        // Rejoin these components
        let filtered = components.joined(separator: "")
        if filtered != string {
            return false
        }
        
        let newLength = textField.text!.count + string.count - range.length
        if newLength > 1 {
            return false
        }
        
        // Only need to check status of the letter fields, not the mask
        else if arrayIndex! < 9 {
            if newLength == 0 {
                inputSwitches[arrayIndex!] = false
            }
            else {
                inputSwitches[arrayIndex!] = true
            }
        
            // Enable button when all the fields have characters
            if inputSwitches.index(of: false) == nil {
                generateButton?.isEnabled = true
            }
            else {
                generateButton?.isEnabled = false
            }
        }
        
        if newLength == 0 {
            return true
        }
        
        textField.text = filtered
        if arrayIndex == 17 {
            self.letterKey!.becomeFirstResponder()
        }
        else {
            textFieldArray[arrayIndex! + 1].becomeFirstResponder()
        }
        
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayWords" {
            let wordTableController = segue.destination as! WordTableViewController
            var letters: [String] = []
            var maskLetters: [String] = []
            let wordLength = lengthControl!.selectedSegmentIndex + 4
            
            for arrayIndex in 1...8 {
                letters.append(textFieldArray[arrayIndex].text!)
            }

            for arrayIndex in 9...wordLength + 8 {
                if textFieldArray[arrayIndex].text! == "" {
                    maskLetters.append("*")
                }
                else {
                    maskLetters.append(textFieldArray[arrayIndex].text!)
                }
            }
            
            let storm = WordStorm(outer: letters, center: letterKey!.text!, mask: maskLetters)
            storm.filterStops = filterStops!.isOn
            storm.wordSize = wordLength
            storm.gatherWords(storm.wordSize)
            
            wordTableController.storm = storm
        }
    }
}

