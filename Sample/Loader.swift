//
//  Loader.swift
//  Sample
//
//  Created by soranoba on 2022/04/26.
//  Copyright © 2022 Hinagiku Soranoba. All rights reserved.
//

import Foundation

public protocol Loader {
    associatedtype ItemType

    func load() -> [ItemType]
}

public struct Movie {
}

public class MovieLoader: Loader {
    public func load() -> [Movie] {
        return [Movie(), Movie()]
    }
}

public class MovieLoader2: Loader {
    public func load() -> [Movie] {
        return [Movie()]
    }
}
