//
//  Copyright © 2022 Hinagiku Soranoba. All rights reserved.
//

import Foundation
import UIKit

public extension Bundle {
    static var pkg1ResourceBundle: Bundle {
        let frameworkBundle = Bundle(for: DummyClass.self)
        guard let resourceURL = frameworkBundle.resourceURL?.appendingPathComponent("Resources.bundle"),
              let bundle = Bundle(url: resourceURL) else {
            // Using Carthage
            return frameworkBundle
        }
        // Using CocoaPods
        return bundle
    }
}

public extension UIImage {
    static func pkg1Image(named: String) -> UIImage? {
        return UIImage(named: named, in: Bundle.pkg1ResourceBundle, with: nil)
    }
}

private class DummyClass {}
