//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2020 Hinagiku Soranoba. All rights reserved.
//

import UIKit

@objc protocol ObservableRunnable {
    @objc dynamic var isRunning: Bool { get }
}

protocol Runnable: NSObject, ObservableRunnable {
    func start()
    func stop()
}

class CustomRunner: NSObject, Runnable {
    @objc dynamic var isRunning: Bool = false

    func start() {
        isRunning = true
    }

    func stop() {
        isRunning = false
    }
}

private func observeRunner<T: ObservableRunnable & NSObject, Value>(
    _ object: T, keyPath: KeyPath<T, Value>, options: NSKeyValueObservingOptions = [],
    changeHandler: @escaping (T, NSKeyValueObservedChange<Value>) -> Void
) -> NSKeyValueObservation {
    return object.observe(keyPath, options: options, changeHandler: changeHandler)
}

class ViewController: UIViewController {

    private var observations: [NSKeyValueObservation] = []
    private var runner: Runnable = CustomRunner()
    @objc private var observableRunner: ObservableRunnable & NSObject {
        return runner
    }

    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observations = [
            observe(\.observableRunner.isRunning, options: [.new]) { (_, changed) in
                print("1: \(changed.newValue!)")
            },
//            observableRunner.observe(\.isRunning, options: [.new]) { (_, changed) in
//                print("2: \(changed.newValue!)")
//            },
            observeRunner(observableRunner, keyPath: \.isRunning, options: [.new]) { (_, changed) in
                print("3: \(changed.newValue!)")
            },
        ]
    }

    @IBAction private func didTapButton(_: UIButton) {
        if runner.isRunning {
            runner.stop()
        } else {
            runner.start()
        }
    }
}

