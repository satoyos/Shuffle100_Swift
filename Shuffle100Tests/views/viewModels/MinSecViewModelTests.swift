//
//  MinSecViewModelTests.swift
//  TrialButtonAnimationTests
//
//  Created by Yoshifumi Sato on 2024/07/27.
//

@testable import Shuffle100
import Combine
import XCTest

final class MinSecViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func testInitViewModel() {
        // given
        let viewModel = MinSec.ViewModel(startTime: 80, interval: 1)
        // then
        XCTAssertEqual(viewModel.minText, "1")
        XCTAssertEqual(viewModel.secText, "20")
    }
    
    func testWhenTimerStartsMinSecTextChanges() {
        // given
        let viewModel = MinSec.ViewModel(startTime: 60, interval: 1)
        // then
        XCTAssertEqual(viewModel.minText, "1")
        XCTAssertEqual(viewModel.secText, "00")
        // when
        viewModel.startTimer()
        // then
        let expectation = XCTestExpectation(description: "Min and Sec text change correctly!")
        viewModel.$timeTexts
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value.min, "0")
                XCTAssertEqual(value.sec, "59")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.1)
    }

}
