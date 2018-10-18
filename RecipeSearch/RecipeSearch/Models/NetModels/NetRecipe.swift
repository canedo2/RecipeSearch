import Foundation

struct NetRecipe {
    let title:String
    let href:String
    let ingredients:String
    let thumbnail:String
    
    init?(dictionary: [String:Any]) {
        
        if let dTitle = dictionary["title"] as? String,
            let dHref = dictionary["href"] as? String,
            let dIngredients = dictionary["ingredients"] as? String,
            let dThumbnail = dictionary["thumbnail"] as? String {
                
                self.title = dTitle
                self.href = dHref
                self.ingredients = dIngredients
                self.thumbnail = dThumbnail
            
        } else { return nil }
        
    }
}
