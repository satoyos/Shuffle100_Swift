//
//  Bool100.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/22.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

typealias Bool100 = [Bool]

extension Bool100 {
    static var allSelected: Bool100 {
        [Bool](repeating: true, count: 100)
    }
    
    static var allUnselected: Bool100 {
        [Bool](repeating: false, count: 100)
    }
}


