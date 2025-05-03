//
//  FiveColorButtonViewModelTests.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/04/26.
//

@testable import Shuffle100
import XCTest

final class FiveColorButtonViewModelTests: XCTestCase {

  func testInit() throws {
    // given
    let viewModel = FiveColorButtonViewModel(color: .blue)
    XCTAssertNotNil(viewModel)
  }
  
  func testSetFillType() throws {
    // given
    let viewModel = FiveColorButtonViewModel(color: .blue)
    // then
    XCTAssertEqual(viewModel.output.fillType, .full)  // default value
    // when
    viewModel.input.setFillType.send(.partial)
    // then
    XCTAssertEqual(viewModel.output.fillType, .partial)
  }
}
