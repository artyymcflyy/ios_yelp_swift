//
//  RadioCell.swift
//  Yelp
//
//  Created by Arthur Burgin on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DistanceCellDelegate {
    @objc optional func distanceCell(DistanceCell:DistanceCell, didChangeValue value: Bool)
}

class DistanceCell: UITableViewCell {

    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var distanceRadioButtonIcon: UIButton!
    
    var isOptionSelected = false
    var delegate: DistanceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func didTapCell(){
        let image1 = UIImage(named: "circle")
        
        if !isOptionSelected{
            distanceRadioButtonIcon.setImage(image1, for: .normal)
            isOptionSelected = true
        }
        delegate?.distanceCell?(DistanceCell: self, didChangeValue: true)
    }
    
    func unTapCell(){
        let image2 = UIImage(named: "circle2")
        
        if isOptionSelected{
            distanceRadioButtonIcon.setImage(image2, for: .normal)
            isOptionSelected = false
        }
        delegate?.distanceCell?(DistanceCell: self, didChangeValue: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state\
        
    }

}
