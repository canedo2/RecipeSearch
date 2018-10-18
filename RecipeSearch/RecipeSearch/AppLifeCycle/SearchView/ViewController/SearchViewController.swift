
import UIKit

class SearchViewController: UIViewController, SearchControllerProtocol {
    var searchPresenter: SearchPresenterProtocol?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var tableItems: [Recipe]?
    var searchString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchPresenter = SearchViewPresenter(controller: self, service: RecipeApiService(), transformer: RecipeTransformer())
        
        self.title = NSLocalizedString("Recipes", comment: "")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        self.navigationItem.searchController = UISearchController(searchResultsController: nil);
        self.navigationItem.searchController?.delegate = self
        self.navigationItem.searchController?.searchBar.delegate = self
        self.navigationItem.hidesSearchBarWhenScrolling = false;
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.rowHeight = 80
    }
    
    func showInfoIfNeeded() {
        if let items_count = tableItems?.count, items_count > 0 {
            infoLabel.text = ""
        } else {
            infoLabel.text = "No recipes found"
        }
    }
    
    func loadMoreItems() {
        self.searchPresenter?.performSearch(string: searchString,
                                                        page: (self.tableItems?.count ?? 0)/10 + 1)

    }
    
    func insert(recipes: [Recipe]?, reload: Bool) {
        
        if (reload) {
            tableItems = recipes
            showInfoIfNeeded()
            tableView.reloadData()
        } else {
            
            if let recipes = recipes {
                var indexPaths = [IndexPath]()
                for recipe in recipes {
                    tableItems?.append(recipe)
                    if tableItems != nil {
                        indexPaths.append(IndexPath(row: tableItems!.count - 1, section: 0))
                    }
                }
                tableView.insertRows(at: indexPaths, with: .fade)
            }
            
        }
    }
}
