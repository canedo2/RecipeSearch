import Foundation

class SearchViewPresenter: SearchPresenterProtocol, APIServiceDelegate {
    
    var searchController: SearchControllerProtocol
    var apiService: APIServiceProtocol
    var transformer = RecipeTransformer()
    
    init(controller: SearchControllerProtocol,service: APIServiceProtocol, transformer: RecipeTransformer) {
        self.searchController = controller
        self.apiService = service
        self.transformer = transformer
        
        self.apiService.delegate = self
    }

    func performSearch(string: String?) {
        self.apiService.request(searchString: string)
    }
    
    func process(result: [NetRecipe]?) {
        let processedRecipes = self.transformer.transform(from: result)
        DispatchQueue.main.async {
            self.searchController.insert(repositories: processedRecipes)
        }
    }
}
