//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2020 Hinagiku Soranoba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var portraitConstraints: [NSLayoutConstraint] = []
    @IBOutlet private var landscapeConstraints: [NSLayoutConstraint] = []

    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if UIApplication.shared.statusBarOrientation.isPortrait {
            NSLayoutConstraint.activate(portraitConstraints)
            NSLayoutConstraint.deactivate(landscapeConstraints)
        } else {
            NSLayoutConstraint.activate(landscapeConstraints)
            NSLayoutConstraint.deactivate(portraitConstraints)
        }
        print("==========")
        print("portraitConstrains: \(portraitConstraints)")
        print("landscapeConstraints: \(landscapeConstraints)")
        print("")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("portraitConstrains: \(portraitConstraints)")
        print("landscapeConstraints: \(landscapeConstraints)")
        print("")
        print("")
    }
}

