//
//  AudioPlayerFactory.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioPlayerFactory {
  static let shared = AudioPlayerFactory()
  
  func setupAudioSession() {
    UIApplication.shared.beginReceivingRemoteControlEvents()
    
    let session = AVAudioSession.sharedInstance()
    do {
      // CategoryをPlaybackにする
      try session.setCategory(.playback, mode: .default)
      // session有効化
      try session.setActive(true, options: [.notifyOthersOnDeactivation])
    } catch {
      //  Do nothing here:
      // 何らかの理由でうまく行かない場合もアプリを落とさない
      //
      // スクリーンタイムで制限されているときなどは、失敗する。
      // しかし、何度かsetupのチャンスを用意することで、どこかで成功するはず。
      // それでも失敗するようなら、どうしようもない。
      //
      //          assertionFailure("AudioSessionの初期設定時エラー: \(error)")
      
    }
    // 初回再生時のロードによる遅延を回避するために、一度カラ準備しておく。
    _ = AudioPlayerFactory.shared.preparePlayer(folder: "audio/misc", file: "250-milliseconds-of-silence", ofType: "mp3", title: "無音(250ms)")
  }
  
  func prepareOpeningPlayer(folder: String) -> AVAudioPlayer {
    let player = preparePlayer(folder: folder, file: "序歌", title: "序歌")
    return player
  }
  
  func preparePlayer(folder: String, file: String, ofType ext: String = "m4a", title: String?) -> AVAudioPlayer {
    let player: AVAudioPlayer
    
    guard let path = Bundle.main.path(forResource: folder + "/" + file, ofType: ext) else {
      fatalError("音源ファイルが見つかりません")
    }
    do {
      player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      
    } catch {
      fatalError("\(title ?? "音源")のAudioPlayer生成に失敗しました。folder => [\(folder)]\n - Error: \(error.localizedDescription)")
    }
    player.prepareToPlay()
    return player
  }
  
  func preparePlayer(number: Int, side: Side, folder: String) -> AVAudioPlayer {
    let file = String(format: "%03d", number) + tailForSide(side)
    let title = "歌番号[\(number)]"
    let player = preparePlayer(folder: folder, file: file, title: title)
    return player
  }
  
  private func tailForSide(_ side: Side) -> String {
    switch side {
    case .kami:
      return "a"
    case .shimo:
      return "b"
    }
  }
}
