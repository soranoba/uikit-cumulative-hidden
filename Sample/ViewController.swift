//
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions

    @IBAction private func didTapOpenButton(_ button: UIButton) {
        let vc = PageViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.loadViewIfNeeded()

        // NOTE: Not presented. viewDidAppear is called even if not presented.
        // present(vc, animated: true)
    }
}

