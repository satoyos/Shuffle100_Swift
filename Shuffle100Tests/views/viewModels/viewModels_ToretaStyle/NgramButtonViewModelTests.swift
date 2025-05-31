//
//  NgramButtonViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/05/11.
//

@testable import Shuffle100
import XCTest

final class NgramButtonViewModelTests: XCTestCase {
  
  func testInit() {
    // given
    let viewModel = NgramButtonViewModel(firstChar: .justOne)
    // then
    XCTAssertNotNil(viewModel)
    XCTAssertEqual(viewModel.output.fillType, .full)
  }
  
}
