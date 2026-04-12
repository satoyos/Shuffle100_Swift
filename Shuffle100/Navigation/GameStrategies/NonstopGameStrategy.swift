//
//  NonstopGameStrategy.swift
//  Shuffle100
//
//  ノンストップモードのゲーム振る舞い。
//  - 上の句あり
//  - 上の句終了後は自動で下の句へ
//  - 下の句終了後は自動で次の歌へ（止まらない）
//  - WhatsNext なし
//

import Foundation

struct NonstopGameStrategy: GameStrategy {
  let forcesShortenedJoka: Bool = false
  let hasKami: Bool = true
  let autoAdvanceFromKami: Bool = true
  let showsWhatsNext: Bool = false

  func nextPhaseAfterJoka(firstPoemNumber: Int) -> GamePhase {
    .kami(number: firstPoemNumber, counter: 1)
  }

  func nextPhaseAfterKami(number: Int, counter: Int) -> GamePhase {
    // ノンストップモード: 自動で下の句へ
    .shimo(number: number, counter: counter)
  }

  func nextPhaseAfterShimo(
    number: Int,
    counter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase {
    if let next = nextPoemNumber {
      return .kami(number: next, counter: nextCounter)
    } else {
      return .gameEnd
    }
  }

  func nextPhaseAfterGoNext(
    currentNumber: Int,
    currentCounter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase {
    // ノンストップモードでは WhatsNext を使わないが、プロトコル準拠のため実装
    if let next = nextPoemNumber {
      return .kami(number: next, counter: nextCounter)
    } else {
      return .gameEnd
    }
  }
}
