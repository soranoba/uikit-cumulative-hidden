//
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit
import Package1
import Package2

class ViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet private var imageView1: UIImageView!
    @IBOutlet private var imageView2: UIImageView!

    // MARK: - Lifecycle

    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView1.image = UIImage.pkg1Image(named: "Image")
        imageView2.image = UIImage.pkg2Image(named: "Image")
    }
}

