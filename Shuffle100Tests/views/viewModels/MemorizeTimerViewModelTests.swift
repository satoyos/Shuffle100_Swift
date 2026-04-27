//
//  MemorizeTimerViewModelTests.swift
//  Shuffle100Tests
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
        XCTAssertEqual(viewModel.buttonViewModel.output.type, .play)
    }
    
    func testWhenPlayButtonTappedTimerStartCountDown() {
        // given
        let viewModel = MemorizeTimer.ViewModel(minutes: 3)
        let timerViewModel = viewModel.timeViewModel
        let buttonViewModel = viewModel.buttonViewModel
        XCTAssertEqual(buttonViewModel.output.type, .play)
        XCTAssertFalse(timerViewModel.isTimerScheduled)
        // when
        buttonViewModel.input.playButtonTapped.send()
        // then
        XCTAssertEqual(buttonViewModel.output.type, .pause)
        XCTAssertTrue(timerViewModel.isTimerScheduled)
        // cleanup: stop the running Timer so it does not leak across tests
        timerViewModel.stopTimer()
    }
    
    func testWhenRemainTimeGetsTo2minAssingedClosureExecuted() {
        // given
        var isCalled = false
        let givenAction = { isCalled = true }
        let viewModel = MemorizeTimer.ViewModel(totalSec: 121, action2minLeft: givenAction)
        XCTAssertFalse(isCalled)
        // when: simulate one timer tick (121 -> 120 = "2:00")
        viewModel.timeViewModel.tick()
        // then
        XCTAssertTrue(isCalled)
    }

    func testWhenTimeGetsOverPreparedClosureExecuted() {
        // given
        var isCalled = false
        let givenAction = { isCalled = true }
        let viewModel = MemorizeTimer.ViewModel(totalSec: 2, actionTimeOver: givenAction)
        XCTAssertFalse(isCalled)
        // when: simulate timer ticks (2 -> 1, 1 -> 0 = "0:00")
        viewModel.timeViewModel.tick()
        viewModel.timeViewModel.tick()
        // then
        XCTAssertTrue(isCalled)
    }
}
