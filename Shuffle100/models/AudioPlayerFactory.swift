//
//  AudioPlayerFactory.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import AVFoundation

class AudioPlayerFactory {
    static let shared = AudioPlayerFactory()
    
    func prepareOpeningPlayer(folder: String) -> AVAudioPlayer {
        guard let path = Bundle.main.path(forResource: folder + "/序歌", ofType: "m4a") else {
            fatalError("音源ファイルが見つかりません")
        }
        return AVAudioPlayer()
    }
}
