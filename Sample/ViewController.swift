//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit
import SwiftUI
import SampleLib

class ViewController: UIHostingController<AnyView> {

    init() {
        super.init(rootView: AnyView(Form.Announce {
            Text("Does it use SwiftUI.Group?")
        }))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

