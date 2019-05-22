//
//  GameSettings.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/02/09.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

enum ReciteMode: CaseIterable {
    case normal
    case beginner
    case nonstop
}

struct ReciteModeHolder {
    var mode: ReciteMode
    var title: String
}

struct GameConfig {
    var reciteMode: ReciteMode
    var fakeMode: Bool

    init(reciteMode: ReciteMode = .normal, fakeMode: Bool = false) {        self.reciteMode = reciteMode
        self.fakeMode = fakeMode
    }
}

class Settings {
    var mode: GameConfig
    var selectedStatus100: SelectedState100
    
    init(mode: GameConfig = GameConfig(), bool100: Bool100 = Bool100()){
        self.mode = mode
        self.selectedStatus100 = SelectedState100(array: bool100.bools)
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

