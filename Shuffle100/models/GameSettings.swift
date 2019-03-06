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

class GameSettings {
    var reciteMode: ReciteMode
    var fakeMode: Bool
    var selectedStatus100: SelectedState100
    
    init(selectedBool100: [Bool] = [Bool](repeating: true, count: 100), reciteMode: ReciteMode = .normal, fakeMode: Bool = false) {
        self.reciteMode = reciteMode
        self.fakeMode = fakeMode
        self.selectedStatus100 = SelectedState100(array: selectedBool100)
    }
}
