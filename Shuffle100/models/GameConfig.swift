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

//
// 歌選択状態を2箇所で保持している問題発見！！
//
// 歌選択状態の設定箇所 その1
// ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

struct GameConfig {
    var reciteMode: ReciteMode
    var fakeMode: Bool
    var selectedStatus100: SelectedState100
    
    init(selectedBool100: [Bool] = [Bool](repeating: true, count: 100), reciteMode: ReciteMode = .normal, fakeMode: Bool = false) {
        self.reciteMode = reciteMode
        self.fakeMode = fakeMode
        self.selectedStatus100 = SelectedState100(array: selectedBool100)
    }
}

struct Bool100 {
    var bools: [Bool]
    
    init(bools: [Bool] = [Bool](repeating: true, count: 100)) {
        self.bools = bools
    }
}

// 歌選択状態の設定箇所 その2
// ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

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

