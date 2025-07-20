//
//  Digits01ButtonViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/06/21.
//

@testable import Shuffle100
import XCTest

final class Digits01ButtonViewModelTests: XCTestCase {
  
  func testInit() throws {
    // given
    let viewModel = DigitsButtonViewModel<Digits01>(digit: .three)
    // then
    XCTAssertNotNil(viewModel)
    XCTAssertEqual(viewModel.digit, .three)
    XCTAssertEqual(viewModel.output.fillType, .full)
  }
  
  func testNumbersDescription() {
    // given
    let viewModel = DigitsButtonViewModel<Digits01>(digit: .two)
    // when
    let strToDisplay = viewModel.numbersDescription
    // then
    XCTAssertEqual(strToDisplay, "歌番号: 2, 12, 22, 32, 42, 52, 62, 72, 82, 92")
  }
}
