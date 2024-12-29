//
//  DurationSettingViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2024/11/12.
//

@testable import Shuffle100
import XCTest
import Combine

final class DurationSettingViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    func testInitViewModel()  {
        // given
        let viewModel = DurationSettingViewModel(startTime: 2.0)
        // then
        XCTAssertEqual(viewModel.output.secText, "2.00")
        XCTAssertEqual(viewModel.binding.startTime, 2.0)
    }

    func testWhenTimerStartsSecLabelChanges() {
        // given
        let viewModel = DurationSettingViewModel(startTime: 2.0)
        // when
        viewModel.input.startTimerRequest.send()
        // then
        let expectation = XCTestExpectation(description: "time label changes correctly!")
        viewModel.output.$secText
            .filter { $0 == "1.98" }
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testWhenTimerStartsIsTimerRunningTurnsToTrue() {
        // given
        let viewModel = DurationSettingViewModel(startTime: 0.5)
        // then
        XCTAssertFalse(viewModel.output.isTimerRunning)
        // when
        viewModel.input.startTimerRequest.send()
        // then
        let expectation = XCTestExpectation(description: "'isTimerRuggning' flag turns to true")
        viewModel.output.$isTimerRunning
            .dropFirst()
            .sink { bool in
                XCTAssertTrue(bool)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testWhenTimerCompletedCountDownIsTimerRunningTurnsToBeFalse() {
        // given
        let viewModel = DurationSettingViewModel(startTime: 0.2)
        // then
        XCTAssertFalse(viewModel.output.isTimerRunning)
        // when
        viewModel.input.startTimerRequest.send()
        // then
        let expectation = XCTestExpectation(description: "'isTimerRuggning' flag returns to be false")
        viewModel.output.$isTimerRunning
            .dropFirst(2)
            .sink { bool in
                XCTAssertFalse(bool)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.3)
    }
    
    func testWhenButtonTappedUserActionsGetDisabled() throws {
        // given
        let viewModel = DurationSettingViewModel(startTime: 0.2)
        // then
        XCTAssertFalse(viewModel.output.isUserActionDisabled)
        // when
        viewModel.input.startTrialCountDownRequest.send()
        // then
        let expectation = XCTestExpectation(description: "User action gets disabled")
        viewModel.output.$isUserActionDisabled
            .sink { bool in
                XCTAssertTrue(bool)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.1)
    }
 
    func testWhenPlayer2FinishedUserActionsGetEnabledAndTimeLabelMustBeReset() {
        let viewModel = DurationSettingViewModel(startTime: 0.2)
        // then
        XCTAssertEqual(viewModel.output.secText, "0.20")
        // when
        viewModel.input.startTrialCountDownRequest.send()
        // then
        let expectation1 = XCTestExpectation(description: "User action gets back enabled")
        let expectation2 = XCTestExpectation(description: "Time label must be reset")
        viewModel.output.$isUserActionDisabled
            .print("in Test")
            .filter { $0 == false }
            .sink { _ in
                expectation1.fulfill()
                if viewModel.output.secText == "0.20" {
                    expectation2.fulfill()
                }
            }
            .store(in: &cancellables)
        wait(for: [expectation1, expectation2], timeout: 20)
    }
    
    func testChangingStartTimeMakesSecTimerChange() {
        // given
        let viewModel = DurationSettingViewModel(startTime: 2.0)
        // then
        XCTAssertEqual(viewModel.output.secText, "2.00")
        // when
        viewModel.binding.startTime = 1.0
        // then
        XCTAssertEqual(viewModel.output.secText, "1.00")
        
    }
}
