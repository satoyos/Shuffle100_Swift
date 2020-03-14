//
//  IntervalSettingScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/03/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class IntervalSettingScreenTest: XCTestCase {

    func test_initialScreen() {
        // given, when
        let screen = IntervalSettingViewController()
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "歌の間隔の調整")
        // when
        screen.view.layoutSubviews()
        // then
        XCTAssertEqual(screen.timeLabel.font.pointSize, timeLabelSizeByDevice())        
    }
    
    private func timeLabelSizeByDevice() -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 100
        case .pad:
            return 200
        default:
             fatalError("This Device is not supported. Idiom => \(UIDevice.current.userInterfaceIdiom)")
        }
    }
}
