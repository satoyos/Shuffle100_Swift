//
//  Digits110PickerViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/07/06.
//

@testable import Shuffle100
import XCTest

final class Digits10PickerViewModelTests: XCTestCase {
  
  func testInitViewModel() throws {
    // given
    let state100 = SelectedState100()
    // when
    let viewModel = DigitsPickerViewModel<Digits10>(state100: state100)
    // then
    XCTAssertNotNil(viewModel)
  }
  
  func testTapPartialMakesFull() {
    // given
    let state100 = SelectedState100()
      .cancelOf(number: 13) // 「つくばねの」を選択から外す
    let digit = Digits10.one
    
    // when
    let viewModel = DigitsPickerViewModel<Digits10>(state100: state100)
    // then
    XCTAssertEqual(digit.buttonViewModel.output.fillType, .partial)
    // when
    viewModel.input.digitButtonTapped.send(digit)
    // then
    XCTAssertEqual(digit.buttonViewModel.output.fillType, .full)
    XCTAssertEqual(viewModel.selectedNum, 100)
  }
  
  func testTapFullMakesEmpty() {
    // given
    let state100 = SelectedState100()
    let viewModel = DigitsPickerViewModel<Digits10>(state100: state100)
    let digit = Digits10.two
    // when
    viewModel.input.digitButtonTapped.send(digit)
    XCTAssertEqual(digit                 .buttonViewModel.output.fillType, .empty)
    XCTAssertEqual(viewModel.selectedNum, 90)
    }
}
