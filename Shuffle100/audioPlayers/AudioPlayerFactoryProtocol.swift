//
//  AudioPlayerFactoryProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/10/09.
//

import Foundation
import AVFoundation

/// 音声プレイヤー生成の抽象インターフェース
/// テスト時にモックを注入可能にするためのプロトコル
protocol AudioPlayerFactoryProtocol {
  /// オーディオセッションをセットアップ
  func setupAudioSession()

  /// 序歌用のプレイヤーを準備
  /// - Parameter folder: 音声ファイルのフォルダパス
  /// - Returns: 準備されたプレイヤー、またはnil（ファイルが見つからない場合）
  func prepareOpeningPlayer(folder: String) -> AVAudioPlayer?

  /// 指定されたファイルのプレイヤーを準備
  /// - Parameters:
  ///   - folder: 音声ファイルのフォルダパス
  ///   - file: ファイル名（拡張子なし）
  ///   - ext: ファイル拡張子（デフォルト: "m4a"）
  ///   - title: タイトル（ログ出力用）
  /// - Returns: 準備されたプレイヤー、またはnil（ファイルが見つからない場合）
  func preparePlayer(folder: String, file: String, ofType ext: String, title: String?) -> AVAudioPlayer?

  /// 歌番号とサイド（上の句/下の句）を指定してプレイヤーを準備
  /// - Parameters:
  ///   - number: 歌番号（1-100）
  ///   - side: 上の句(.kami)または下の句(.shimo)
  ///   - folder: 音声ファイルのフォルダパス
  /// - Returns: 準備されたプレイヤー、またはnil（ファイルが見つからない場合）
  func preparePlayer(number: Int, side: Side, folder: String) -> AVAudioPlayer?
}
