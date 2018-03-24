//
//  WordCellTableViewCell.swift
//  Lexografik
//
//  Created by Jay Wright on 11/8/15.
//  Copyright © 2015 Keybordz. All rights reserved.
//

import UIKit

class WordCellTableViewCell: UITableViewCell {
    @IBOutlet weak var wordField: UILabel!
    @IBOutlet weak var wordField2: UILabel!
    @IBOutlet weak var wordField3: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
