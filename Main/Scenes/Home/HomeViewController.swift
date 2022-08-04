import UIKit
import Core

// MARK: - Class

final class HomeViewController: ViewController<HomeView> {

    // MARK: - Private variable

    private let viewModel: HomeViewModel
    private var fetchedCategories = 0

    // MARK: - Initializer

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
    }
}

// MARK: - Extension class

extension HomeViewController {

    func fetchCategories() {
        viewModel.fetchCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.viewModel.categories = categories[0...2].map({ $0 })
                self.interateCategories()
            case .failure(_):
                print("something wrong happened")
            }
        }
    }

    func interateCategories() {
        viewModel.categories.forEach { item in
            fetchEpisodes(category: item)
        }
    }

    func fetchEpisodes(category: Category) {
        viewModel.fetchPostsFromCategory(category: category, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                self.createCollectionController(category: category, posts: posts)
            case .failure(let error):
                print(error)
            }
        })
    }

    func createCollectionController(category: Category, posts: [Post]) {
        fetchedCategories += 1
        let viewModel = CollectionViewModel(coordinator: viewModel.coordinator, category: category, posts: posts)
        let collectionViewController = CollectionViewController(viewModel: viewModel, delegate: self)
        addChild(collectionViewController)
        customView.stackView.addArrangedSubview(collectionViewController.customView)
        collectionViewController.didMove(toParent: self)
        if fetchedCategories > 2 {
            customView.stackView.addArrangedSubview(customView.footView)
        }
    }
}

// MARK: - Protocol extension

extension HomeViewController: CollectionDelegate {

    func onClick(post: Post) {
        viewModel.goToContent(post: post)
    }
}
