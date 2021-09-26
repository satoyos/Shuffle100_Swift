//
//  NavigationBarTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2021/09/26.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

class NavigationBarTests: XCTestCase {

    func test_scrollEdgeAppearanceIsSet() {
        // This property must be set after iOS 15, Xcode 13
        XCTAssertNotNil(UINavigationBar.appearance().scrollEdgeAppearance)
    }
}
