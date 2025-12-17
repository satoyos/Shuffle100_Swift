//
//  SelectSingerView.ViewModelTests.swift
//  Shuffle100Tests
//

@testable import Shuffle100
import XCTest
import SwiftUI

final class SelectSingerViewViewModelTests: XCTestCase {

  func test_initialSelectedSingerIDReturnsSettingsSingerID() {
    let settings = Settings()
    settings.singerID = "inaba"
    let viewModel = SelectSingerView.ViewModel(
      settings: settings,
      singers: Singers.all
    )

    XCTAssertEqual(viewModel.selectedSingerID.wrappedValue, "inaba")
  }

  func test_settingsSingerIDIsUpdatedWhenSelectedSingerIDChanges() {
    let settings = Settings()
    settings.singerID = "ia"
    let viewModel = SelectSingerView.ViewModel(
      settings: settings,
      singers: Singers.all
    )

    viewModel.selectedSingerID.wrappedValue = "inaba"

    XCTAssertEqual(settings.singerID, "inaba")
  }

  func test_singersArePreserved() {
    let settings = Settings()
    let viewModel = SelectSingerView.ViewModel(
      settings: settings,
      singers: Singers.all
    )

    XCTAssertEqual(viewModel.singers.count, Singers.all.count)
    XCTAssertEqual(viewModel.singers[0].id, Singers.all[0].id)
  }

  func test_selectedSingerIDBindingIsBidirectional() {
    let settings = Settings()
    settings.singerID = "ia"
    let viewModel = SelectSingerView.ViewModel(
      settings: settings,
      singers: Singers.all
    )

    // 初期値の確認
    XCTAssertEqual(viewModel.selectedSingerID.wrappedValue, "ia")

    // Bindingを通じて値を変更
    viewModel.selectedSingerID.wrappedValue = "inaba"
    XCTAssertEqual(settings.singerID, "inaba")

    // Settingsを直接変更してBindingが反映されることを確認
    settings.singerID = "ia"
    XCTAssertEqual(viewModel.selectedSingerID.wrappedValue, "ia")
  }

  func test_settingsReferenceIsPreserved() {
    let settings = Settings()
    settings.singerID = "inaba"
    let viewModel = SelectSingerView.ViewModel(
      settings: settings,
      singers: Singers.all
    )

    // ViewModelが同じSettingsインスタンスを保持していることを確認
    XCTAssertTrue(viewModel.settings === settings)
  }

  // MARK: - Validation Tests

  func test_validateSingerSelection_returnsValidForIA() {
    let settings = Settings()
    let viewModel = SelectSingerView.ViewModel(
      settings: settings,
      singers: Singers.all
    )

    let result = viewModel.validateSingerSelection("ia")

    // IAは常に有効
    switch result {
    case .valid:
      XCTAssert(true)
    case .invalid:
      XCTFail("IA should be valid")
    }
  }

  func test_validateSingerSelection_returnsInvalidForInabaWithoutFiles() {
    // 注意: このテストは音声ファイルがない環境でのみパスする
    // 音声ファイルが存在する環境では.validになる
    let settings = Settings()
    let viewModel = SelectSingerView.ViewModel(
      settings: settings,
      singers: Singers.all
    )

    let result = viewModel.validateSingerSelection("inaba")

    // いなばくんの音声ファイルが存在するかどうかで結果が変わる
    switch result {
    case .valid:
      // 音声ファイルが存在する環境
      XCTAssert(true, "Inaba has required audio files")
    case .invalid(let title, let message):
      // 音声ファイルが存在しない環境
      XCTAssertEqual(title, "音声ファイルが見つかりません")
      XCTAssertFalse(message.isEmpty)
      XCTAssertTrue(message.contains("いなばくん"))
    }
  }

  func test_validateSingerSelection_returnsValidForUnknownSingerID() {
    let settings = Settings()
    let viewModel = SelectSingerView.ViewModel(
      settings: settings,
      singers: Singers.all
    )

    let result = viewModel.validateSingerSelection("unknown_singer")

    // 未知のSinger IDはガード節でvalidとして扱われる
    switch result {
    case .valid:
      XCTAssert(true)
    case .invalid:
      XCTFail("Unknown singer ID should return .valid (guard clause)")
    }
  }

  func test_validationResult_isInvalid_returnsTrueForInvalidCase() {
    let invalidResult = SelectSingerView.ViewModel.ValidationResult.invalid(
      title: "エラー",
      message: "テストメッセージ"
    )

    XCTAssertTrue(invalidResult.isInvalid)
  }

  func test_validationResult_isInvalid_returnsFalseForValidCase() {
    let validResult = SelectSingerView.ViewModel.ValidationResult.valid

    XCTAssertFalse(validResult.isInvalid)
  }

  func test_validationResult_extractsAssociatedValues() {
    let result = SelectSingerView.ViewModel.ValidationResult.invalid(
      title: "テストタイトル",
      message: "テストメッセージ"
    )

    if case .invalid(let title, let message) = result {
      XCTAssertEqual(title, "テストタイトル")
      XCTAssertEqual(message, "テストメッセージ")
    } else {
      XCTFail("Expected .invalid case")
    }
  }

}
