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
    var isOptionSelected = false
    
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
    }
    
    func unTapCell(){
        let image2 = UIImage(named: "circle2")
        
        if isOptionSelected{
            sortByRadioButtonIcon.setImage(image2, for: .normal)
            isOptionSelected = false
        }
    }
    
    func checkCellEnabled(){
//        if !cell1.isOptionSelected && (cell2.isOptionSelected || cell3.isOptionSelected){
//            cell1.didTapCell()
//            cell2.isOptionSelected = false
//            cell3.isOptionSelected = false
//        }else if !cell2.isOptionSelected && (cell1.isOptionSelected || cell3.isOptionSelected){
//            cell1.isOptionSelected = false
//            cell2.didTapCell()
//            cell3.isOptionSelected = false
//        }else if !cell3.isOptionSelected && (cell2.isOptionSelected || cell1.isOptionSelected){
//            cell1.isOptionSelected = false
//            cell2.isOptionSelected = false
//            cell3.didTapCell()
//        }else{
//            cell.didTapCell()
//        }

    }
    
    @IBAction func didTapRadioButton(_ sender: UIButton) {
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
