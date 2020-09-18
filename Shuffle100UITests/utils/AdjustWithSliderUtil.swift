//
//  AdjustWithSliderUtil.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/09/18.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol AdjustWithSliderUtils {
    func staticDigitTextExistAround(_ digitValue: CGFloat, in app: XCUIApplication)
}

extension AdjustWithSliderUtils {
    func staticDigitTextExistAround(_ digitValue: CGFloat, in app: XCUIApplication) {
        let equalStr =   String(format: "%.2f", digitValue)
        let smallerStr = String(format: "%.2f", digitValue - 0.01)
        let largerStr  = String(format: "%.2f", digitValue + 0.01)
        // then
        XCTAssert(app.staticTexts[smallerStr].exists || app.staticTexts[equalStr].exists ||
                    app.staticTexts[largerStr].exists)
    }
}
