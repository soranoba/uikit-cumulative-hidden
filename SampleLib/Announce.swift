//
//  Notice.swift
//  SampleLib
//
//  Created by Hinagiku Soranoba on 2024/08/24.
//  Copyright © 2024 Hinagiku Soranoba. All rights reserved.
//

import Foundation
import SwiftUI

public extension Form {
    struct Announce<Content: View>: View {
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        public var body: some View {
            // In Preview, it is SwiftUI.Group, but it becomes Form.Group on Launch =(
            Group {
                content
            }
        }
    }
}

#Preview {
    Form.Announce {
        Text("Does it use SwiftUI.Group?")
    }
}
