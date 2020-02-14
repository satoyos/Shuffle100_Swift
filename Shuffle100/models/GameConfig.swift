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
}

struct ReciteModeHolder: Codable {
    var mode: ReciteMode
    var title: String
}

struct GameConfig: Codable {
    var reciteMode: ReciteMode
    var fakeMode: Bool
    var singerID: String

    init(reciteMode: ReciteMode = .normal, fakeMode: Bool = false, singerID: String = "ia") {
        self.reciteMode = reciteMode
        self.fakeMode = fakeMode
        self.singerID = singerID
    }
    
//    func debugPrint() {
//        print("-----------")
//        print("GameConfig:")
//        print("   fake_flg:    \(fakeMode)")
//        print("   reciteMode:  \(reciteMode)")
//    }
}
