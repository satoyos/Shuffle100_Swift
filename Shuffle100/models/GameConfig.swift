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
