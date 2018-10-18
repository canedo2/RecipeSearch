import Foundation
import UIKit

extension SearchViewController: UISearchControllerDelegate {

}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchPresenter?.performSearch(string: searchBar.text)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.searchController?.isActive = false
    }
}
