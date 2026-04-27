//
//  MinSecViewModelTests.swift
//  Shuffle100Tests
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
        XCTAssertEqual(viewModel.minText, "1")
        XCTAssertEqual(viewModel.secText, "00")
        // when: simulate one timer tick (60 -> 59)
        viewModel.tick()
        // then
        XCTAssertEqual(viewModel.minText, "0")
        XCTAssertEqual(viewModel.secText, "59")
    }

}
