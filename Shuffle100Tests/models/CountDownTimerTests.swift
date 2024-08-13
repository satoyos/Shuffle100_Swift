//
//  CountDownTimerTests.swift
//  TrialButtonAnimationTests
//
//  Created by Yoshifumi Sato on 2024/07/26.
//

@testable import Shuffle100
import XCTest
import Combine

final class CountDownTimerTests: XCTestCase {

    func testInitCountDownTimer() {
        // given
        let timer = CountDownTimer(startTime: 3.0, intarval: 1.0)
        // then
        XCTAssertEqual(timer.remainTime, 3.0)
        XCTAssertFalse(timer.isRunning)
    }

    func testRunningCountDownTimer() {
        // given
        let timer = CountDownTimer(startTime: 3.0, intarval: 1.0)
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
}
