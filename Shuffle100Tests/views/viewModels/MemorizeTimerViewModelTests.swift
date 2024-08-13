//
//  MemorizeTimerViewModelTests.swift
//  TrialButtonAnimationTests
//
//  Created by Yoshifumi Sato on 2024/07/27.
//

@testable import Shuffle100
import XCTest
import Combine

final class MemorizeTimerViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testInitViewModel() {
        // given
        let viewModel = MemorizeTimer.ViewModel(minutes: 3)
        // then
        XCTAssertEqual(viewModel.timeViewModel.minText, "3")
        XCTAssertEqual(viewModel.timeViewModel.secText, "00")
        XCTAssertEqual(viewModel.buttonViewModel.type, .play)
    }
    
    func testWhenPlayButtonTappedTimerStartCountDown() {
        // given
        let viewModel = MemorizeTimer.ViewModel(minutes: 3)
        let timerViewModel = viewModel.timeViewModel
        let buttonViewModel = viewModel.buttonViewModel
        let expectation1 = XCTestExpectation(description: "setText, minText, button type are all changing correctly")
        buttonViewModel.playButtonTapped()
        timerViewModel.$timeTexts
            .dropFirst()
            .filter { minTexts in minTexts == ("2", "59")}
            .delay(for: 0.01, scheduler: RunLoop.main)
            .sink { value in
//                XCTAssertEqual(value.sec, "59")
//                XCTAssertEqual(value.min, "2")
                XCTAssertEqual(buttonViewModel.type, .pause)
                expectation1.fulfill()
            }
            .store(in: &cancellables)
        // when
        // then
        wait(for: [expectation1], timeout: 1.1)
    }
    
    func testWhenRemainTimeGetsTo2minAssingedClosureExecuted() {
        // given
        var isCalled = false
        let givenAction = { isCalled = true }
        let viewModel = MemorizeTimer.ViewModel(totalSec: 121, action2minLeft: givenAction)
        // then
        XCTAssertFalse(isCalled)
        // when
        viewModel.timeViewModel.startTimer()
        // then
        let expectation = XCTestExpectation(description: "action2minLeft has been executed!")
        viewModel.timeViewModel.$timeTexts
            .dropFirst()
            .filter { minTexts in minTexts == ("2", "00")}
            .delay(for: 0.01, scheduler: RunLoop.main)
            .sink { minSecText in
//                XCTAssertEqual(minSecText.min, "2")
//                XCTAssertEqual(minSecText.sec, "00")
                XCTAssertTrue(isCalled)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.1)
    }
    
    func testWhenTimeGetsOverPreparedClosureExecuted() {
        // given
        var isCalled = false
        let givenAction = { isCalled = true }
        let viewModel = MemorizeTimer.ViewModel(totalSec: 2, actionTimeOver: givenAction)
        // then
        XCTAssertFalse(isCalled)
        // when
        viewModel.timeViewModel.startTimer()
        // then
        let expectation = XCTestExpectation(description: "action for time over has been executed!")
        viewModel.timeViewModel.$timeTexts
            .dropFirst()
            .filter{ $0.sec == "00" }
            .delay(for: 0.05, scheduler: RunLoop.main)
            .sink { minSecText in
                XCTAssertTrue(isCalled)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 2.1)
    }
}
