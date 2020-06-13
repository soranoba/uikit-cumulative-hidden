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

    override func updateViewConstraints() {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            NSLayoutConstraint.activate(portraitConstraints)
            NSLayoutConstraint.deactivate(landscapeConstraints)
        } else {
            NSLayoutConstraint.activate(landscapeConstraints)
            NSLayoutConstraint.deactivate(portraitConstraints)
        }

        super.updateViewConstraints()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.view.setNeedsUpdateConstraints()
        }, completion: nil)
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
        }, completion: { _ in
            self.view.setNeedsUpdateConstraints()
        })
    }
}

