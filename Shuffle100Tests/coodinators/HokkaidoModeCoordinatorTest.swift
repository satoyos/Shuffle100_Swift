//
//  HokkaidoModeCoordinatorTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2026/02/16.
//
//  北海道モードでのrewind（巻き戻し）問題を再現するテスト。
//  バグ: drawNextPoem()がsideを.kamiに設定するが、北海道モードでは
//  stepIntoShimo()が呼ばれないため、rewindToPrevious()が
//  side == .shimoの条件に合致せず、巻き戻しが効かない。

@testable import Shuffle100
import XCTest

class HokkaidoModeCoordinatorTest: XCTestCase {

  private func makeCoordinator() -> HokkaidoModeCoordinator {
    let nc = UINavigationController()
    let settings = Settings()
    settings.reciteMode = .hokkaido
    return HokkaidoModeCoordinator(
      navigationController: nc, settings: settings, store: StoreManager())
  }

  // MARK: - jokaFinished()後のsideの状態テスト

  /// 北海道モードでjokaFinished()後、sideが.shimoであるべき
  /// （北海道モードは下の句のみを扱うため）
  func test_afterJokaFinished_sideIsShimo() {
    // given
    let coordinator = makeCoordinator()
    let supplier = coordinator.poemSupplier
    coordinator.start()

    // when: jokaFinished()で1首目に進む
    coordinator.jokaFinished()

    // then
    XCTAssertEqual(supplier.currentIndex, 1)
    XCTAssertEqual(
      supplier.side, .shimo,
      "北海道モードではjokaFinished()後にsideが.shimoになるべき"
    )
  }

  /// 北海道モードでreciteShimoFinished()後（2首目）もsideは.shimoであるべき
  func test_afterReciteShimoFinished_sideIsShimo() {
    // given
    let coordinator = makeCoordinator()
    let supplier = coordinator.poemSupplier
    coordinator.start()

    // jokaFinished()で1首目に進む
    coordinator.jokaFinished()
    let firstNumber = supplier.currentPoem!.number

    // when: reciteShimoFinished()で2首目に進む
    coordinator.reciteShimoFinished(number: firstNumber, counter: 1)

    // then
    XCTAssertEqual(supplier.currentIndex, 2)
    XCTAssertEqual(
      supplier.side, .shimo,
      "北海道モードではreciteShimoFinished()後もsideは.shimoであるべき"
    )
  }

  // MARK: - rewind動作テスト

  /// 北海道モードで2首目から1首目にrewindできること
  func test_rewindFromSecondToFirstPoem_works() {
    // given: 2首目まで進む
    let coordinator = makeCoordinator()
    let supplier = coordinator.poemSupplier
    coordinator.start()

    coordinator.jokaFinished()
    let firstNumber = supplier.currentPoem!.number
    coordinator.reciteShimoFinished(number: firstNumber, counter: 1)

    XCTAssertEqual(supplier.currentIndex, 2, "2首目まで進んでいる")

    // when: rewindToPreviousを呼ぶ
    coordinator.rewindToPrevious()

    // then: 1首目に戻っているべき
    XCTAssertEqual(
      supplier.currentIndex, 1,
      "rewind後、1首目に戻るべき"
    )
    XCTAssertEqual(
      supplier.side, .shimo,
      "北海道モードでは戻った後もsideは.shimoであるべき"
    )
  }

  /// 北海道モードで1首目の状態でrewindしたらホーム画面に戻る
  /// （これ以上戻る歌がないため）
  func test_rewindOnFirstPoem_goesBackHome() {
    // given: 1首目の状態
    let coordinator = makeCoordinator()
    let supplier = coordinator.poemSupplier
    coordinator.start()

    coordinator.jokaFinished()
    XCTAssertEqual(supplier.currentIndex, 1, "1首目にいる")

    // when: rewindToPreviousを呼ぶ
    coordinator.rewindToPrevious()

    // then: rollBackPrevPoem()がnilを返し、currentIndexが0になる
    // （backToHomeScreen()が呼ばれるはず）
    XCTAssertEqual(supplier.currentIndex, 0,
      "1首目でrewindするとcurrentIndexが0になる（ホームに戻る）")
  }
}
