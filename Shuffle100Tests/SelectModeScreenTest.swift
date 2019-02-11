//
//  SelectModeScreenTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/02/09.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class SelectModeScreenTest: XCTestCase {
    var screen: SelectModeViewController!

    override func setUp() {
        screen = SelectModeViewController()
        screen.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_pickerRowsCountIs3() {
        let rowNum = screen.pickerView(screen.picker, numberOfRowsInComponent: 0)
        XCTAssertEqual(rowNum, 3)
    }

    func test_deaultSelectedRowIs0() {
        let selected = screen.picker.selectedRow(inComponent: 0)
        XCTAssertEqual(selected, 0)
    }


}
