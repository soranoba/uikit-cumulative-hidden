//
//  Group.swift
//  SampleLib
//
//  Created by Hinagiku Soranoba on 2024/08/24.
//  Copyright © 2024 Hinagiku Soranoba. All rights reserved.
//

import Foundation
import SwiftUI

public extension Form {
    struct Group<Content: View>: View {
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        public var body: some View {
            VStack(spacing: 2) {
                content
                Text("No, it is Form.Group")
                    .foregroundStyle(Color.red)
            }
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray, lineWidth: 2)
            }
        }
    }
}

#Preview("group") {
    Form.Group {
        Text("Yeeee!!")
    }
}
