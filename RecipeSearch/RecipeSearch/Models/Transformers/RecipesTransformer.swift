import Foundation

class RecipeTransformer {
    
    func transform(from netRecipes:[NetRecipe]?) -> [Recipe]? {
        
        guard let recipesToProcess = netRecipes, !recipesToProcess.isEmpty else {
            return nil
        }
        
        var processedRecipes = [Recipe]()
        
        for recipeToProcess in recipesToProcess {
            let imageUrl = URL(string: recipeToProcess.thumbnail)
            let pageUrl = URL(string: recipeToProcess.href)
            
            processedRecipes.append(Recipe(title: recipeToProcess.title,
                                           url: pageUrl,
                                           ingredients: recipeToProcess.ingredients,
                                           img_url: imageUrl))
        }
        
        return processedRecipes
    }
}
