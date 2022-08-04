import Core

// MARK: - Class

final class ContentViewModel: ViewModel {

    // MARK: - Private variables

    private let coordinator: MainCoordinator

    // MARK: - Internal variables

    let post: Post

    init(coordinator: MainCoordinator, post: Post) {
        self.coordinator = coordinator
        self.post = post
        super.init(coordinator: coordinator)
    }
}
