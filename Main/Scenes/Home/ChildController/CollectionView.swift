import UIKit
import Core

// MARK: - Class

final class CollectionView: UIView {

    // MARK: - Internal variables

    let titleLabel = AppLabel(font: FontFamily.OpenSans.bold,
                              fontSize: 22.0,
                              textColor: Colors.krusty.color)

    let seeMoreLabel = AppLabel(text: AppStrings.seeMoreCell,
                                font: FontFamily.OpenSans.regular,
                                fontSize: 17.0,
                                textColor: Colors.heyman.color)

    let layout: UICollectionViewFlowLayout = {
        $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.itemSize = CGSize(width: 235, height: 325)
        $0.scrollDirection = .horizontal
        return $0
    }(UICollectionViewFlowLayout())


    lazy var collectionView: UICollectionView = {
        $0.backgroundColor = Colors.nelson.color
        $0.showsVerticalScrollIndicator = false
        $0.register(HomeCollectionCell.self,
                    forCellWithReuseIdentifier: HomeCollectionCell.reuseIdentifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addComponents()
        seeMoreLabel.width(size: 100)
        seeMoreLabel.height(size: 30)
        height(size: 450)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension CollectionView {

   // MARK: - Internal methods

    func addComponents() {
        addSubviews([titleLabel, seeMoreLabel, collectionView], constraints: true)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0)
        ])

        NSLayoutConstraint.activate([
            seeMoreLabel.topAnchor.constraint(equalTo: topAnchor),
            seeMoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0)
        ])

        collectionView.applyAnchors(ofType: [.leading, .trailing, .bottom], to: self)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
    }
}
