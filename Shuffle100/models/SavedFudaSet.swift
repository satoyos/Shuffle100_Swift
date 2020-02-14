//
//  File.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/31.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct SavedFudaSet: Codable {
    var name: String
    var state100: SelectedState100
    
    init(name: String = "名前を付けましょう", state100: SelectedState100 = SelectedState100()) {
        self.name = name
        self.state100 = state100
    }
}
