//
//  Sec2FViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2024/11/09.
//

@testable import Shuffle100
import XCTest
import Combine

final class Sec2FViewModelTests_toreta: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    func testInitViewModel() throws {
        // given
        let viewModel = Sec2FViewModel(startTime: 2.00, interval: 0.02)
        // then
        XCTAssertEqual(viewModel.output.secText, "2.00")
    }

    func testWhenTimerStartsSecTextChanges() {
        // given
        let viewModel = Sec2FViewModel(startTime: 2.00, interval: 0.02)
        // then
        XCTAssertEqual(viewModel.output.secText, "2.00")
        // when
        viewModel.input.startTimerRequest.send()
        // then
        let expectation = XCTestExpectation(description: "secText changes correctly!")
        viewModel.output.$secText
            .dropFirst()
            .filter{$0 == "1.98"}
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testWhenTimerCompletedCountDownIsTimerRunningReturnsToBeFalse() {
        // given
        let viewModel = Sec2FViewModel(startTime: 0.2, interval: 0.02)
        // then
        XCTAssertFalse(viewModel.output.isTimerRunning)
        // when.
        viewModel.input.startTimerRequest.send()
        // then
        let expectation = XCTestExpectation(description: "'isTimerRuggning' flag returns to be false")
        viewModel.output.$isTimerRunning
            .print("in ReturnFalse Test:")
            .dropFirst(2)
            .sink { bool in
                XCTAssertFalse(bool)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.3)
    }

    func testWhenTimerStartsIsTimerRunningTurnsToTrue() {
        // given
        let viewModel = Sec2FViewModel(startTime: 0.5, interval: 0.02)
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
    
    func testWhenGettingRequestToResetSecTextChangesToGivenTime() {
        // given
        let viewModel = Sec2FViewModel(startTime: 0.04, interval: 0.02)
        // when
        viewModel.input.startTimerRequest.send()
        // then
        let expectation1 = XCTestExpectation(description: "Count down completed")
        viewModel.output.$secText
            .sink { text in
                if text == "0.00" {
                    expectation1.fulfill()
                }
            }
            .store(in: &cancellables)
        wait(for: [expectation1], timeout: 0.10)
        // when
        viewModel.input.resetTimerRequest.send(1.0)
        // then
        XCTAssertEqual(viewModel.output.secText, "1.00")
    }
}
