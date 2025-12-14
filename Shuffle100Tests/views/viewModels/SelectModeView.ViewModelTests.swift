//
//  SelectModeView.ViewModelTests.swift
//  Shuffle100Tests
//

@testable import Shuffle100
import XCTest
import SwiftUI

final class SelectModeViewViewModelTests: XCTestCase {

  func test_initialSelectedModeReturnsSettingsReciteMode() {
    let settings = Settings()
    settings.reciteMode = .beginner
    let viewModel = SelectModeView.ViewModel(
      settings: settings,
      reciteModeHolders: testReciteModes
    )

    XCTAssertEqual(viewModel.selectedMode.wrappedValue, .beginner)
  }

  func test_settingsReciteModeIsUpdatedWhenSelectedModeChanges() {
    let settings = Settings()
    settings.reciteMode = .normal
    let viewModel = SelectModeView.ViewModel(
      settings: settings,
      reciteModeHolders: testReciteModes
    )

    viewModel.selectedMode.wrappedValue = .hokkaido

    XCTAssertEqual(settings.reciteMode, .hokkaido)
  }

  func test_reciteModeHoldersArePreserved() {
    let settings = Settings()
    let testHolders = [
      ReciteModeHolder(mode: .normal, title: "テスト通常"),
      ReciteModeHolder(mode: .nonstop, title: "テストノンストップ")
    ]
    let viewModel = SelectModeView.ViewModel(
      settings: settings,
      reciteModeHolders: testHolders
    )

    XCTAssertEqual(viewModel.reciteModeHolders.count, 2)
    XCTAssertEqual(viewModel.reciteModeHolders[0].mode, .normal)
    XCTAssertEqual(viewModel.reciteModeHolders[0].title, "テスト通常")
    XCTAssertEqual(viewModel.reciteModeHolders[1].mode, .nonstop)
    XCTAssertEqual(viewModel.reciteModeHolders[1].title, "テストノンストップ")
  }

  func test_selectedModeBindingIsBidirectional() {
    let settings = Settings()
    settings.reciteMode = .normal
    let viewModel = SelectModeView.ViewModel(
      settings: settings,
      reciteModeHolders: testReciteModes
    )

    // 初期値の確認
    XCTAssertEqual(viewModel.selectedMode.wrappedValue, .normal)

    // Bindingを通じて値を変更
    viewModel.selectedMode.wrappedValue = .beginner
    XCTAssertEqual(settings.reciteMode, .beginner)

    // Settingsを直接変更してBindingが反映されることを確認
    settings.reciteMode = .nonstop
    XCTAssertEqual(viewModel.selectedMode.wrappedValue, .nonstop)
  }

  func test_settingsReferenceIsPreserved() {
    let settings = Settings()
    settings.reciteMode = .hokkaido
    let viewModel = SelectModeView.ViewModel(
      settings: settings,
      reciteModeHolders: testReciteModes
    )

    // ViewModelが同じSettingsインスタンスを保持していることを確認
    XCTAssertTrue(viewModel.settings === settings)
  }

  // MARK: - Test Helpers

  private var testReciteModes: [ReciteModeHolder] {
    [
      ReciteModeHolder(mode: .normal, title: "通常 (競技かるた)"),
      ReciteModeHolder(mode: .beginner, title: "初心者 (チラし取り)"),
      ReciteModeHolder(mode: .nonstop, title: "ノンストップ (止まらない)"),
      ReciteModeHolder(mode: .hokkaido, title: "下の句かるた (北海道式)")
    ]
  }

}
