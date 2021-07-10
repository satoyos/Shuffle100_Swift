//
//  AlertObjectable.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/29.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

protocol AlertObjectable {
    associatedtype A11y
    var app: XCUIApplication { get }
    init(app: XCUIApplication)
    var exists: Bool { get }
    var title: XCUIElement { get }
//    var cancelButton: XCUIElement { get }
    func elementsExist(_ elements: [XCUIElement], timeout: Double) -> Bool
}

extension AlertObjectable {
    var app: XCUIApplication {
        return XCUIApplication()
    }
    
    var exists: Bool {
        return elementsExist([title], timeout: 5)
    }
    
    func elementsExist(_ elements: [XCUIElement], timeout: Double) -> Bool {
        return elements.allSatisfy{ $0.waitForExistence(timeout: timeout) }
    }
}
