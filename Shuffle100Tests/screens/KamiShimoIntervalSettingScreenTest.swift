//
//  KamiShimoIntervalSettingScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/04/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class KamiShimoIntervalSettingScreenTest: XCTestCase {
    
    func test_initialScreen() {
        // given, when
        let screen = KamiShimoIntervalSettingScreen()
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "上の句と下の句の間隔")
        // when
        screen.view.layoutSubviews()
        // then
        XCTContext.runActivity(named: "Subviewsが正しく設置されている") { activity in
            XCTAssertEqual(screen.timeLabel.font.pointSize, timeLabelSizeByDevice())
            XCTAssertNotNil(screen.slider)
            XCTAssertEqual(screen.timeLabel.text, "1.00")
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
    
    func test_createAndDeleteTimer() {
        // given, when
        let screen = KamiShimoIntervalSettingScreen()

        XCTContext.runActivity(named: "startCountDownTimer()でtimerがセットされる") { activity in
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

    func test_currentPlayerGetSetCorrectly() {
        // given, when
        let screen = KamiShimoIntervalSettingScreen()
        screen.loadViewIfNeeded()
        screen.view.layoutSubviews()
        // then
        XCTAssertNil(screen.currentPlayer)

        XCTContext.runActivity(named: "tryButtonが押されたとき、currentPlayerにkamiPlayerがセットされる") { activity in
            // when
            screen.tryButtonTapped(screen.tryButton)
            // then
            XCTAssertEqual(screen.currentPlayer, screen.kamiPlayer)
        }
        XCTContext.runActivity(named: "カウントダウンが終わったとき、currentPlayerにshimoPlayerがセットされる") { activity in
            // when
            screen.remainTime = 0.0
            screen.updateRemainTime(t: Timer())
            // then
            XCTAssertEqual(screen.currentPlayer, screen.shimoPlayer)
        }
    }

    func test_playersGetResetWhenSliderValueChanged() {
        // given, when
        let screen = KamiShimoIntervalSettingScreen()
        screen.loadViewIfNeeded()
        screen.view.layoutSubviews()
        // then
        XCTAssertNotNil(screen.kamiPlayer)
        XCTAssertNotNil(screen.shimoPlayer)
        XCTAssertNil(screen.currentPlayer)
        XCTAssert(screen.tryButton.isEnabled)
        XCTContext.runActivity(named: "tryButtonがタップされると、tryButtonが無効になり、currentPlayerにkamiPlayerがセットされる") { activity in
            // when
            screen.tryButtonTapped(screen.tryButton)
            // then
            XCTAssertFalse(screen.tryButton.isEnabled)
            XCTAssertEqual(screen.currentPlayer, screen.kamiPlayer)
        }
        XCTContext.runActivity(named: "Sliderの値が変わると、tryButtonが有効になり、currnetPlayerがnilになる") { activity in
            // when
            screen.sliderValueChanged(screen.slider)
            // then
            XCTAssert(screen.tryButton.isEnabled)
            XCTAssertNil(screen.currentPlayer)
        }
    }

    func test_playerGetRestWhenViewWillDisappear() {
        // given
        let screen = KamiShimoIntervalSettingScreen()
        screen.loadViewIfNeeded()
        screen.view.layoutSubviews()
        screen.tryButtonTapped(screen.tryButton)
        // when
        screen.viewWillDisappear(false)
        // then
        XCTAssertNil(screen.currentPlayer)
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
