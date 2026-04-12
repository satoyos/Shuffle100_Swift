//
//  GameStrategy.swift
//  Shuffle100
//
//  各ゲームモード（通常、初心者、ノンストップ、北海道）の
//  固有の振る舞いを抽象化するプロトコル。
//

import Foundation

/// ゲームモード固有の振る舞いを定義するプロトコル。
/// GameStateManager がこれを使ってモード別の遷移を決定する。
protocol GameStrategy {

  // MARK: - モード特性

  /// 序歌を強制的に短縮版で再生するか（北海道モードのみ true）
  var forcesShortenedJoka: Bool { get }

  /// 上の句の読み上げを行うか（北海道モード以外は true）
  var hasKami: Bool { get }

  /// 上の句終了後、自動で下の句に進むか
  /// - true: 初心者、ノンストップ、北海道
  /// - false: 通常モード（ユーザーの再生ボタンタップ待ち）
  var autoAdvanceFromKami: Bool { get }

  /// 下の句終了後に「次はどうする？」画面を表示するか
  /// - true: 初心者、北海道
  /// - false: 通常、ノンストップ
  var showsWhatsNext: Bool { get }

  // MARK: - 状態遷移ロジック

  /// 序歌読み上げ終了後の次の Phase を返す
  /// - Parameters:
  ///   - firstPoemNumber: 引いた最初の歌番号
  /// - Returns: 次の Phase
  ///   - 北海道モード: `.shimo(first, 1)` （上の句なし）
  ///   - その他: `.kami(first, 1)`
  func nextPhaseAfterJoka(firstPoemNumber: Int) -> GamePhase

  /// 上の句読み上げ終了後の次の Phase を返す
  /// - 通常モード: `.waitingForShimo` （タップ待ち）
  /// - 他: `.shimo`
  func nextPhaseAfterKami(number: Int, counter: Int) -> GamePhase

  /// 下の句読み上げ終了後の次の Phase を返す
  /// - 初心者/北海道: 常に `.whatsNext`（次の歌の有無はここでは判定しない。
  ///   「次の歌へ」が押されたときに `nextPhaseAfterGoNext` で判定する）
  /// - 通常/ノンストップ: 次の歌があれば `.kami`、なければ `.gameEnd`
  func nextPhaseAfterShimo(
    number: Int,
    counter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase

  /// WhatsNext で「次の歌へ」が押された後の次の Phase を返す
  /// （初心者/北海道モードのみで呼ばれる）
  /// - 初心者: 次の歌があれば `.kami(next, ..)`、なければ `.gameEnd`
  /// - 北海道: 次の歌があれば `.shimoRefrainBeforeAdvance(current, ..)`
  ///   （現在の歌の下の句を refrain 再生してから次の歌の下の句へ直接進む）、
  ///   なければ `.gameEnd`
  func nextPhaseAfterGoNext(
    currentNumber: Int,
    currentCounter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase
}
