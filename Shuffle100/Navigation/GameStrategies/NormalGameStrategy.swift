//
//  NormalGameStrategy.swift
//  Shuffle100
//
//  通常モード（競技かるた）のゲーム振る舞い。
//  - 上の句あり
//  - 上の句終了後はユーザーのタップ待ち
//  - 下の句終了後は自動的に次の歌へ
//  - WhatsNext なし
//

import Foundation

struct NormalGameStrategy: GameStrategy {
  let forcesShortenedJoka: Bool = false
  let hasKami: Bool = true
  let autoAdvanceFromKami: Bool = false   // ユーザーのタップ待ち
  let showsWhatsNext: Bool = false

  func nextPhaseAfterJoka(firstPoemNumber: Int) -> GamePhase {
    .kami(number: firstPoemNumber, counter: 1)
  }

  func nextPhaseAfterKami(number: Int, counter: Int) -> GamePhase {
    // 通常モード: タップ待ちに遷移
    .waitingForShimo(number: number, counter: counter)
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
    // 通常モードでは WhatsNext を使わないが、プロトコル準拠のため実装
    if let next = nextPoemNumber {
      return .kami(number: next, counter: nextCounter)
    } else {
      return .gameEnd
    }
  }
}
