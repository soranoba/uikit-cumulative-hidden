//
//  SampleTests.swift
//  SampleTests
//
//  Created by Hinagiku Soranoba on 2021/05/20.
//  Copyright © 2021 Hinagiku Soranoba. All rights reserved.
//

import XCTest

class SampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let arr = NSPointerArray.weakObjects()

        autoreleasepool {
            let values = (0..<50).map { _ in NSObject() }
            values.forEach { value in
                arr.addPointer(Unmanaged<AnyObject>.passUnretained(value).toOpaque())
            }
            XCTAssertEqual(arr.count, 50)
        }
        arr.compact()
        XCTAssertEqual(arr.count, 50)
        XCTAssertEqual(arr.allObjects.count, 0)

        let obj = NSObject()
        arr.addPointer(Unmanaged<AnyObject>.passUnretained(obj).toOpaque())
        let idx = arr.allObjects.firstIndex(where: { _ in true })
        XCTAssertEqual(idx, 0)

        let ptr = arr.pointer(at: 0)
        XCTAssertNil(ptr)

        var targetIdx: Int?
        for idx in 0..<arr.count {
            if arr.pointer(at: idx) != nil {
                targetIdx = idx
            }
        }
        XCTAssertEqual(targetIdx, 50)
    }

    func testExample2() throws {
        let arr = NSPointerArray.weakObjects()

        autoreleasepool {
            let values = (0..<50).map { _ in NSObject() }
            values.forEach { value in
                arr.addPointer(Unmanaged<AnyObject>.passUnretained(value).toOpaque())
            }
            XCTAssertEqual(arr.count, 50)
        }

        // It is because to make that needsCompaction returns true.
        // ref: https://stackoverflow.com/questions/31322290/nspointerarray-weird-compaction
        arr.addPointer(nil)
        arr.compact()
        XCTAssertEqual(arr.count, 0)
        XCTAssertEqual(arr.allObjects.count, 0)

        let obj = NSObject()
        arr.addPointer(Unmanaged<AnyObject>.passUnretained(obj).toOpaque())
        let idx = arr.allObjects.firstIndex(where: { _ in true })
        XCTAssertEqual(idx, 0)

        let ptr = arr.pointer(at: 0)
        XCTAssertNotNil(ptr)

        var targetIdx: Int?
        for idx in 0..<arr.count {
            if arr.pointer(at: idx) != nil {
                targetIdx = idx
            }
        }
        XCTAssertEqual(targetIdx, 0)
    }
}
