//
//  AdjustSliderProtocol.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/06/01.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

protocol AdjustSlider {
    var app: XCUIApplication { get }
    var slider: XCUIElement { get }
    
    func adjustSliderToLeftLimit()
    func staticDigitTextExists(around digitValue: CGFloat)
}

extension AdjustSlider {
    func adjustSliderToLeftLimit() {
        slider.adjust(toNormalizedSliderPosition: 0.0)
    }
    
    func staticDigitTextExists(around digitValue: CGFloat) {
        let digitLabels =
            [-0.02, -0.01, 0, 0.01, 0.02].map{String(format: "%.2f", $0 + digitValue)}
        XCTAssert(digitLabels.reduce(false){$0 || app.staticTexts[$1].exists })
    }
}

