import Core
import UIKit

// MARK: - Class

final class HomeViewModel: ViewModel {

    // MARK: - Private variables

    private let service = HomeService(service: ServiceManager())

    // MARK: - Internal variables

    let coordinator: MainCoordinator

    var categories = [Category]()

    // MARK: Initializer

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(coordinator: coordinator)
    }
}

// MARK: - Extension

extension HomeViewModel {

    // MARK: - Internal methods

    func fetchCategories(completion: @escaping(Result<[Category], ResponseError>) -> Void) {
        service.getCategories(completion: completion)
    }

    func fetchPostsFromCategory(category: Category, completion: @escaping(Result<[Post], ResponseError>) -> Void) {
        service.getPostsFromCategory(category: category, completion: completion)
    }

    func goToContent(post: Post) {
        coordinator.goToContent(post: post)
    }
}
