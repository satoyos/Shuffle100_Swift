//
//  CountDownTimerTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2024/07/26.
//

@testable import Shuffle100
import XCTest
import Combine

final class CountDownTimerTests: XCTestCase {

    func testInitCountDownTimer() {
        // given
        let timer = CountDownTimer(startTime: 3.0, interval: 1.0)
        // then
        XCTAssertEqual(timer.remainTime, 3.0)
        XCTAssertFalse(timer.isRunning)
    }

    func testRunningCountDownTimer() {
        // given
        let timer = CountDownTimer(startTime: 3.0, interval: 1.0)
        // when: simulate one timer tick (3.0 -> 2.0)
        timer.tick()
        // then
        XCTAssertEqual(timer.remainTime, 2.0)
    }

  func testStoppingTimerMakesRunningFlagFalse() {
    // given
    let timer = CountDownTimer(startTime: 1.0, interval: 0.1)
    // when: simulate one tick to flip isRunning to true
    timer.tick()
    XCTAssertTrue(timer.isRunning)
    // when
    timer.stop()
    // then
    XCTAssertFalse(timer.isRunning)
  }
}
