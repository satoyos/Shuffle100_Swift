//
//  DurationSettingAudioHandler.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/11/17.
//

import AVFoundation

final class DurationSettingAudioHandler: NSObject,  AVAudioPlayerDelegate  {
    let player1: AVAudioPlayer
    let player2: AVAudioPlayer
    var player1FinishedAction: (() -> Void)?
    var player2FinishedAction: (() -> Void)?
    
    enum HalfPoem: String {
        case h001a
        case h001b
        case h002a
    }
    
    init(halfPoem1: HalfPoem = .h001a, halfPoem2: HalfPoem = .h001b) {
        self.player1 = Self.fetchInabaPlayer(of: halfPoem1)
        self.player2 = Self.fetchInabaPlayer(of: halfPoem2)
        super.init()
        AudioPlayerFactory.shared.setupAudioSession()
    }
    
    func startPlayer1() {
        startPlaying(player1)
    }
    
    func startPlayer2() {
        startPlaying(player2)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        switch player {
        case player1:
            player1FinishedAction?()
        case player2:
            player2FinishedAction?()
        default:
            break
        }
    }
    
    private static func fetchInabaPlayer(of halfPoem: HalfPoem) -> AVAudioPlayer {
        let filename = String(halfPoem.rawValue.dropFirst())
        return AudioPlayerFactory.shared.preparePlayer(folder: "audio/inaba", file: filename, title: filename)
    }
    
    private func startPlaying(_ player: AVAudioPlayer) {
        player.delegate = self
        player.currentTime = 0.0
        player.play()
    }
}
