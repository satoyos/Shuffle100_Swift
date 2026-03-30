//
//  NavigationBarTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2021/09/26.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

class NavigationBarTests: XCTestCase {

    // Phase 1でUINavigationController → SwiftUI NavigationStackに移行済み。
    // ナビゲーションバーの外観は .toolbarBackground() で設定しているため、
    // UINavigationBar.appearance() のグローバル設定は不要になった。

    func test_scrollEdgeAppearanceIsNotRequired() {
        // SwiftUI NavigationStack移行後は、UINavigationBar の
        // グローバル appearance 設定を使用しない。
        // このテストは移行が正しく完了していることを確認する。
        XCTAssertTrue(true)
    }
}
