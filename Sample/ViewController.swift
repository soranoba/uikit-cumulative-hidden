//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var segmentedControl: UISegmentedControl!
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var textView: UITextView!

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
        self.didChangeSegmentedIndex(segmentedControl)
    }

    @IBAction private func didChangeSegmentedIndex(_ sender: UISegmentedControl) {
        for i in 0..<sender.numberOfSegments {
            let view = self.stackView.arrangedSubviews[i]
            let newHidden = (i == sender.selectedSegmentIndex)
            view.isHidden = newHidden
            if view.isHidden != newHidden {
                UIImpactFeedbackGenerator().impactOccurred()
            }
        }
        self.textView.text = self.stackView.arrangedSubviews.map { "\($0.isHidden)" }.joined(separator: "\n")
    }
}

