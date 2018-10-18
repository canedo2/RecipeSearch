import Foundation

protocol APIServiceProtocol {
    var delegate: APIServiceDelegate? { get set }
    func request(searchString:String?, page: Int)
}

protocol APIServiceDelegate: class {
    func process(result: [NetRecipe]?, reload: Bool)
}
