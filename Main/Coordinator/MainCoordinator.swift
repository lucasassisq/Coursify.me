import UIKit
import Core

// MARK: - Class

public final class MainCoordinator: Coordinator {

    // MARK: - Internal variables

    weak public var parent: Coordinator?
    public var children = [Coordinator]()
    public var navigationController: UINavigationController

    // MARK: - Initializers

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MainCoordinator {

    // MARK: Public methods

    public func start() {
        startHomeScreen()
    }

    // MARK: - Private methods

    private func startHomeScreen() {
        let viewModel = HomeViewModel(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }

    func goToContent(post: Post) {
        let viewModel = ContentViewModel(coordinator: self, post: post)
        let viewController = ContentViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
