//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit

class AsyncBlockOperation: Operation {
    @objc private var _isExecuting: Bool = false
    @objc private var _isFinished: Bool = false
    private var block: (@escaping (() -> Void)) -> Void

    // MARK: - Lifecycle

    public init(block: @escaping ((_ completion: @escaping (() -> Void)) -> Void)) {
        self.block = block
    }

    // MARK: - Operation (Override)

    override public var isAsynchronous: Bool {
        return true
    }

    override public var isExecuting: Bool {
        return _isExecuting
    }

    override public var isFinished: Bool {
        return _isFinished
    }

    override public func start() {
        willChangeValue(for: \.isExecuting)
        _isExecuting = true
        didChangeValue(for: \.isExecuting)

        block {
            self.willChangeValue(for: \.isFinished)
            self._isFinished = true
            self.didChangeValue(for: \.isFinished)

            self.willChangeValue(for: \.isExecuting)
            self._isExecuting = false
            self.didChangeValue(for: \.isExecuting)
        }
    }
}

class ViewController: UIViewController {
    private let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)

    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction private func didTapButton(_ sender: UIButton) {
        OperationQueue.main.addOperation(AsyncBlockOperation { done in
            let task = self.session.dataTask(with: URLRequest(url: URL(string: "https://soranoba.net")!)) { _, _, _ in
                print("dataTask finished")
                done()
            }
            task.resume()
        })
    }
}

