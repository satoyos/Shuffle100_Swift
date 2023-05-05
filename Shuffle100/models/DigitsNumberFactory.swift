//
//  DigitsNumberFactory.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/05.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import Foundation

// [
//    [ 1, 11, ...,  91],
//    [ 2, 12, ...,  92],
//    ...,
//    [ 9, 19, ...,  99]
//    [10, 20, ..., 100],
// ]
fileprivate func calcCardNumbers01() -> [[Int]] {
    var result = [[Int]]()
    for i in (1...10) {
        var row = [Int]()
        for j in (0..<10) {
            row.append(i + 10*j)
        }
        result.append(row)
    }
    return result
}

fileprivate let numbers01 = calcCardNumbers01()

struct DigitsNumberFacgtory {
    static var cardNumbers01: [[Int]] {
        numbers01
    }
}
