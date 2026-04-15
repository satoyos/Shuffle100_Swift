//
//  GameStateManager.swift
//  Shuffle100
//
//  ゲーム進行状態 (GamePhase) を管理し、PoemSupplier / RecitePoemBaseViewModel /
//  GameStrategy を束ねる ObservableObject。
//
//  旧 Coordinator ではクロージャ (playerFinishedAction 等) を動的に入れ替える
//  ことで状態遷移を実現していたが、本クラスでは:
//    - 初期化時に BaseViewModel のクロージャを一度だけ固定
//    - 現在の GamePhase を見て次の遷移を決定
//  という明示的な状態機械として実装する。
//

import Combine
import Foundation
import SwiftUI

final class GameStateManager: ObservableObject {

  // MARK: - Published State

  /// 現在のゲーム進行状態
  @Published private(set) var phase: GamePhase = .joka

  // MARK: - Dependencies

  let baseViewModel: RecitePoemBaseViewModel
  let poemSupplier: PoemSupplier
  let strategy: GameStrategy
  let settings: Settings
  let store: StoreManager

  // MARK: - External Callbacks
  // 外部 (GamePlayView) から設定する。画面遷移やシート表示は AppRouter 経由で行う。

  /// 「次はどうする?」画面を表示する
  var onPresentWhatsNext: ((Poem) -> Void)?
  /// ホーム画面に戻る
  var onBackToHome: (() -> Void)?
  /// 読み上げ設定画面を開く
  var onOpenSettings: (() -> Void)?

  // MARK: - Init

  init(
    settings: Settings,
    store: StoreManager,
    strategy: GameStrategy,
    poemSupplier: PoemSupplier? = nil,
    audioPlayerFactory: AudioPlayerFactoryProtocol = AudioPlayerFactory.shared
  ) {
    self.settings = settings
    self.store = store
    self.strategy = strategy

    if let supplied = poemSupplier {
      self.poemSupplier = supplied
    } else {
      let deck = settings.state100.convertToDeck()
      let supplier = PoemSupplier(deck: deck, shuffle: true)
      if settings.fakeMode {
        supplier.addFakePoems()
      }
      self.poemSupplier = supplier
    }

    self.baseViewModel = RecitePoemBaseViewModel(
      settings: settings,
      audioPlayerFactory: audioPlayerFactory
    )

    wireBaseViewModelActions()
  }

  // MARK: - Action Wiring
  // BaseViewModel 側のクロージャは init 時に一度だけ設定する。
  // phase 依存の分岐はすべて本クラス内のハンドラで行う。

  private func wireBaseViewModelActions() {
    baseViewModel.playerFinishedAction = { [weak self] in
      self?.handlePlayerFinished()
    }
    baseViewModel.playButtonTappedAfterFinishedReciting = { [weak self] in
      self?.handlePlayButtonTapped()
    }
    baseViewModel.skipToNextScreenAction = { [weak self] in
      self?.handleSkipToNext()
    }
    baseViewModel.recitePoemViewModel.backToPreviousAction = { [weak self] in
      self?.handleRewind()
    }
    baseViewModel.recitePoemViewModel.openSettingsAction = { [weak self] in
      self?.onOpenSettings?()
    }
    baseViewModel.recitePoemViewModel.backToHomeScreenAction = { [weak self] in
      self?.onBackToHome?()
    }
    baseViewModel.recitePoemViewModel.startPostMortemAction = { [weak self] in
      self?.startPostMortem()
    }
  }

  // MARK: - Game Lifecycle

  /// ゲーム開始: 序歌を再生する。
  /// GamePlayView の .onAppear から呼ばれる想定。
  func startGame() {
    phase = .joka
    baseViewModel.initView(title: "序歌")
    let shorten = strategy.forcesShortenedJoka || settings.shortenJoka
    baseViewModel.recitePoemViewModel.playJoka(shorten: shorten)
  }

  /// 感想戦開始: PoemSupplier をリセットして再度 startGame する。
  func startPostMortem() {
    poemSupplier.resetCurrentIndex()
    startGame()
  }

  // MARK: - Phase Handlers

  /// 音声再生が完了したときの処理 (playerFinishedAction)
  private func handlePlayerFinished() {
    switch phase {
    case .joka:
      advanceFromJoka()

    case .kami(let number, let counter):
      advanceFromKami(number: number, counter: counter)

    case .waitingForShimo:
      // 通常モードでユーザーのタップ待ち中に音声イベントは発生しない想定。
      break

    case .shimo(let number, let counter):
      advanceFromShimo(number: number, counter: counter)

    case .shimoRefrainBeforeAdvance:
      advanceFromShimoRefrain()

    case .whatsNext, .gameEnd:
      break
    }
  }

  /// 再生ボタンが押されたときの処理 (playButtonTappedAfterFinishedReciting)
  /// - 主に通常モードで kami 終了後の「再生ボタン待ち」で使用される。
  private func handlePlayButtonTapped() {
    if case .waitingForShimo(let number, let counter) = phase {
      advanceToShimo(number: number, counter: counter)
    }
  }

  /// スキップ/早送りボタンが押されたときの処理 (skipToNextScreenAction)
  private func handleSkipToNext() {
    switch phase {
    case .kami(let number, let counter) where !strategy.autoAdvanceFromKami:
      // 通常モード: kami 中の skip は waitingForShimo を経由せず直接 shimo へ
      advanceToShimo(number: number, counter: counter)

    case .waitingForShimo(let number, let counter):
      advanceToShimo(number: number, counter: counter)

    default:
      handlePlayerFinished()
    }
  }

  /// 巻き戻しボタンが押されたときの処理 (backToPreviousAction)
  private func handleRewind() {
    switch phase {
    case .joka:
      // 序歌の冒頭で rewind が押された → ホームへ戻る
      onBackToHome?()

    case .kami:
      // 上の句の冒頭で rewind → 一つ前の歌の下の句へ
      goBackToPreviousPoem()

    case .waitingForShimo(let number, let counter),
         .shimo(let number, let counter):
      if strategy.hasKami {
        // 下の句側で rewind → 現在の歌の上の句に戻す
        phase = .kami(number: number, counter: counter)
        poemSupplier.backToKami()
        baseViewModel.slideBackToKami(
          number: number,
          at: counter,
          total: poemSupplier.size
        )
      } else {
        // 北海道モード: 上の句がないので、一つ前の歌の下の句に戻す
        _ = number; _ = counter
        goBackToPreviousPoem()
      }

    case .shimoRefrainBeforeAdvance, .whatsNext, .gameEnd:
      // これらのフェーズからの rewind は現仕様では未サポート
      break
    }
  }

  // MARK: - WhatsNext Actions
  // 「次はどうする?」画面のボタンから呼ばれる。

  /// 下の句をもう一度読み返す。
  func handleRefrainShimo() {
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex
    // refrain 後は通常の下の句終了と同じ挙動 (whatsNext 再表示) を期待する。
    phase = .shimo(number: number, counter: counter)
    baseViewModel.refrainShimo(number: number, count: counter)
  }

  /// 「次の歌へ」が押されたときの処理。
  func handleGoNext() {
    guard case .whatsNext(let currentNumber, let currentCounter) = phase else {
      return
    }
    // 次の歌があるかをここで判定する。drawNextPoem() は実際に supplier を
    // 進めてしまうため、Strategy に遷移先を問い合わせたあとで実際の draw を行う。
    let nextCounter = currentCounter + 1
    let hasNext = nextCounter <= poemSupplier.size

    let nextPhase = strategy.nextPhaseAfterGoNext(
      currentNumber: currentNumber,
      currentCounter: currentCounter,
      nextPoemNumber: hasNext ? 0 : nil,   // 存在判定用ダミー値
      nextCounter: nextCounter
    )

    switch nextPhase {
    case .gameEnd:
      phase = .gameEnd
      baseViewModel.stepIntoGameEnd()

    case .shimoRefrainBeforeAdvance(let n, let c):
      // 北海道モード: 現在の歌の下の句を refrain 再生。終了後に
      // advanceFromShimoRefrain() で次の歌の下の句に直接進む。
      phase = .shimoRefrainBeforeAdvance(number: n, counter: c)
      baseViewModel.refrainShimo(number: n, count: c)

    case .kami:
      // 初心者モード: 次の歌の上の句へ
      guard let nextPoem = poemSupplier.drawNextPoem() else {
        phase = .gameEnd
        baseViewModel.stepIntoGameEnd()
        return
      }
      let number = nextPoem.number
      let counter = poemSupplier.currentIndex
      phase = .kami(number: number, counter: counter)
      baseViewModel.stepIntoNextPoem(
        number: number,
        at: counter,
        total: poemSupplier.size,
        side: .kami
      )

    default:
      // 想定外: 念のため何もしない
      break
    }
  }

  /// 「終了」が押されたときの処理。
  func handleExitGame() {
    onBackToHome?()
  }

  // MARK: - Private Advance Helpers

  private func advanceFromJoka() {
    guard let firstPoem = poemSupplier.drawNextPoem() else {
      phase = .gameEnd
      baseViewModel.stepIntoGameEnd()
      return
    }

    let nextPhase = strategy.nextPhaseAfterJoka(firstPoemNumber: firstPoem.number)

    switch nextPhase {
    case .kami(let number, let counter):
      phase = .kami(number: number, counter: counter)
      baseViewModel.stepIntoNextPoem(
        number: number,
        at: counter,
        total: poemSupplier.size,
        side: .kami
      )

    case .shimo(let number, let counter):
      // 北海道モード: 序歌直後に下の句から開始
      poemSupplier.stepIntoShimo()
      phase = .shimo(number: number, counter: counter)
      baseViewModel.stepIntoNextPoem(
        number: number,
        at: counter,
        total: poemSupplier.size,
        side: .shimo
      )

    default:
      break
    }
  }

  private func advanceFromKami(number: Int, counter: Int) {
    let nextPhase = strategy.nextPhaseAfterKami(number: number, counter: counter)

    switch nextPhase {
    case .waitingForShimo(let n, let c):
      // 通常モード: ユーザーのタップ待ち。
      // 旧 Coordinator と同様、この時点で supplier を shimo 側に進めておく。
      poemSupplier.stepIntoShimo()
      phase = .waitingForShimo(number: n, counter: c)
      baseViewModel.recitePoemViewModel.showAsWaitingForPlay()

    case .shimo(let n, let c):
      // 初心者/ノンストップ: 自動で下の句へ
      advanceToShimo(number: n, counter: c)

    default:
      break
    }
  }

  private func advanceFromShimo(number: Int, counter: Int) {
    if strategy.showsWhatsNext {
      // 初心者/北海道: 次の歌の有無にかかわらず WhatsNext 画面を表示する。
      phase = .whatsNext(number: number, counter: counter)
      if let current = poemSupplier.currentPoem {
        onPresentWhatsNext?(current)
      }
      return
    }

    // 通常/ノンストップ: 次の歌があれば kami へ、なければゲーム終了
    guard let nextPoem = poemSupplier.drawNextPoem() else {
      phase = .gameEnd
      baseViewModel.stepIntoGameEnd()
      return
    }
    let nextNumber = nextPoem.number
    let nextCounter = poemSupplier.currentIndex
    phase = .kami(number: nextNumber, counter: nextCounter)
    baseViewModel.stepIntoNextPoem(
      number: nextNumber,
      at: nextCounter,
      total: poemSupplier.size,
      side: .kami
    )
  }

  private func advanceFromShimoRefrain() {
    // 北海道モード: 現在の下の句 refrain が終わった。
    // WhatsNext を挟まずに次の歌の下の句へ直接遷移する。
    guard let nextPoem = poemSupplier.drawNextPoem() else {
      phase = .gameEnd
      baseViewModel.stepIntoGameEnd()
      return
    }
    poemSupplier.stepIntoShimo()
    let number = nextPoem.number
    let counter = poemSupplier.currentIndex
    phase = .shimo(number: number, counter: counter)
    baseViewModel.stepIntoNextPoem(
      number: number,
      at: counter,
      total: poemSupplier.size,
      side: .shimo
    )
  }

  private func advanceToShimo(number: Int, counter: Int) {
    poemSupplier.stepIntoShimo()
    phase = .shimo(number: number, counter: counter)
    baseViewModel.slideIntoShimo(
      number: number,
      at: counter,
      total: poemSupplier.size
    )
  }

  private func goBackToPreviousPoem() {
    guard let prevPoem = poemSupplier.rollBackPrevPoem() else {
      // もう戻す歌がない (1首目)
      onBackToHome?()
      return
    }
    let number = prevPoem.number
    let counter = poemSupplier.currentIndex
    // rollBackPrevPoem() 後は下の句に戻す
    poemSupplier.stepIntoShimo()
    phase = .shimo(number: number, counter: counter)
    baseViewModel.goBackToPrevPoem(
      number: number,
      at: counter,
      total: poemSupplier.size
    )
  }
}
