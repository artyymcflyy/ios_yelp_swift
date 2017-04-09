
import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var filterButton: UIBarButtonItem!
    
    var businesses: [Business]!
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
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "Restaurants"
        searchBar.sizeToFit()
        
        navigationItem.titleView = searchBar
        navigationItem.titleView?.backgroundColor = UIColor(colorLiteralRed: 232/255, green: 30/255, blue: 0/255, alpha: 1)
        
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            
        }
        )
        
    }
    
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
        
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        if filters["categories"] != nil{
            categories = filters["categories"] as? [String]
        }
        
        if filters["deals"] != nil{
            dealsAreOn = filters["deals"] as? Bool
        }
        
        if filters["sort_by"] != nil{
            sortByVal = YelpSortMode(rawValue: (filters["sort_by"] as? Int)!)
        }
        
        if filters["distance"] != nil{
            distanceVal = filters["distance"] as? Int
        }
        
        
        Business.searchWithTerm(term: "Restaurants", sort: sortByVal, categories: categories, distance: distanceVal!, deals: dealsAreOn) { (businesses: [Business]!, error: Error!) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
        }
    }

}
