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
        } catch  {
            // 予期しない場合
            fatalError("Category設定失敗")
        }
        // session有効化
        do {
            try session.setActive(true)
        } catch {
            // 予期しない場合
            fatalError("Session有効化失敗")
        }
    }
    
    func prepareOpeningPlayer(folder: String) -> AVAudioPlayer {
        let player: AVAudioPlayer
        
        guard let path = Bundle.main.path(forResource: folder + "/序歌", ofType: "m4a") else {
            fatalError("音源ファイルが見つかりません")
        }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        
        } catch {
            fatalError("序歌のAudioPlayer生成に失敗しました。folder => [\(folder)]\n - Error: \(error.localizedDescription)")
        }
        return player
    }
    
    func preparePlayer(number: Int, side: Side, folder: String) -> AVAudioPlayer {
        let player: AVAudioPlayer
        
        guard let path = Bundle.main.path(forResource: folder + "/" + String(format: "%03d", number) + tailForSide(side), ofType: "m4a") else {
            fatalError("音源ファイルが見つかりません")
        }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
        } catch {
            fatalError("歌番号[\(number)]のAudioPlayer生成に失敗しました。folder => [\(folder)]\n - Error: \(error.localizedDescription)")
        }
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

