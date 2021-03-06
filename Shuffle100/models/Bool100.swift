//
//  Bool100.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/22.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct Bool100: Codable, Equatable {
    var bools: [Bool]
    
    init(bools: [Bool] = allTrueBoolArray()) {
        assert(bools.count == 100, "Bool100 must be initialized with Bool Array of size 100")
        self.bools = bools
    }
    
    static func allSelected() -> Bool100 {
        return self.init(bools: allTrueBoolArray())
    }
    
    static func allUnselected() -> Bool100 {
        return self.init(bools: allFalseBoolArray())
    }
    
    static func allTrueBoolArray() -> [Bool] {
        return [Bool](repeating: true, count: 100)
    }
    
    static func allFalseBoolArray() -> [Bool] {
        return [Bool](repeating: false, count: 100)
    }
}

