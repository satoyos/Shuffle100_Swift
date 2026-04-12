//
//  GamePhase.swift
//  Shuffle100
//
//  ゲーム進行の状態を表す enum。
//  Phase 4 で導入し、Coordinator のクロージャ入れ替えパターンを
//  明示的な状態遷移に置き換える。
//

import Foundation

enum GamePhase: Equatable {
  /// 序歌の読み上げ中
  case joka

  /// 上の句の読み上げ中
  case kami(number: Int, counter: Int)

  /// 上の句終了、ユーザーの再生ボタン待ち（通常モードのみ）
  case waitingForShimo(number: Int, counter: Int)

  /// 下の句の読み上げ中
  case shimo(number: Int, counter: Int)

  /// 北海道モード専用: WhatsNext で「次の歌へ」が押された後、
  /// 現在の歌の下の句をもう一度再生している状態。
  /// 再生終了後は WhatsNext を表示せず、次の歌の下の句へ直接遷移する。
  case shimoRefrainBeforeAdvance(number: Int, counter: Int)

  /// 「次はどうする？」画面表示中（初心者モード、北海道モード）
  case whatsNext(number: Int, counter: Int)

  /// 試合終了
  case gameEnd
}
