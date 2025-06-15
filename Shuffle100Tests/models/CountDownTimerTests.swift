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
        var cancellables = Set<AnyCancellable>()
        let expectetion = XCTestExpectation(description: "Timer is reducing remain time correctly.")
        // when
        timer.start()
        // then
        timer.$remainTime
            .dropFirst()
            .print("remainTime: ")
            .sink { value in
                XCTAssertEqual(value, 2.0)
                expectetion.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectetion], timeout: 1.1)
        
    }
  
  func testStoppingTimerMakesRunningFlagFalse() {
    // given
    let timer = CountDownTimer(startTime: 1.0, interval: 0.1)
    var cancellables = Set<AnyCancellable>()
    timer.start()
    let expectation = XCTestExpectation(description: "Timer running")
    timer.$isRunning
      .dropFirst()
      .sink { _ in
        expectation.fulfill()
      }
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 0.2)
    // when
    timer.stop()
    // then
    XCTAssertFalse(timer.isRunning)
  }
}
