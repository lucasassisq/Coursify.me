import Core
import Foundation
import UIKit
import SDWebImage
import RxSwift

// MARK: - Class

final class HomeCollectionCell: UICollectionViewCell {

    // MARK: - Static reuse

    static var reuseIdentifier: String { return String.init(describing: self) }

    let disposeBag = DisposeBag()

    var viewModel: HomeCellViewModel?
    var indexPath = -1

    // MARK: - Internal variables

    let containerView = UIView()

    let imgPhoto: UIImageView = {             
        return $0
    }(UIImageView())

    let titleLabel = AppLabel(font: FontFamily.OpenSans.bold,
                              alignment: .left,
                              numberOfLines: 2)

    let descriptionLabel = AppLabel(font: FontFamily.OpenSans.regular,
                                    alignment: .left,
                                    numberOfLines: 4)

    let readMoreLabel = AppLabel(text: AppStrings.readMore,
                                 font: FontFamily.OpenSans.bold,
                                 fontSize: 16.0,
                                 alignment: .left,
                                 textColor: Colors.lisa.color)

    // MARK: - Initializers

    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: .zero)
        contentView.height(size: 325.0)
        contentView.width(size: 235.0)
        addComponents()
        callConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.containerView.roundCorners(corners: .allCorners, radius: 15.0)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imgPhoto.image = UIImage()
    }

}

// MARK: - Extension

extension HomeCollectionCell: ViewProtocol {

    // MARK: - Private methods

    func addComponents() {
        contentView.addSubview(containerView, constraints: true)
        containerView.addSubviews([imgPhoto,
                                   titleLabel,
                                   descriptionLabel,
                                   readMoreLabel], constraints: true)
        containerView.backgroundColor = Colors.edna.color
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0)
        ])
    }

    func callConstraints() {
        setImgConstraints()
        setUserConstraints()
        setPostQtyConstraints()
        setJoinedDateConstraints()
    }

    func setImgConstraints() {
        NSLayoutConstraint.activate([
            imgPhoto.topAnchor.constraint(equalTo: containerView.topAnchor),
            imgPhoto.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imgPhoto.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imgPhoto.height(size: 103.0),
            imgPhoto.width(size: 235.0)
        ])
    }

    func setUserConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imgPhoto.bottomAnchor, constant: 15.0),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 9.0),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -39.0)
        ])
    }

    func setPostQtyConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 9.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2.0)
        ])
    }

    func setJoinedDateConstraints() {
        NSLayoutConstraint.activate([
            readMoreLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8.0),
            readMoreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 9.0),
            readMoreLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8.0)
        ])
    }

    // MARK: - Internal methods

    func populate(post: Post) {
        titleLabel.attributedText = post.title.rendered.convertHtmlToAttributedStringWithCSS(
            font: FontFamily.OpenSans.bold.font(size: 16.0),
            csscolor: "#2AB598",
            lineheight: 5,
            csstextalign: "left")

        descriptionLabel.attributedText = post.excerpt.rendered.convertHtmlToAttributedStringWithCSS(
            font: FontFamily.OpenSans.regular.font(size: 14.0),
            csscolor: "#868686",
            lineheight: 5,
            csstextalign: "left")

        guard let viewModel = viewModel else { return }
        setupRx(viewModel)
        setImageCover(viewModel)
    }

    func setupRx(_ viewModel: HomeCellViewModel) {
        viewModel.mediaObserver.subscribe(onNext: { item in
            guard let url = URL(string: item.guid.rendered) else { return }
            self.imgPhoto.sd_setImage(with: url, placeholderImage: UIImage(named: "photo"))
        }).disposed(by: disposeBag)
    }

    func setImageCover(_ viewModel: HomeCellViewModel) {
        if viewModel.media == nil {
            viewModel.fetchImage { [weak self]  result in
                guard let self = self else { return }
                switch result {
                case .success(let media):
                    guard let url = URL(string: media.guid.rendered) else { return }
                    self.imgPhoto.sd_setImage(with: url, placeholderImage: UIImage(named: "photo"))
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            guard let media = viewModel.media else { return }
            guard let url = URL(string: media.guid.rendered) else { return }
            self.imgPhoto.sd_setImage(with: url, placeholderImage: UIImage(named: "photo"))
        }
    }
}
