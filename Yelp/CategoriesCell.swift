//
//  SwitchCell.swift
//  Yelp
//
//  Created by Arthur Burgin on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol CategoriesCellDelegate {
    @objc optional func categoriesCell(CategoriesCell: CategoriesCell, didChangeValue value: Bool)
}

class CategoriesCell: UITableViewCell {

    @IBOutlet var onSwitch: UISwitch!
    @IBOutlet var categoriesLabel: UILabel!
    
    var delegate: CategoriesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        onSwitch.addTarget(self, action: #selector(onToggle), for: .valueChanged)
    }
    
    func onToggle(){
        delegate?.categoriesCell?(CategoriesCell: self, didChangeValue: onSwitch.isOn)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
