import Foundation

protocol APIServiceProtocol {
    var delegate: APIServiceDelegate? { get set }
    func request(searchString:String?)
}

protocol APIServiceDelegate: class {
    func process(result: [NetRecipe]?)
}
