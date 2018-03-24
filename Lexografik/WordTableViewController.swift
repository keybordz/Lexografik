//
//  WordTableViewController.swift
//  Lexografik
//
//  Created by Jay Wright on 11/8/15.
//  Copyright © 2015 Keybordz. All rights reserved.
//

import UIKit

class WordTableViewController: UITableViewController {
    var storm: WordStorm?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "\(storm!.wordSize)-Letter Words (\(storm!.wordCount))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return storm!.unique.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var sectionTitles: [String] = []
        
        for ch in storm!.unique {
            sectionTitles.append(ch.rawValue)
        }
        
        return sectionTitles
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return storm!.unique[section].rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let sectionLtr = storm!.unique[section].rawValue
        let lower = storm!.sectionIndices[sectionLtr]!
        var upper = 0
        var numrows = 0
        
        if section == storm!.unique.count - 1 {
            upper = storm!.wordCount
        }
        else {
            upper = storm!.sectionIndices[storm!.unique[section + 1].rawValue]!
        }
        
        // Number of words in this section of the table
        storm!.sectionTotals[sectionLtr]! = upper - lower
        
        numrows = (upper - lower) / 3
        if (upper - lower) % 3 > 0 {
            numrows += 1
        }

        return numrows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordCellTableViewCell

        let section = (indexPath as NSIndexPath).section
        let offset  = (indexPath as NSIndexPath).row
        let numrows = tableView.numberOfRows(inSection: section)
        let tableSection = storm!.unique[section].rawValue
        let startIndex = storm!.sectionIndices[tableSection]!
        let totalWords = storm!.sectionTotals[tableSection]!
        
        cell.wordField.text = storm!.allWords[startIndex + offset].stringFromLetters()
        
        if offset + numrows + 1 > totalWords {
            cell.wordField2.text = ""
        }
        else {
            cell.wordField2.text = storm!.allWords[startIndex + offset + numrows].stringFromLetters()
        }
        
        if offset + 2*numrows + 1 > totalWords {
            cell.wordField3.text = ""
        }
        else {
            cell.wordField3.text = storm!.allWords[startIndex + offset + 2*numrows].stringFromLetters()
        }
        
        return cell
    }

}
