import UIKit
import Core
import WebKit

// MARK: - Class

final class ContentView: UIView {

    private let scrollView = UIScrollView()
    private let containerView = UIView()

    let navBarView = AppNavBarView(navButtonStyle: .backAndTextAndRightButton,
                                   backgroundColor: Colors.marge.color)

    let titleLabel = AppLabel(font: FontFamily.OpenSans.bold,
                              alignment: .left,
                              numberOfLines: 0)

    let descriptionLabel = WKWebView()

    let footView = FootView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Colors.nelson.color
        addComponents()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension ContentView {

    func populate(post: Post) {
        titleLabel.attributedText = post.title.rendered.convertHtmlToAttributedStringWithCSS(
            font: FontFamily.OpenSans.bold.font(size: 16.0),
            csscolor: "#2AB598",
            lineheight: 5,
            csstextalign: "left")

        descriptionLabel.loadHTMLString(post.content.rendered, baseURL: nil)
    }
}

// MARK: - Private Extension

private extension ContentView {

    // MARK: - Methods

    func addComponents() {
        containerView.addSubviews([titleLabel, descriptionLabel, footView], constraints: true)
        scrollView.addSubview(containerView, constraints: true)
        addSubviews([navBarView, scrollView], constraints: true)
    }

    func setConstraints() {
        setupNavBarConstraints()
        setScrollViewConstraints()
        setTitleConstraints()
        setDescriptionConstraints()
        setFootViewConstraints()
    }

    func setupNavBarConstraints() {
        navBarView.applyAnchors(ofType: [.top,
                                         .trailing,
                                         .leading], to: self)
    }

    func setScrollViewConstraints() {
        scrollView.applyAnchors(ofType: [.trailing, .leading, .bottom], to: self)
        scrollView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 5.0).isActive = true

        containerView.applyAnchors(ofType: [.top, .trailing, .bottom, .leading], to: scrollView)

        let widthConstraint = containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        widthConstraint.isActive = true

        let heigthConstraint = containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heigthConstraint.priority = UILayoutPriority(250.0)
        heigthConstraint.isActive = true
    }

    func setTitleConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 46.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50.0)
        ])
    }

    func setDescriptionConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26.0)
        ])
        descriptionLabel.height(size: 400.0)
    }

    func setFootViewConstraints() {
        footView.applyAnchors(ofType: [.leading, .trailing], to: self)
        NSLayoutConstraint.activate([
            footView.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 20.0),
            footView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
