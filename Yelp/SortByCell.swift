//
//  SortByCell.swift
//  Yelp
//
//  Created by Arthur Burgin on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class SortByCell: UITableViewCell {

    @IBOutlet var sortByRadioButtonIcon: UIButton!
    @IBOutlet var sortByLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func didTapRadioButton(_ sender: UIButton) {
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
