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

  // MARK: - 回帰テスト: settings への即時書き戻し
  // Bug: NgramPicker 画面から PoemPicker に戻った際、Badge が 0首 のままになる。
  // 原因: 旧実装では画面離脱時 (tasksForLeavingThisView) にまとめて settings へ
  //       書き戻していたため、NavigationStack pop 時に PoemPicker の onAppear が
  //       先に走って古い値を読んでしまっていた。
  // 期待: タップのたびに settings.state100 が即時更新される。

  func test_settingsInit_tapPropagatesToSettingsImmediately() {
    // given: 0首状態
    let settings = Settings()
    settings.state100 = SelectedState100().cancelAll()
    XCTAssertEqual(settings.state100.selectedNum, 0)

    // when: 一字決まりボタンをタップ
    let viewModel = NgramPickerViewModel(settings: settings)
    viewModel.input.chrButotnTapped.send(.justOne)

    // then: settings もタップ直後に更新されている
    XCTAssertEqual(settings.state100.selectedNum,
                   FirstChar.justOne.poemNumbers.count,
                   "タップ直後に settings.state100 が反映される必要がある")
    XCTAssertEqual(viewModel.output.state100.selectedNum,
                   settings.state100.selectedNum)
  }
}
