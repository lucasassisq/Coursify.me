import UIKit
import Core

// MARK: Protocol delegate

protocol CollectionDelegate: AnyObject {
    func onClick(post: Post)
}

// MARK: - Class

final class CollectionViewController: ViewController<CollectionView> {

    let viewModel: CollectionViewModel
    let delegate: CollectionDelegate

    init(viewModel: CollectionViewModel, delegate: CollectionDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.titleLabel.text = viewModel.category.name
        setupCollectionView()
    }
}

// MARK: - Extension

extension CollectionViewController {


    func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView.reloadData()
    }
}

// MARK: - Extensions CollectionView Delegate

extension CollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = viewModel.posts[indexPath.row]
        delegate.onClick(post: post)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.reuseIdentifier, for: indexPath) as? HomeCollectionCell else { return UICollectionViewCell()
        }
        cell.viewModel = viewModel.createCellViewModel(index: indexPath.row)
        cell.populate(post: viewModel.posts[indexPath.row])
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
