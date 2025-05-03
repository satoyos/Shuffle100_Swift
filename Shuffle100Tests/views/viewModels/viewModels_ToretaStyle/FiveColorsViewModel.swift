//
//  FiveColorsViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/04/19.
//

@testable import Shuffle100
import XCTest
import Combine

final class FiveColorsViewModelTests: XCTestCase {
  var cancellables: Set<AnyCancellable> = []
  
  func testInitViewModel() {
    // given
    let state100 = SelectedState100()
    // when
    let viewModel = FiveColorsViewModel(state100: state100)
    // then
    XCTAssertNotNil(viewModel)
    for color in FiveColors.all {
      XCTAssertEqual(color.buttonViewModel.output.fillType, .full)
    }
  }
  
  func testPartialSelected() {
    // given
    let state100 = SelectedState100()
      .cancelOf(number: 1)
    // then
    XCTAssertEqual(FiveColorsViewModel.fillType(of: .pink, for: state100), .partial)
    XCTAssertEqual(FiveColorsViewModel.fillType(of: .green, for: state100), .full)
  }
  
  func testSelectJust20OfColor() {
    // given
    let state100 = SelectedState100()
    // when
    let viewModel = FiveColorsViewModel(state100: state100)
    // then
    XCTAssertEqual(viewModel.output.state100.selectedNum, 100)
    // when
    viewModel.input.selectJust20OfColor.send(.pink)
    // then
    XCTAssertEqual(viewModel.output.state100.selectedNum, 20)
    XCTAssert(viewModel.output.state100.allSelectedNumbers.contains(1))
    XCTAssertFalse(viewModel.output.state100.allSelectedNumbers.contains(14))
  }
  
  func testAdd20OfColor() {
    // given
    let state100 = SelectedState100()
      .cancelAll()
      .selectInNumbers([2, 4, 7])
    let viewModel = FiveColorsViewModel(state100: state100)
    XCTAssertEqual(viewModel.output.state100.selectedNum, 3)
    // when
    viewModel.input.add20OfColor.send(.yellow)
    // then
    // 既に選ばれている歌と黄色グループは2枚かぶるので、
    // 選ばれている歌の数は21になる
    XCTAssertEqual(viewModel.output.state100.selectedNum, 21)
  }
}
