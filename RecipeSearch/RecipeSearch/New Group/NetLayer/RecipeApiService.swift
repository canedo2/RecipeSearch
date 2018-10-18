import Foundation
import Alamofire

class RecipeApiService: APIServiceProtocol {
    
    let baseUrlString = "http://www.recipepuppy.com/api/?q="
    let optionsString = "&p="
    
    weak var delegate: APIServiceDelegate?
    
    func request(searchString: String?, page: Int) {
        guard let searchString = searchString, searchString != "" else {
            return
        }
        
        let url = "\(baseUrlString)\(searchString)\(optionsString)\(page)"
        
        Alamofire.request(url).responseJSON { response in
            if let status = response.response?.statusCode {
                if status >= 200, status < 300 {
                    print("Request success: \(status)")
                    if let response = response.result.value as? [String:Any],
                        let items = response["results"] as? [Any] {
                        var itemsArray = [NetRecipe]()
                        for item in items {
                            guard let item = item as? [String:Any] else {
                                self.delegate?.process(result: nil, reload: page == 1)
                                return
                            }
                            if let netRecipe = NetRecipe(dictionary: item) {
                                itemsArray.append(netRecipe)
                            }
                        }
                        if itemsArray.count > 0 {
                            self.delegate?.process(result: itemsArray, reload: page == 1)
                        } else { self.delegate?.process(result: nil, reload: page == 1)}
                    }
                } else {
                    print("Resquest unsuccessful: \(status)")
                    self.delegate?.process(result: nil, reload: page == 1)
                }
            }
        }
    }
}
