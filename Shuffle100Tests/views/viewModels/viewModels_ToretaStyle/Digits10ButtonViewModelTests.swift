//
//  Digits10ButtonViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/07/06.
//

@testable import Shuffle100
import XCTest

final class Digits10ButtonViewModelTests: XCTestCase {
  
  func testInit() throws {
    // given
    let theDigit = Digits10.three
    let viewModel = DigitsButtonViewModel<Digits10>(digit: theDigit)
    // then
    XCTAssertNotNil(viewModel)
    XCTAssertEqual(viewModel.digit, theDigit)
    XCTAssertEqual(viewModel.output.fillType, .full)
  }
  
  func testNumbersDescription() {
      // given
      let viewModel = DigitsButtonViewModel<Digits10>(digit: .two)
      // when
      let strToDisplay = viewModel.numbersDescription
      // then
      XCTAssertEqual(strToDisplay, "歌番号: 20, 21, 22, 23, 24, 25, 26, 27, 28, 29")
    }
}
