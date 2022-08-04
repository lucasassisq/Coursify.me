import UIKit
import Core

// MARK: - Class

final class ContentViewController: ViewController<ContentView> {

    let viewModel: ContentViewModel

    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.populate(post: viewModel.post)
        setupRxButton(button: customView.navBarView.leftButton, action: viewModel.back)
    }
}
