//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func didTapButton(_ sender: UIButton) {
        do {
            try Example.execute()
        } catch {
            print("String(describing: type(of: error))  : \(String(describing: type(of: error)))")
            print("\"\\(error)\"                           : \(error)")
            print("type(of: error)                      : \(type(of: error))")
            print("error.localizedDescription           : \(error.localizedDescription)")
        }
    }
}

