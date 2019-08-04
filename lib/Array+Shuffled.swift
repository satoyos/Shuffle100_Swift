//
//  Array+Shuffled.swift
//  Poems
//
//  Created by 里 佳史 on 2017/04/28.
//  Copyright © codelynx <- http://qiita.com/codelynx/items/4c5c6c2faf8315c208fe
//

import Foundation

extension Array {
    
    func shuffled() -> [Element] {
        var results = [Element]()
        var indexes = (0 ..< count).map { $0 }
        while indexes.count > 0 {
            let indexOfIndexes = Int(arc4random_uniform(UInt32(indexes.count)))
            let index = indexes[indexOfIndexes]
            results.append(self[index])
            indexes.remove(at: indexOfIndexes)
        }
        return results
    }
    
}
