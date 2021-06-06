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
    
    func adjustSliderToLeftLimit() -> Self
    func adjustSliderToRightLimit() -> Self
}

extension AdjustSlider {
    @discardableResult
    func adjustSliderToLeftLimit() -> Self {
        slider.adjust(toNormalizedSliderPosition: 0.0)
        return self
    }
    
    @discardableResult
    func adjustSliderToRightLimit() -> Self {
        slider.adjust(toNormalizedSliderPosition: 1.0)
        return self
    }
}

