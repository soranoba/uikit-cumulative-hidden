//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit

@objc class ObservableObject: NSObject {
    @objc dynamic var value: Int = 0
}

@objc class Container: NSObject {
    @objc dynamic var object = ObservableObject()
}

class ViewController: UIViewController {
    private var container = Container()
    private var observation: NSKeyValueObservation?

    // MARK: - Lifecycle

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

    @IBAction private func didTapDangerButton(_ sender: UIButton) {
        let object = container.object
        DispatchQueue.main.async {
            object.value += 1
        }
        container = Container()
        // attention here!!
        observation = container.observe(\.object.value, options: [.new]) { _, _ in
            print("changed")
        }
        DispatchQueue.main.async {
            self.container.object.value += 1
        }
    }

    @IBAction private func didTapSafeButton(_ sender: UIButton) {
        let object = container.object
        DispatchQueue.main.async {
            object.value += 1
        }
        container = Container()
        // attention here!!
        observation = container.object.observe(\.value, options: [.new]) { _, _ in
            print("changed")
        }
        DispatchQueue.main.async {
            self.container.object.value += 1
        }
    }

    @IBAction private func didTapSafe2Button(_ sender: UIButton) {
        let object = container.object
        DispatchQueue.main.async {
            object.value += 1
        }
        // attention here!!
        observation = nil
        container = Container()
        observation = container.observe(\.object.value, options: [.new]) { _, _ in
            print("changed")
        }
        DispatchQueue.main.async {
            self.container.object.value += 1
        }
    }
}

