//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
    private let session = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview({
            let button = UIButton()
            button.setTitleColor(.tintColor, for: .normal)
            button.setTitle("Success", for: .normal)
            button.addTarget(self, action: #selector(didTapSuccessCase(_:)), for: .touchUpInside)
            return button
        }())
        stack.addArrangedSubview({
            let button = UIButton()
            button.setTitleColor(.tintColor, for: .normal)
            button.setTitle("Failure", for: .normal)
            button.addTarget(self, action: #selector(didTapFailureCase(_:)), for: .touchUpInside)
            return button
        }())
        stack.addArrangedSubview({
            let button = UIButton()
            button.setTitleColor(.tintColor, for: .normal)
            button.setTitle("StoreKit", for: .normal)
            button.addTarget(self, action: #selector(didTapStoreKitCase(_:)), for: .touchUpInside)
            return button
        }())
        stack.spacing = 32
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // MARK: - IBAction

    @IBAction private func didTapSuccessCase(_ sender: UIButton) {
        Task {
            print("S-1: isMainThread = \(Thread.isMainThread)")
            _ = try await session.data(from: URL(string: "https://soranoba.net")!)
            print("S-2: isMainThread = \(Thread.isMainThread)")
        }
    }

    @IBAction private func didTapFailureCase(_ sender: UIButton) {
        Task {
            do {
                print("F-1: isMainThread = \(Thread.isMainThread)")
                _ = try await session.data(from: URL(string: "https://no.soranoba.net")!)
            } catch {
                print("F-2: isMainThread = \(Thread.isMainThread)")
            }
        }
    }

    @IBAction private func didTapStoreKitCase(_ sender: UIButton) {
        Task {
            do {
                print("SK-1: isMainThread = \(Thread.isMainThread)")
                let vc = SKStoreProductViewController()
                _ = try await vc.loadProduct(withParameters: [SKStoreProductParameterProductIdentifier: "xxxxxx"])
            } catch {
                print("SK-2: isMainThread = \(Thread.isMainThread)")
            }
        }
    }
}

