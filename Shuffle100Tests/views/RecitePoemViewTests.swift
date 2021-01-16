//
//  RecitePoemViewTests.swift
//  RecitePoemViewTests
//
//  Created by 里 佳史 on 2019/07/05.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class RecitePoemViewTests: XCTestCase {
    
    func test_initRcitePoemView() {
        let view = RecitePoemView()
        view.initView(title: "test")
        XCTAssertNotNil(view)
    }
}
