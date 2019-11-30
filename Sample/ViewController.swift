//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let observers = NSPointerArray.weakObjects()

    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func didTapButton(_ button: UIButton) {
        let values = (0..<50).map { _ in NSObject() }

        values.forEach { value in
            observers.addPointer(Unmanaged<AnyObject>.passUnretained(value).toOpaque())
        }


        //DispatchQueue.global().async {
            let idx1 = Int.random(in: 0..<50)
            guard let observer = self.observers.pointer(at: idx1) else {
                return
            }
            let object = Unmanaged<AnyObject>.fromOpaque(observer).takeUnretainedValue() as? NSObject
            if let idx2 = self.observers.allObjects.firstIndex(where: { $0 as? NSObject === object }) {
                if idx1 != idx2 {
                    print("invalid!!")
                } else {
                    print("valid!!")
                }
            }
        //}
    }
}

