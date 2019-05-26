//
//  Settings.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/25.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

class Settings {
    var mode: GameConfig
    var recitingConfig: RecitingConfig
    var selectedStatus100: SelectedState100
    
    init(mode: GameConfig = GameConfig(), recitingConfig: RecitingConfig = RecitingConfig(), bool100: Bool100 = Bool100()){
        self.mode = mode
        self.recitingConfig = recitingConfig
        self.selectedStatus100 = SelectedState100(bool100: bool100)
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
}
