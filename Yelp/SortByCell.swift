//
//  SortByCell.swift
//  Yelp
//
//  Created by Arthur Burgin on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SortByCellDelegate {
    @objc optional func sortByCell(SortByCell:SortByCell, didChangeValue value: Bool)
}

class SortByCell: UITableViewCell {

    @IBOutlet var sortByRadioButtonIcon: UIButton!
    @IBOutlet var sortByLabel: UILabel!
    
    var isOptionSelected = false
    var delegate: SortByCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func didTapCell(){
        let image1 = UIImage(named: "circle")
        
        if !isOptionSelected{
            sortByRadioButtonIcon.setImage(image1, for: .normal)
            isOptionSelected = true
        }
        delegate?.sortByCell?(SortByCell: self, didChangeValue: true)
    }
    
    func unTapCell(){
        let image2 = UIImage(named: "circle2")
        
        if isOptionSelected{
            sortByRadioButtonIcon.setImage(image2, for: .normal)
            isOptionSelected = false
        }
        delegate?.sortByCell?(SortByCell: self, didChangeValue: false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
