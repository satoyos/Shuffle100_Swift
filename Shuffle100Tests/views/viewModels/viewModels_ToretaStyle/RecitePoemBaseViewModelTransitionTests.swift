//
//  RecitePoemBaseViewModelTransitionTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/10/11.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemBaseViewModelTransitionTests: XCTestCase {

  var viewModel: RecitePoemBaseViewModel!
  var testSettings: Settings!
  var cancellables: Set<AnyCancellable>!

  override func setUpWithError() throws {
    testSettings = Settings()
    testSettings.singerID = "ia"
    viewModel = RecitePoemBaseViewModel(settings: testSettings)
    viewModel.recitePoemViewModel.enableTestMode()
    cancellables = Set<AnyCancellable>()
  }

  override func tearDownWithError() throws {
    viewModel = nil
    testSettings = nil
    cancellables.removeAll()
    cancellables = nil
  }

  // MARK: - Screen Transition Tests
  //
  // 各遷移メソッドの観察対象（title / rotationAngle / currentViewIndex /
  // showingSlideCard / showGameEndView / slideOffset）はすべて
  // `recitePoemViewModel.output.title = ...` のような直接代入か、
  // `input.flipAnimation.send()` / `input.slideAnimation.send(...)` の
  // PassthroughSubject 経由で同期的に走る sink ハンドラで更新されるため、
  // メソッド呼び出し直後に値を読めば検証できる。
  // playNumberedPoem の DispatchQueue.main.asyncAfter は title など観察対象に
  // 影響しないため待つ必要はない。

  func test_stepIntoNextPoem_kamiSide_updatesTitle() throws {
    viewModel.stepIntoNextPoem(number: 5, at: 1, total: 10, side: .kami)

    XCTAssertEqual(viewModel.recitePoemViewModel.output.title, "1首め:上の句 (全10首)")
  }

  // 北海道モード（下の句かるた）では、side: .shimoで呼び出される
  func test_stepIntoNextPoem_shimoSideForHokkaidoMode_updatesTitle() throws {
    viewModel.stepIntoNextPoem(number: 25, at: 3, total: 5, side: .shimo)

    XCTAssertEqual(viewModel.recitePoemViewModel.output.title, "3首め:下の句 (全5首)")
  }

  func test_stepIntoNextPoem_triggersFlipAnimation() throws {
    let initialAngle = viewModel.output.rotationAngle

    viewModel.stepIntoNextPoem(number: 1, at: 1, total: 10, side: .kami)

    XCTAssertEqual(viewModel.output.rotationAngle, initialAngle + 180)
  }

  func test_slideIntoShimo_updatesTitle() throws {
    viewModel.slideIntoShimo(number: 15, at: 2, total: 7)

    XCTAssertEqual(viewModel.recitePoemViewModel.output.title, "2首め:下の句 (全7首)")
  }

  func test_slideIntoShimo_triggersSlideAnimation_whenScreenWidthSet() throws {
    viewModel.screenWidth = 375.0

    viewModel.slideIntoShimo(number: 15, at: 2, total: 7)

    XCTAssertTrue(viewModel.output.showingSlideCard)
  }

  func test_slideIntoShimo_doesNotTriggerSlideAnimation_whenScreenWidthZero() throws {
    viewModel.screenWidth = 0
    var slideCardChanged = false

    viewModel.output.$showingSlideCard
      .dropFirst()
      .sink { _ in
        slideCardChanged = true
      }
      .store(in: &cancellables)

    // slideIntoShimo is synchronous regarding the slide animation; with
    // screenWidth == 0 the slideAnimation send is skipped, so showingSlideCard
    // cannot change. The async playNumberedPoem dispatch does not touch
    // showingSlideCard. Verify directly without an arbitrary wait.
    viewModel.slideIntoShimo(number: 15, at: 2, total: 7)

    XCTAssertFalse(slideCardChanged)
  }

  func test_slideBackToKami_updatesTitle() throws {
    viewModel.slideBackToKami(number: 33, at: 4, total: 8)

    XCTAssertEqual(viewModel.recitePoemViewModel.output.title, "4首め:上の句 (全8首)")
  }

  func test_slideBackToKami_triggersSlideAnimation_whenScreenWidthSet() throws {
    viewModel.screenWidth = 375.0

    viewModel.slideBackToKami(number: 33, at: 4, total: 8)

    XCTAssertTrue(viewModel.output.showingSlideCard)
  }

  func test_slideBackToKami_triggersReverseSlideAnimation() throws {
    viewModel.screenWidth = 375.0

    // slideAnimation の sink は同期的に走り、最初に slideOffset を -375 に設定し、
    // 続けて withAnimation で 0 に戻す（setter は同期）。dropFirst() で初期値を
    // 落として、最初に流れてくる -375 を捕まえる。
    var firstValue: CGFloat?
    viewModel.output.$slideOffset
      .dropFirst()
      .sink { offset in
        if firstValue == nil {
          firstValue = offset
        }
      }
      .store(in: &cancellables)

    viewModel.slideBackToKami(number: 33, at: 4, total: 8)

    XCTAssertEqual(firstValue, -375.0, "Initial slideOffset should be negative (left side)")
  }

  func test_slideBackToKami_doesNotTriggerSlideAnimation_whenScreenWidthZero() throws {
    viewModel.screenWidth = 0
    var slideCardChanged = false

    viewModel.output.$showingSlideCard
      .dropFirst()
      .sink { _ in
        slideCardChanged = true
      }
      .store(in: &cancellables)

    // slideBackToKami is fully synchronous; with screenWidth == 0 the slide
    // animation send is skipped entirely, so no further change to showingSlideCard
    // can occur. Verify directly without an arbitrary wait.
    viewModel.slideBackToKami(number: 33, at: 4, total: 8)

    XCTAssertFalse(slideCardChanged)
  }

  func test_goBackToPrevPoem_updatesTitle() throws {
    viewModel.goBackToPrevPoem(number: 77, at: 1, total: 3)

    XCTAssertEqual(viewModel.recitePoemViewModel.output.title, "1首め:下の句 (全3首)")
  }

  func test_goBackToPrevPoem_triggersReverseFlipAnimation() throws {
    let initialAngle = viewModel.output.rotationAngle

    viewModel.goBackToPrevPoem(number: 77, at: 1, total: 3)

    XCTAssertEqual(viewModel.output.rotationAngle, initialAngle - 180)
  }

  func test_goBackToPrevPoem_updatesCurrentViewIndex() throws {
    let initialIndex = viewModel.output.currentViewIndex

    viewModel.goBackToPrevPoem(number: 77, at: 1, total: 3)

    XCTAssertEqual(viewModel.output.currentViewIndex, initialIndex + 1)
  }

  func test_stepIntoGameEnd_updatesTitle() throws {
    viewModel.stepIntoGameEnd()

    XCTAssertEqual(viewModel.recitePoemViewModel.output.title, "試合終了")
  }

  func test_stepIntoGameEnd_triggersFlipAnimation() throws {
    let initialAngle = viewModel.output.rotationAngle

    viewModel.stepIntoGameEnd()

    XCTAssertEqual(viewModel.output.rotationAngle, initialAngle + 180)
  }

  func test_stepIntoGameEnd_showsGameEndViewImmediately() throws {
    viewModel.stepIntoGameEnd()

    XCTAssertTrue(viewModel.output.showGameEndView)
  }

  func test_stepIntoGameEnd_updatesCurrentViewIndex() throws {
    let initialIndex = viewModel.output.currentViewIndex

    viewModel.stepIntoGameEnd()

    XCTAssertEqual(viewModel.output.currentViewIndex, initialIndex + 1)
  }
}
