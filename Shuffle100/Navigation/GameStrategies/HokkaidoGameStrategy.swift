//
//  HokkaidoGameStrategy.swift
//  Shuffle100
//
//  北海道モード（下の句かるた）のゲーム振る舞い。
//  - 序歌は強制的に短縮版で再生
//  - 上の句なし（下の句のみ）
//  - 下の句終了後は「次はどうする？」画面を表示
//

import Foundation

struct HokkaidoGameStrategy: GameStrategy {
  let forcesShortenedJoka: Bool = true
  let hasKami: Bool = false
  let autoAdvanceFromKami: Bool = true   // 上の句がないので意味はないが true
  let showsWhatsNext: Bool = true

  func nextPhaseAfterJoka(firstPoemNumber: Int) -> GamePhase {
    // 北海道モード: 上の句をスキップして直接下の句へ
    .shimo(number: firstPoemNumber, counter: 1)
  }

  func nextPhaseAfterKami(number: Int, counter: Int) -> GamePhase {
    // 北海道モードでは呼ばれない想定だが、プロトコル準拠のため実装
    .shimo(number: number, counter: counter)
  }

  func nextPhaseAfterShimo(
    number: Int,
    counter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase {
    // 北海道モード: 次の歌の有無にかかわらず、常に WhatsNext 画面を表示する。
    // ゲーム終了判定は「次の歌へ」ボタンが押された時 (nextPhaseAfterGoNext) で行う。
    .whatsNext(number: number, counter: counter)
  }

  func nextPhaseAfterGoNext(
    currentNumber: Int,
    currentCounter: Int,
    nextPoemNumber: Int?,
    nextCounter: Int
  ) -> GamePhase {
    // 北海道モード: 「次の歌へ」が押されたら、まず現在の歌の下の句を
    // refrain 再生する。refrain 終了後は WhatsNext を表示せず、
    // 次の歌の下の句へ直接遷移する (GameStateManager 側で処理)。
    guard nextPoemNumber != nil else {
      return .gameEnd
    }
    return .shimoRefrainBeforeAdvance(number: currentNumber, counter: currentCounter)
  }
}
