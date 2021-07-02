//
//  Copyright © 2021 Hinagiku Soranoba. All rights reserved.
//

import Foundation

public protocol Request {
    var customHeaders: [String: String]? { get }
    var nonOptionalCustomHeaders: [String: String] { get }
}

public extension Request {
    var headers: [String: String] {
        return ["Accept": "application/json"]
    }

    var customHeaders: [String: String]? {
        return nil
    }

    var nonOptionalCustomHeaders: [String: String] {
        return [:]
    }
}

public struct GetUserRequest: Request {
    public var customHeaders: [String: String]? {
        return ["Authorization": "Basic \(credential)"]
    }

    public var nonOptionalCustomHeaders: [String: String] {
        return ["Authorization": "Basic \(credential)"]
    }

    private let credential: String

    // MARK: - Lifecycle

    public init(credential: String) {
        self.credential = credential
    }
}

let req = GetUserRequest(credential: "xxx")

func test1() -> [String: String] {
    var headers: [String: String] = [:]
    [req.customHeaders, req.headers].compactMap { $0 }.joined().forEach { k, v in headers[k] = v }
    return headers
}

func test2() -> [String: String] {
    var headers: [String: String] = [:]
    [req.customHeaders, req.headers].compactMap { $0 }.joined().forEach { k, v in headers[k] = v; headers[k] = v; }
    return headers
}
