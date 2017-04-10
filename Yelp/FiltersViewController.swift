//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Arthur Burgin on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CategoriesCellDelegate, DealsCellDelegate, SortByCellDelegate, DistanceCellDelegate{

    @IBOutlet var tableView: UITableView!
    
    var delegate: FiltersViewControllerDelegate?
    var categories: [[String: String]]!
    var categorySwitchStates = [Int:Bool]()
    var savedCategories:[String]?
    var sortBySelection: [Int:Bool] = [0: true]
    var distanceSelection: [Int:Bool] = [0: true]
    var selectedCategories = [String]()
    var dealsSwitchState = false
    var miles: Int = 0
    var previousSortSelection: Int?
    var previousDistanceSelection: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = yelpCategories()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if savedCategories != nil{
            for (index, arr) in categories.enumerated() {
                for item in savedCategories!{
                    if arr["code"] == item{
                        categorySwitchStates[index] = true
                    }
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSearch(_ sender: UIBarButtonItem) {

        var filters = [String: AnyObject]()
        var selectedCategories = [String]()
        
        for(row, isSelected) in categorySwitchStates{
            if isSelected{
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        
        for(row, isSelected) in sortBySelection{
            if isSelected{
                filters["sort_by"] = row as AnyObject
            }
        }
        
        for(row, isSelected) in distanceSelection{
            if isSelected{
                let value = yelpDistance()[row]
                miles = yelpDistanceToMetersConversion(value)
                filters["distance"] = miles as AnyObject
                filters["distance_row"] = row as AnyObject
            }
        }
        
        if selectedCategories.count > 0{
            filters["categories"] = selectedCategories as AnyObject
        }
        filters["deals"] = dealsSwitchState as AnyObject
        
        delegate?.filtersViewController(filtersViewController: self, didUpdateFilters: filters)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
        case 0:
            return "Deals"
        case 1:
            return "Distance"
        case 2:
            return "Sort By"
        case 3:
            return "Categories"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        case 2:
            return 3
        case 3:
            return categories.count
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0{
            return nil
        }else if indexPath.section == 3{
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            tableView.deselectRow(at: indexPath, animated: true)
            let indexPath0 = NSIndexPath(row: 0, section: 1) as IndexPath
            let indexPath1 = NSIndexPath(row: 1, section: 1) as IndexPath
            let indexPath2 = NSIndexPath(row: 2, section: 1) as IndexPath
            let indexPath3 = NSIndexPath(row: 3, section: 1) as IndexPath
            let indexPath4 = NSIndexPath(row: 4, section: 1) as IndexPath
            
            let cell1 = tableView.cellForRow(at: indexPath0) as! DistanceCell
            let cell2 = tableView.cellForRow(at: indexPath1) as! DistanceCell
            let cell3 = tableView.cellForRow(at: indexPath2) as! DistanceCell
            let cell4 = tableView.cellForRow(at: indexPath3) as! DistanceCell
            let cell5 = tableView.cellForRow(at: indexPath4) as! DistanceCell
            
            
            if indexPath.row == 0{
                previousDistanceSelection = indexPath.row
                cell1.didTapCell()
                cell2.unTapCell()
                cell3.unTapCell()
                cell4.unTapCell()
                cell5.unTapCell()
            }else if indexPath.row == 1{
                previousDistanceSelection = indexPath.row
                cell1.unTapCell()
                cell2.didTapCell()
                cell3.unTapCell()
                cell4.unTapCell()
                cell5.unTapCell()
            }else if indexPath.row == 2{
                previousDistanceSelection = indexPath.row
                cell1.unTapCell()
                cell2.unTapCell()
                cell3.didTapCell()
                cell4.unTapCell()
                cell5.unTapCell()
            }else if indexPath.row == 3{
                previousDistanceSelection = indexPath.row
                cell1.unTapCell()
                cell2.unTapCell()
                cell3.unTapCell()
                cell4.didTapCell()
                cell5.unTapCell()
            }else if indexPath.row == 4{
                previousDistanceSelection = indexPath.row
                cell1.unTapCell()
                cell2.unTapCell()
                cell3.unTapCell()
                cell4.unTapCell()
                cell5.didTapCell()
            }
        case 2:
            tableView.deselectRow(at: indexPath, animated: true)
            let indexPath0 = NSIndexPath(row: 0, section: 2) as IndexPath
            let indexPath1 = NSIndexPath(row: 1, section: 2) as IndexPath
            let indexPath2 = NSIndexPath(row: 2, section: 2) as IndexPath
            
            let cell1 = tableView.cellForRow(at: indexPath0) as? SortByCell
            let cell2 = tableView.cellForRow(at: indexPath1) as? SortByCell
            let cell3 = tableView.cellForRow(at: indexPath2) as? SortByCell

            
            if indexPath.row == 0{
                previousSortSelection = indexPath.row
                cell1!.didTapCell()
                cell2!.unTapCell()
                cell3!.unTapCell()
            }else if indexPath.row == 1{
                previousSortSelection = indexPath.row
                cell1!.unTapCell()
                cell2!.didTapCell()
                cell3!.unTapCell()
            }else if indexPath.row == 2{
                previousSortSelection = indexPath.row
                cell1!.unTapCell()
                cell2!.unTapCell()
                cell3!.didTapCell()
            }
            
            
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DealsCell", for: indexPath) as! DealsCell
            cell.dealsLabel.text = "Offering a Deal"
            cell.dealsSwitch.isOn = dealsSwitchState
            cell.delegate = self
            
            return cell
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceCell", for: indexPath) as! DistanceCell
            cell.distanceLabel.text = yelpDistance()[indexPath.row]
            
            if indexPath.row == previousDistanceSelection{
                cell.didTapCell()
            }
            
            cell.delegate = self
            
            return cell
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SortByCell", for: indexPath) as! SortByCell
            cell.sortByLabel.text = yelpSortBy()[indexPath.row]
            
            if indexPath.row == previousSortSelection{
                cell.didTapCell()
            }
            
            
            
            cell.delegate = self
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
            cell.categoriesLabel.text = categories[indexPath.row]["name"]
            cell.delegate = self
            
            cell.onSwitch.isOn = categorySwitchStates[indexPath.row] ?? false
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        }

    }
    
    func dealsCell(DealsCell: DealsCell, didChangeValue value: Bool) {
        dealsSwitchState = value
    }
    
    func distanceCell(DistanceCell: DistanceCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: DistanceCell)
        if indexPath != nil{
            distanceSelection[(indexPath?.row)!] = value
        }
    }
    
    func sortByCell(SortByCell: SortByCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: SortByCell)
        if indexPath != nil{
            sortBySelection[(indexPath?.row)!] = value
        }
    }
    
    func categoriesCell(CategoriesCell: CategoriesCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: CategoriesCell)!
        categorySwitchStates[indexPath.row] = value
    }
    
    func yelpDistance()->[String]{
        return ["Auto", "0.3","1","5", "20"]
    }
    
    func yelpDistanceToMetersConversion(_ miles: String)->Int{
        var numMiles = 0.0
        if miles == "Auto"{
            numMiles = 0.0
        }else{
            numMiles = Double(miles)!
        }
        
        return Int(numMiles * 1609.344)
    }
    
    func yelpSortBy()->[String]{
        return ["Best match", "Distance", "highest rated"]
    }
    
    func yelpCategories() -> [[String:String]]{
        return [["name" : "Afghan","code": "afghani"],
                ["name" : "African", "code": "african"],
                ["name" : "American, New", "code": "newamerican"],
                ["name" : "American, Traditional", "code": "tradamerican"],
                ["name" : "Arabian", "code": "arabian"],
                ["name" : "Argentine", "code": "argentine"],
                ["name" : "Armenian", "code": "armenian"],
                ["name" : "Asian Fusion", "code": "asianfusion"],
                ["name" : "Asturian", "code": "asturian"],
                ["name" : "Australian", "code": "australian"],
                ["name" : "Austrian", "code": "austrian"],
                ["name" : "Baguettes", "code": "baguettes"],
                ["name" : "Bangladeshi", "code": "bangladeshi"],
                ["name" : "Barbeque", "code": "bbq"],
                ["name" : "Basque", "code": "basque"],
                ["name" : "Bavarian", "code": "bavarian"],
                ["name" : "Beer Garden", "code": "beergarden"],
                ["name" : "Beer Hall", "code": "beerhall"],
                ["name" : "Beisl", "code": "beisl"],
                ["name" : "Belgian", "code": "belgian"],
                ["name" : "Bistros", "code": "bistros"],
                ["name" : "Black Sea", "code": "blacksea"],
                ["name" : "Brasseries", "code": "brasseries"],
                ["name" : "Brazilian", "code": "brazilian"],
                ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                ["name" : "British", "code": "british"],
                ["name" : "Buffets", "code": "buffets"],
                ["name" : "Bulgarian", "code": "bulgarian"],
                ["name" : "Burgers", "code": "burgers"],
                ["name" : "Burmese", "code": "burmese"],
                ["name" : "Cafes", "code": "cafes"],
                ["name" : "Cafeteria", "code": "cafeteria"],
                ["name" : "Cajun/Creole", "code": "cajun"],
                ["name" : "Cambodian", "code": "cambodian"],
                ["name" : "Canadian", "code": "New)"],
                ["name" : "Canteen", "code": "canteen"],
                ["name" : "Caribbean", "code": "caribbean"],
                ["name" : "Catalan", "code": "catalan"],
                ["name" : "Chech", "code": "chech"],
                ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                ["name" : "Chicken Shop", "code": "chickenshop"],
                ["name" : "Chicken Wings", "code": "chicken_wings"],
                ["name" : "Chilean", "code": "chilean"],
                ["name" : "Chinese", "code": "chinese"],
                ["name" : "Comfort Food", "code": "comfortfood"],
                ["name" : "Corsican", "code": "corsican"],
                ["name" : "Creperies", "code": "creperies"],
                ["name" : "Cuban", "code": "cuban"],
                ["name" : "Curry Sausage", "code": "currysausage"],
                ["name" : "Cypriot", "code": "cypriot"],
                ["name" : "Czech", "code": "czech"],
                ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                ["name" : "Danish", "code": "danish"],
                ["name" : "Delis", "code": "delis"],
                ["name" : "Diners", "code": "diners"],
                ["name" : "Dumplings", "code": "dumplings"],
                ["name" : "Eastern European", "code": "eastern_european"],
                ["name" : "Ethiopian", "code": "ethiopian"],
                ["name" : "Fast Food", "code": "hotdogs"],
                ["name" : "Filipino", "code": "filipino"],
                ["name" : "Fish & Chips", "code": "fishnchips"],
                ["name" : "Fondue", "code": "fondue"],
                ["name" : "Food Court", "code": "food_court"],
                ["name" : "Food Stands", "code": "foodstands"],
                ["name" : "French", "code": "french"],
                ["name" : "French Southwest", "code": "sud_ouest"],
                ["name" : "Galician", "code": "galician"],
                ["name" : "Gastropubs", "code": "gastropubs"],
                ["name" : "Georgian", "code": "georgian"],
                ["name" : "German", "code": "german"],
                ["name" : "Giblets", "code": "giblets"],
                ["name" : "Gluten-Free", "code": "gluten_free"],
                ["name" : "Greek", "code": "greek"],
                ["name" : "Halal", "code": "halal"],
                ["name" : "Hawaiian", "code": "hawaiian"],
                ["name" : "Heuriger", "code": "heuriger"],
                ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                ["name" : "Hot Dogs", "code": "hotdog"],
                ["name" : "Hot Pot", "code": "hotpot"],
                ["name" : "Hungarian", "code": "hungarian"],
                ["name" : "Iberian", "code": "iberian"],
                ["name" : "Indian", "code": "indpak"],
                ["name" : "Indonesian", "code": "indonesian"],
                ["name" : "International", "code": "international"],
                ["name" : "Irish", "code": "irish"],
                ["name" : "Island Pub", "code": "island_pub"],
                ["name" : "Israeli", "code": "israeli"],
                ["name" : "Italian", "code": "italian"],
                ["name" : "Japanese", "code": "japanese"],
                ["name" : "Jewish", "code": "jewish"],
                ["name" : "Kebab", "code": "kebab"],
                ["name" : "Korean", "code": "korean"],
                ["name" : "Kosher", "code": "kosher"],
                ["name" : "Kurdish", "code": "kurdish"],
                ["name" : "Laos", "code": "laos"],
                ["name" : "Laotian", "code": "laotian"],
                ["name" : "Latin American", "code": "latin"],
                ["name" : "Live/Raw Food", "code": "raw_food"],
                ["name" : "Lyonnais", "code": "lyonnais"],
                ["name" : "Malaysian", "code": "malaysian"],
                ["name" : "Meatballs", "code": "meatballs"],
                ["name" : "Mediterranean", "code": "mediterranean"],
                ["name" : "Mexican", "code": "mexican"],
                ["name" : "Middle Eastern", "code": "mideastern"],
                ["name" : "Milk Bars", "code": "milkbars"],
                ["name" : "Modern Australian", "code": "modern_australian"],
                ["name" : "Modern European", "code": "modern_european"],
                ["name" : "Mongolian", "code": "mongolian"],
                ["name" : "Moroccan", "code": "moroccan"],
                ["name" : "New Zealand", "code": "newzealand"],
                ["name" : "Night Food", "code": "nightfood"],
                ["name" : "Norcinerie", "code": "norcinerie"],
                ["name" : "Open Sandwiches", "code": "opensandwiches"],
                ["name" : "Oriental", "code": "oriental"],
                ["name" : "Pakistani", "code": "pakistani"],
                ["name" : "Parent Cafes", "code": "eltern_cafes"],
                ["name" : "Parma", "code": "parma"],
                ["name" : "Persian/Iranian", "code": "persian"],
                ["name" : "Peruvian", "code": "peruvian"],
                ["name" : "Pita", "code": "pita"],
                ["name" : "Pizza", "code": "pizza"],
                ["name" : "Polish", "code": "polish"],
                ["name" : "Portuguese", "code": "portuguese"],
                ["name" : "Potatoes", "code": "potatoes"],
                ["name" : "Poutineries", "code": "poutineries"],
                ["name" : "Pub Food", "code": "pubfood"],
                ["name" : "Rice", "code": "riceshop"],
                ["name" : "Romanian", "code": "romanian"],
                ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                ["name" : "Rumanian", "code": "rumanian"],
                ["name" : "Russian", "code": "russian"],
                ["name" : "Salad", "code": "salad"],
                ["name" : "Sandwiches", "code": "sandwiches"],
                ["name" : "Scandinavian", "code": "scandinavian"],
                ["name" : "Scottish", "code": "scottish"],
                ["name" : "Seafood", "code": "seafood"],
                ["name" : "Serbo Croatian", "code": "serbocroatian"],
                ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                ["name" : "Singaporean", "code": "singaporean"],
                ["name" : "Slovakian", "code": "slovakian"],
                ["name" : "Soul Food", "code": "soulfood"],
                ["name" : "Soup", "code": "soup"],
                ["name" : "Southern", "code": "southern"],
                ["name" : "Spanish", "code": "spanish"],
                ["name" : "Steakhouses", "code": "steak"],
                ["name" : "Sushi Bars", "code": "sushi"],
                ["name" : "Swabian", "code": "swabian"],
                ["name" : "Swedish", "code": "swedish"],
                ["name" : "Swiss Food", "code": "swissfood"],
                ["name" : "Tabernas", "code": "tabernas"],
                ["name" : "Taiwanese", "code": "taiwanese"],
                ["name" : "Tapas Bars", "code": "tapas"],
                ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                ["name" : "Tex-Mex", "code": "tex-mex"],
                ["name" : "Thai", "code": "thai"],
                ["name" : "Traditional Norwegian", "code": "norwegian"],
                ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                ["name" : "Trattorie", "code": "trattorie"],
                ["name" : "Turkish", "code": "turkish"],
                ["name" : "Ukrainian", "code": "ukrainian"],
                ["name" : "Uzbek", "code": "uzbek"],
                ["name" : "Vegan", "code": "vegan"],
                ["name" : "Vegetarian", "code": "vegetarian"],
                ["name" : "Venison", "code": "venison"],
                ["name" : "Vietnamese", "code": "vietnamese"],
                ["name" : "Wok", "code": "wok"],
                ["name" : "Wraps", "code": "wraps"],
                ["name" : "Yugoslav", "code": "yugoslav"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
