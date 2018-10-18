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

    func performSearch(string: String?, page: Int) {
        self.apiService.request(searchString: string, page: page)
    }
    
    func process(result: [NetRecipe]?, reload: Bool) {
        let processedRecipes = self.transformer.transform(from: result)
        DispatchQueue.main.async {
            self.searchController.insert(recipes: processedRecipes, reload: reload)
        }
    }
}
