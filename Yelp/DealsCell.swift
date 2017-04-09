//
//  DealsCell.swift
//  Yelp
//
//  Created by Arthur Burgin on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class DealsCell: UITableViewCell {

    @IBOutlet var dealsLabel: UILabel!
    @IBOutlet var dealsSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func onToggle(_ sender: UISwitch) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
