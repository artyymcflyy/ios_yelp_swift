//
//  RadioCell.swift
//  Yelp
//
//  Created by Arthur Burgin on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class DistanceCell: UITableViewCell {

    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var distanceRadioButtonIcon: UIButton!
    var isButtonSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func didTapRadioButton(_ sender: Any) {
        let image1 = UIImage(named: "circle")
        let image2 = UIImage(named: "circle2")
        
        if !isSelected{
            distanceRadioButtonIcon.setImage(image1, for: .normal)
            isSelected = true
        }else{
            distanceRadioButtonIcon.setImage(image2, for: .normal)
            isSelected = false
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state\
        
    }

}
