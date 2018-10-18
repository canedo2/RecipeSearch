import Foundation

protocol SearchControllerProtocol {
    var searchPresenter: SearchPresenterProtocol? { get set }
    func insert(recipes: [Recipe]?, reload: Bool)
}

protocol SearchPresenterProtocol {
    var searchController: SearchControllerProtocol { get set }
    func performSearch(string: String?, page: Int)
}
