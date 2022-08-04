import Core
import UIKit

// MARK: - Class

final class CollectionViewModel: ViewModel {

    // MARK: - Private variables

    private let coordinator: MainCoordinator

    // MARK: - Internal variables

    let category: Category
    let posts: [Post]
    var collectionCells = [HomeCollectionCell]()
    var collectionCellViewModel = [HomeCellViewModel]()
    
    init(coordinator: MainCoordinator, category: Category, posts: [Post]) {
        self.coordinator = coordinator
        self.category = category
        self.posts = posts
        super.init(coordinator: coordinator)
    }
}

// MARK: - Extension

extension CollectionViewModel {

    func createCellViewModel(index: Int) -> HomeCellViewModel {
        if collectionCellViewModel.count == 0 {
            let viewModel = HomeCellViewModel(post: posts[index])
            viewModel.setImg()
            collectionCellViewModel.append(viewModel)
            return viewModel
        } else if collectionCellViewModel.count <= index {
            let viewModel = HomeCellViewModel(post: posts[index])
            viewModel.setImg()
            collectionCellViewModel.append(viewModel)
            return viewModel
        } else {
            return collectionCellViewModel[index]
        }
    }
}
