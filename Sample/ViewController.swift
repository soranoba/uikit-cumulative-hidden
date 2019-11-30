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

class ViewController<LoaderType: Loader>: UIViewController where LoaderType.ItemType == Movie
{
    private var loader: LoaderType

    // MARK: - Lifecycle

    init(loader: LoaderType) {
        self.loader = loader
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions

    @IBAction private func didTapButton(_ sender: UIButton) {
        var vc: UIViewController!

        // Failed: Cannot convert value of type 'MovieLoader2' to expected argument type 'LoaderType'
        vc = ViewController(loader: MovieLoader2())
        // OK:
        vc = makeViewControllerWithMovieLoader2()
        // OK:
        vc = InheritedViewController(loader: MovieLoader2())
        present(vc, animated: true, completion: nil)
    }
}

func makeViewControllerWithMovieLoader2() -> ViewController<MovieLoader2> {
    return ViewController(loader: MovieLoader2())
}

class OtherViewController: UIViewController {
    @IBAction private func didTapButton(_ sender: UIButton) {
        // OK:
        let vc = ViewController(loader: MovieLoader2())
        present(vc, animated: true, completion: nil)
    }
}

class InheritedViewController: ViewController<MovieLoader2> {
}
