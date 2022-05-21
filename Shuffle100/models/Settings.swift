//
//  Settings.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/25.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

final class Settings: Codable {
    static let userDefaultKey = "Settings"
    var mode: GameConfig
    var recitingConfig: RecitingConfig
    var state100: SelectedState100
    var savedFudaSets: [SavedFudaSet]
    
    init(mode: GameConfig = GameConfig(), recitingConfig: RecitingConfig = RecitingConfig(), bool100: Bool100 = Bool100.allSelected, savedFudaSets: [SavedFudaSet] = []){
        self.mode = mode
        self.recitingConfig = recitingConfig
        self.state100 = SelectedState100(bool100: bool100)
        self.savedFudaSets = savedFudaSets
    }
    
    var reciteMode: ReciteMode {
        get {
            return mode.reciteMode
        }
        set(m) {
            mode.reciteMode = m
        }
    }
    
    var fakeMode: Bool {
        get {
            return mode.fakeMode
        }
        set(m) {
            mode.fakeMode = m
        }
    }
    
    var singerID: String {
        get {
            return mode.singerID
        }
        set(m) {
            mode.singerID = m
        }
    }
    
    var volume: Float {
        get {
            return recitingConfig.volume
        }
        set(v) {
            recitingConfig.volume = v
        }
    }
    
    var interval: Float {
        get {
            return recitingConfig.interval
        }
        set(t) {
            recitingConfig.interval = t
        }
    }
    
    var kamiShimoInterval: Float {
        get {
            return recitingConfig.kamiShimoInterval
        }
        set(t) {
            recitingConfig.kamiShimoInterval = t
        }
    }
    
    var postMortemEnabled: Bool {
        get {
            fixPostMotermEnabled()
            return mode.postMortemEnabled!
        }
        set(b) {
            mode.postMortemEnabled = b
        }
    }
    
    var shortenJoka: Bool {
        get {
            fixShortenJoka()
            return mode.shortenJoka!
        }
        set(b) {
            mode.shortenJoka = b
        }
    }
    
    func fixOptionalProperties() {
        fixPostMotermEnabled()
    }
    
    private func fixPostMotermEnabled() {
        guard let _ = mode.postMortemEnabled else {
            mode.postMortemEnabled = false
            return
        }
    }
    
    private func fixShortenJoka() {
        guard let _ = mode.shortenJoka else {
            mode.shortenJoka = false
            return
        }
    }
}
