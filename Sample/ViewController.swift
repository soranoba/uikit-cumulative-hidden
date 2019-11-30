//
//  Copyright © 2024 Hinagiku Soranoba. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    private var isAuthorized: Bool = false

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().requestAuthorization { isAuthorized, _ in
            self.isAuthorized = isAuthorized
        }
    }
}

