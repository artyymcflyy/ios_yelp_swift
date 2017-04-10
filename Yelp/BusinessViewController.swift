
import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var filterButton: UIBarButtonItem!
    let searchBar = UISearchBar()
    
    var businesses: [Business]!
    var tempArr:[Business]?
    var filtersCopy: [String: AnyObject]?
    var categories: [String]?
    var dealsAreOn: Bool?
    var distanceVal: Int?
    var sortByVal: YelpSortMode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchBar.placeholder = "Restaurants"
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        navigationItem.titleView?.backgroundColor = UIColor(colorLiteralRed: 232/255, green: 30/255, blue: 0/255, alpha: 1)
        
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tempArr = self.businesses
            self.tableView.reloadData()
            
        }
        )
        
    }
    
    func searchForBusinessWithFilters(_ term: String){
        
        if filtersCopy?["categories"] != nil{
            categories = filtersCopy?["categories"] as? [String]
        }else{
            categories = nil
        }
        
        if filtersCopy?["deals"] != nil{
            dealsAreOn = filtersCopy?["deals"] as? Bool
        }else{
            dealsAreOn = nil
        }
        
        if filtersCopy?["sort_by"] != nil{
            sortByVal = YelpSortMode(rawValue: (filtersCopy?["sort_by"] as? Int)!)
        }else{
            sortByVal = nil
        }
        
        if filtersCopy?["distance"] != nil{
            distanceVal = filtersCopy?["distance"] as? Int
        }else{
            distanceVal = 0
        }

        
        Business.searchWithTerm(term: term, sort: sortByVal, categories: categories, distance: distanceVal!, deals: dealsAreOn) { (businesses: [Business]!, error: Error!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Search
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let term = searchBar.text
        
        if term != nil{
            searchForBusinessWithFilters(term!)
        }
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil{
            return businesses.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationView = segue.destination as! UINavigationController
        let filterViewController = navigationView.topViewController as! FiltersViewController
        
        filterViewController.delegate = self
        
        if filtersCopy != nil{
            if dealsAreOn != nil{
                filterViewController.dealsSwitchState = dealsAreOn!
            }
            if categories != nil{
                filterViewController.savedCategories = categories!
            }
            if filtersCopy?["sort_by"] != nil{
                filterViewController.previousSortSelection = filtersCopy?["sort_by"] as? Int
            }
            if filtersCopy?["distance_row"] != nil{
                filterViewController.previousDistanceSelection = filtersCopy?["distance_row"] as? Int
            }
        }
        
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        filtersCopy = [:]
        filtersCopy = filters
        
        let term = searchBar.text ?? "Restaurant"
        
        searchForBusinessWithFilters(term)
    }

}
