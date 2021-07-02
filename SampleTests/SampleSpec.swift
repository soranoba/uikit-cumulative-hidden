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

@testable import Sample

class SampleSpec: QuickSpec {
    override func spec() {
        describe("") {
            it("") {
                let req = GetUserRequest(credential: "xxx")
                expect(req.customHeaders).to(equal(["Authorization": "Basic xxx"]))
                expect(req.headers).to(equal(["Accept": "application/json"]))

                expect([req.customHeaders, req.headers].compactMap { $0 }.joined().map { k, v in k })
                    .to(equal(["Authorization", "Accept"]))
                expect([req.customHeaders, req.headers].compactMap { $0 }.joined().map { k, v in v })
                    .to(equal(["Basic xxx", "application/json"]))

                var headers: [String: String] = [:]
                [req.customHeaders, req.headers].compactMap { $0 }.joined().forEach { k, v in headers[k] = v }
                // NG. expected to equal <["Authorization": "Basic xxx", "Accept": "application/json"]>, got <["Accept": "application/json"]>
                expect(headers).to(equal(["Authorization": "Basic xxx", "Accept": "application/json"]))

                headers = [:]
                [req.customHeaders, req.headers].compactMap { $0 }.joined().forEach { k, v in headers[k] = v; headers[k] = v; }
                // OK. hahaha...
                expect(headers).to(equal(["Authorization": "Basic xxx", "Accept": "application/json"]))

                headers = [:]
                [req.nonOptionalCustomHeaders, req.headers].joined().forEach { k, v in headers[k] = v }
                // OK.
                expect(headers).to(equal(["Authorization": "Basic xxx", "Accept": "application/json"]))

                var headerKeys: [String] = []
                [req.customHeaders, req.headers].compactMap { $0 }.joined().forEach { k, _ in headerKeys.append(k) }
                // OK.
                expect(headerKeys).to(equal(["Authorization", "Accept"]))

                headers = [:]
                for (k, v) in [req.customHeaders, req.headers].compactMap { $0 }.joined() {
                    headers[k] = v
                }
                // OK.
                expect(headers).to(equal(["Authorization": "Basic xxx", "Accept": "application/json"]))
            }
        }
    }
}
