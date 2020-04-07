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
        XCTContext.runActivity(named: "Subviewsが正しく設置されている") { activity in
            XCTAssertEqual(screen.timeLabel.font.pointSize, timeLabelSizeByDevice())
            XCTAssertNotNil(screen.slider)
            XCTAssertEqual(screen.timeLabel.text, "1.10")
            XCTAssertEqual(screen.slider.value, 1.1)
            XCTAssertNotNil(screen.tryButton)
        }
        
        XCTContext.runActivity(named: "詩を試しに読み上げるPlayerもセットされている") { activity in
            XCTAssertNotNil(screen.kamiPlayer)
            XCTAssertNotNil(screen.shimoPlayer)
        }
            
        XCTContext.runActivity(named: "Playerがセットされている") { activity in
            XCTAssertNotNil(screen.kamiPlayer)
            XCTAssertNotNil(screen.shimoPlayer)
        }
    }
    
    ////// ToDo Next: startCountDownTimer()でtimerがセットされ、
    ////// viewWillDissapear()でtimerが消される。
    func test_createAndDeleteTimer() {
        // given, when
        let screen = IntervalSettingViewController()
        
        XCTContext.runActivity(named: "startCountDownTimer()でtimerがセット押される") { activity in
            // then
            XCTAssertNil(screen.timer)
            // when
            screen.startCountDownTimer()
            // then
            XCTAssertNotNil(screen.timer)
        }
        XCTContext.runActivity(named: "viewWillDissapear()でtimerが消される") { activity in
            // when
            screen.viewWillDisappear(false)
            // then
            XCTAssertNil(screen.timer)
        }
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
