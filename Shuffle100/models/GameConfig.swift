//
//  GameSettings.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/02/09.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

enum ReciteMode: String, CaseIterable, Codable {
    case normal
    case beginner
    case nonstop
    case hokkaido
}

struct ReciteModeHolder: Codable {
    var mode: ReciteMode
    var title: String
}

struct GameConfig: Codable {
    private var _reciteMode: ReciteMode?
    var fakeMode: Bool
    var singerID: String
    var postMortemEnabled: Bool?
    var shortenJoka: Bool?
    
    var reciteMode: ReciteMode {
        get { _reciteMode ?? .normal }
        set(mode) {
            self._reciteMode = mode
            if mode != .normal {
                self.fakeMode = false
            }
        }
    }

    init(reciteMode: ReciteMode = .normal, fakeMode: Bool = false, singerID: String = "ia", postMortemEnabled: Bool = false, shortenJoka: Bool = false) {
        self._reciteMode = reciteMode
        self.fakeMode = fakeMode
        self.singerID = singerID
        self.postMortemEnabled = postMortemEnabled
//        self.shortenJoka = shortenJoka
    }
}
