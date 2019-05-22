//
//  Bool100.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/22.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct Bool100 {
    var bools: [Bool]
    
    init(bools: [Bool] = [Bool](repeating: true, count: 100)) {
        self.bools = bools
    }
}

