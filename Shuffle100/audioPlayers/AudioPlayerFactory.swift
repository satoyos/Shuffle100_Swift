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
          try session.setActive(true, options: .notifyOthersOnDeactivation)  // ← 次はここにオプションを設定する予定
        } catch {
          // 何らかの理由でうまく行かない場合 (その場合もアプリを落とさない)
//          fatalError("Session有効化失敗")
          assertionFailure("AudioSessionの初期設定時エラー: \(error)")
        }
    }
    
    func prepareOpeningPlayer(folder: String) -> AVAudioPlayer {
//        let player: AVAudioPlayer
//
//        guard let path = Bundle.main.path(forResource: folder + "/序歌", ofType: "m4a") else {
//            fatalError("音源ファイルが見つかりません")
//        }
//        do {
//            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//
//        } catch {
//            fatalError("序歌のAudioPlayer生成に失敗しました。folder => [\(folder)]\n - Error: \(error.localizedDescription)")
//        }
        let player = preparePlayer(folder: folder, file: "序歌", title: "序歌")
        return player
    }
    
    func preparePlayer(folder: String, file: String, title: String?) -> AVAudioPlayer {
        let player: AVAudioPlayer
        
        guard let path = Bundle.main.path(forResource: folder + "/" + file, ofType: "m4a") else {
            fatalError("音源ファイルが見つかりません")
        }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        
        } catch {
            fatalError("\(title ?? "音源")のAudioPlayer生成に失敗しました。folder => [\(folder)]\n - Error: \(error.localizedDescription)")
        }
        return player
    }
    
    func preparePlayer(number: Int, side: Side, folder: String) -> AVAudioPlayer {
//        let player: AVAudioPlayer
//
//        guard let path = Bundle.main.path(forResource: folder + "/" + String(format: "%03d", number) + tailForSide(side), ofType: "m4a") else {
//            fatalError("音源ファイルが見つかりません")
//        }
//        do {
//            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//
//        } catch {
//            fatalError("歌番号[\(number)]のAudioPlayer生成に失敗しました。folder => [\(folder)]\n - Error: \(error.localizedDescription)")
//        }
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

