//
//  WaitInUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/07/18.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

protocol WaitInUITest {
    func waitToAppear(for element: XCUIElement, timeout: TimeInterval,
 file: StaticString, line: UInt) -> Void
    func waitToHittable(for element: XCUIElement, timeout: TimeInterval, file: StaticString, line: UInt) -> XCUIElement
    var timeOutSec: TimeInterval { get }
}

extension WaitInUITest {
    var timeOutSec: TimeInterval {
        return 8.0
    }
    
    func waitToAppear(for element: XCUIElement,
                      timeout: TimeInterval = 5,
                      file: StaticString = #file,
                      line: UInt = #line) {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, file: file, line: line)
    }
    
    func waitToHittable(for element: XCUIElement,
                        timeout: TimeInterval = 5,
                        file: StaticString = #file,
                        line: UInt = #line) -> XCUIElement {
        let predicate = NSPredicate(format: "hittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, file: file, line: line)
        return element
    }
}

extension XCTestCase: WaitInUITest {}
