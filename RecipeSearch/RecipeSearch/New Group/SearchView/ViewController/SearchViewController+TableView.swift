import Foundation
import UIKit
import SafariServices

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = tableItems?[indexPath.row].url {
            let safariController = SFSafariViewController(url: url)
            self.navigationController?.present(safariController, animated: true)
        }
        
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as? RecipeCell else {
            print("Cell creation error")
            return UITableViewCell()
        }
        
        let item = tableItems![indexPath.row]
        cell.configure(title: item.title, overview: item.ingredients, imageURL: item.img_url)
        
        if indexPath.row == (tableItems?.count ?? 0) - 3 {
            self.loadMoreItems()
        }
        
        return cell
        
    }
    
}
