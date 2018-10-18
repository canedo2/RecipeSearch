import Foundation
import Alamofire

class RecipeApiService: APIServiceProtocol {
    
    let baseUrlString = "http://www.recipepuppy.com/api/?q="
    let optionsString = "&p=1"
    
    weak var delegate: APIServiceDelegate?
    
    func request(searchString: String?) {
        guard let searchString = searchString, searchString != "" else {
            return
        }
        
        let url = "\(baseUrlString)\(searchString)\(optionsString)"
        
        Alamofire.request(url).responseJSON { response in
            if let status = response.response?.statusCode {
                if status >= 200, status < 300 {
                    print("Request success: \(status)")
                    if let response = response.result.value as? [String:Any],
                        let items = response["results"] as? [Any] {
                        var itemsArray = [NetRecipe]()
                        for item in items {
                            guard let item = item as? [String:Any] else {
                                self.delegate?.process(result: nil)
                                return
                            }
                            if let netRecipe = NetRecipe(dictionary: item) {
                                itemsArray.append(netRecipe)
                            }
                        }
                        if itemsArray.count > 0 {
                            
                            self.delegate?.process(result: itemsArray)
                        } else { self.delegate?.process(result: nil)}
                    }
                } else {
                    print("Resquest unsuccessful: \(status)")
                    self.delegate?.process(result: nil)
                }
            }
        }
    }
}
