//
//  BeginnerGameStrategy.swift
//  Shuffle100
//
//  初心者モード（散らし取り）のゲーム振る舞い。
//  - 上の句あり
//  - 上の句終了後は自動で下の句へ
//  - 下の句終了後は「次はどうする？」画面を表示
//

import Foundation

struct BeginnerGameStrategy: GameStrategy {
  let forcesShortenedJoka: Bool = false
  let hasKami: Bool = true
  let autoAdvanceFromKami: Bool = true
  let showsWhatsNext: Bool = true

  func nextPhaseAfterJoka(firstPoemNumber: Int) -> GamePhase {
    .kami(number: firstPoemNumber, counter: 1)
  }

  func nextPhaseAfterKami(number: Int, counter: Int) -> GamePhase {
    // 初心者モード: 自動で下の句へ
    .shimo(number: number, counter: counter)
  }

  func nextPhaseAfterShimo(
    number: Int,
    counter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase {
    // 初心者モード: 次の歌の有無にかかわらず、常に WhatsNext 画面を表示する。
    // ゲーム終了判定は「次の歌へ」ボタンが押された時 (nextPhaseAfterGoNext) で行う。
    .whatsNext(number: number, counter: counter)
  }

  func nextPhaseAfterGoNext(
    currentNumber: Int,
    currentCounter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase {
    if let next = nextPoemNumber {
      return .kami(number: next, counter: nextCounter)
    } else {
      return .gameEnd
    }
  }
}
