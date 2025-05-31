//
//  NgramPickerViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/05/14.
//

@testable import Shuffle100
import Combine
import XCTest

final class NgramPickerViewModelTests: XCTestCase {
  var cancellables: Set<AnyCancellable> = []
  
  func testInitViewModel() {
    // given
    let state100 = SelectedState100() // all poems are selected.
    // when
    let viewModel = NgramPickerViewModel(state100: state100)
    // then
    XCTAssertNotNil(viewModel)
    XCTAssertEqual(viewModel.selectedNum, 100)
    XCTAssertEqual(FirstChar.u.buttonViewModel.output.fillType, .full)
  }
  
  func testPartialSelected() {
    // given
    let state100 = SelectedState100()
      .cancelOf(number: 13) // 「つくばねの」を選択から外す
    // when
    let viewModel = NgramPickerViewModel(state100: state100)
    // then
    XCTAssertEqual(viewModel.selectedNum, 99)
    XCTAssertEqual(FirstChar.tsu.buttonViewModel.output.fillType, .partial)
  }
  
  func testTapPartialMakesFull() {
    // given
    let state100 = SelectedState100()
      .cancelOf(number: 13) // 「つくばねの」を選択から外す
    // when
    let viewModel = NgramPickerViewModel(state100: state100)
    // then
    XCTAssertEqual(FirstChar.tsu.buttonViewModel.output.fillType, .partial)
    // when
    viewModel.input.chrButotnTapped.send(.tsu)
    // then
    XCTAssertEqual(FirstChar.tsu.buttonViewModel.output.fillType, .full)
    XCTAssertEqual(viewModel.selectedNum, 100)
  }

  func testTapFullMakesEmpty() {
    // given
    let state100 = SelectedState100()
    let viewModel = NgramPickerViewModel(state100: state100)
    // when
    viewModel.input.chrButotnTapped.send(.shi)
    // then
    XCTAssertEqual(FirstChar.shi.buttonViewModel.output.fillType, .empty)
    XCTAssertEqual(viewModel.selectedNum, 98)
  }
}
