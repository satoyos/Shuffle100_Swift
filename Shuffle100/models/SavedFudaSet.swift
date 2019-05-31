//
//  File.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/31.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct SavedFudaSet {
    var name: String
    var bools: [Bool]
    
    init(name: String = "名前を付けましょう", bools: [Bool] = Bool100.allTrueBoolArray()) {
        assert(bools.count == 100)
        self.name = name
        self.bools = bools
    }
}
