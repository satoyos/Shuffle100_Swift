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
    var selectedStatus100: SelectedState100
    
    init(mode: GameConfig = GameConfig(), bool100: Bool100 = Bool100()){
        self.mode = mode
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
}
