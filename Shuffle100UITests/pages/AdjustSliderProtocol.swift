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
}

extension AdjustSlider {
    func adjustSliderToLeftLimit() {
        slider.adjust(toNormalizedSliderPosition: 0.0)
    }
}

