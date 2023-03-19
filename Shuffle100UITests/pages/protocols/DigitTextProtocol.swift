//
//  DigitTextProtocol.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/06/02.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

protocol DigitText {
    var app: XCUIApplication { get }
    
    func staticDigitTextExists(around digitValue: CGFloat, before: String) -> Bool
}

extension DigitText {
    func staticDigitTextExists(around digitValue: CGFloat, before postfix: String = "") -> Bool {
        let digitLabels =
            [-0.02, -0.01, 0, 0.01, 0.02].map{String(format: "%.2f" + postfix, $0 + digitValue)}
        return digitLabels.reduce(false){$0 || app.staticTexts[$1].exists }
    }
}
