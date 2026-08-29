//
//  NonstopShimoGameStrategy.swift
//  Shuffle100
//
//  下の句のみを連続再生するノンストップモードのゲーム振る舞い。
//  - 序歌は短縮版
//  - 上の句なし
//  - 下の句終了後は次の歌の下の句へ自動進行
//  - WhatsNext なし
//

import Foundation

struct NonstopShimoGameStrategy: GameStrategy {
  let forcesShortenedJoka = true
  let hasKami = false
  let autoAdvanceFromKami = true
  let showsWhatsNext = false

  func nextPhaseAfterJoka(firstPoemNumber: Int) -> GamePhase {
    .shimo(number: firstPoemNumber, counter: 1)
  }

  func nextPhaseAfterKami(number: Int, counter: Int) -> GamePhase {
    // このモードでは上の句を再生しないため、通常は呼ばれない。
    .shimo(number: number, counter: counter)
  }

  func nextPhaseAfterShimo(
    number: Int,
    counter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase {
    guard let nextPoemNumber else { return .gameEnd }
    return .shimo(number: nextPoemNumber, counter: nextCounter)
  }

  func nextPhaseAfterGoNext(
    currentNumber: Int,
    currentCounter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase {
    // このモードでは WhatsNext を表示しないため、通常は呼ばれない。
    guard let nextPoemNumber else { return .gameEnd }
    return .shimo(number: nextPoemNumber, counter: nextCounter)
  }
}
