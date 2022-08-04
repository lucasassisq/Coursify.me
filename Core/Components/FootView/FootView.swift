import UIKit

// MARK: - Class

public final class FootView: UIView {

    // MARK: - Internal variables

    let logoImageView: UIImageView = {
        $0.image = Assets.logoCoursifyW.image
        $0.height(size: 45.0)
        $0.width(size: 172.0)
        return $0
    }(UIImageView())

    let descriptionLabel = AppLabel(text: AppStrings.footDescription,
                                    font: FontFamily.OpenSans.regular,
                                    textColor: Colors.nelson.color,
                                    numberOfLines: 0)

    let wannaKnowButton: UIButton = {
        $0.backgroundColor = Colors.homer.color
        $0.setTitle(AppStrings.footButton, for: .normal)
        $0.titleLabel?.font = FontFamily.OpenSans.semiBold.font(size: 12.0)
        $0.height(size: 44.0)
        $0.width(size: 226.0)
        return $0
    }(UIButton())


    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Colors.marge.color
        addComponents()
        setConstraints()
    }

    public required init?(coder: NSCoder) {
        fatalError("not implemented yet")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        wannaKnowButton.roundCorners(corners: .allCorners, radius: 20.0)
    }

}

// MARK: - Extensions

public extension FootView {

    // MARK: - Methods

    func addComponents() {
        addSubviews([logoImageView,
                    descriptionLabel,
                    wannaKnowButton], constraints: true)
    }

    func setConstraints() {
        setLogoConstraints()
        setDescriptionConstraints()
        setButtonConstraints()
    }

    func setLogoConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            logoImageView.centerX(to: self)
        ])
    }

    func setDescriptionConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 11.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 99.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -39.0),
            descriptionLabel.centerX(to: self)
        ])
    }

    func setButtonConstraints() {
        NSLayoutConstraint.activate([
            wannaKnowButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 28.0),
            wannaKnowButton.centerX(to: self),
            wannaKnowButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
        ])
    }
}
