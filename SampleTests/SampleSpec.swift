//
//  SampleTests.swift
//  SampleTests
//
//  Created by Hinagiku Soranoba on 2021/05/20.
//  Copyright © 2021 Hinagiku Soranoba. All rights reserved.
//

import XCTest
import Quick
import Nimble

class SampleSpec: QuickSpec {
    override func spec() {
        #if __X_FROM_XCODE_BUILD__
            let isFromXcodeBuild = true
        #else
            let isFromXcodeBuild = false
        #endif

        describe("") {
            it("", flags: [Filter.pending: isFromXcodeBuild]) {
                expect(true).to(beFalse())
            }
        }
    }
}
