import Foundation

protocol SearchControllerProtocol {
    var searchPresenter: SearchPresenterProtocol? { get set }
    func insert(repositories: [Recipe]?)
}

protocol SearchPresenterProtocol {
    var searchController: SearchControllerProtocol { get set }
    func performSearch(string: String?)
}
