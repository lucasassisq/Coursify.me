import UIKit
import Core

// MARK: - Class

final class HomeView: UIView {


    // MARK: - Private variables

    private let scrollView = UIScrollView()
    private let containerView = UIView()

    let navBarView = AppNavBarView(navButtonStyle: .titleAndRight,
                                   backgroundColor: Colors.marge.color)


    let stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 15.0
        return $0
    }(UIStackView())

    let footView = FootView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Colors.nelson.color
        addComponents()
        callConstraints()        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Protocol Extension

extension HomeView: ViewProtocol {

    func addComponents() {
        addSubviews([navBarView,
                     scrollView], constraints: true)
        containerView.addSubviews([stackView], constraints: true)
        scrollView.addSubview(containerView, constraints: true)
    }

    func callConstraints() {
        setupNavBarConstraints()
        setScrollViewConstraints()
        setStackViewConstraints()
    }
}

// MARK: - Private Extension

private extension HomeView {

    // MARK: - Private methods

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

    func setStackViewConstraints() {
        stackView.applyAnchors(ofType: [.leading, .trailing], to: self)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
