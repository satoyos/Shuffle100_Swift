//
//  Array+Diff.swift
//  Poems
//
//  Created by 里 佳史 on 2017/05/16.
//  Originally written by @notohiro in Qiita
//    => http://qiita.com/notohiro/items/2100dfed58f53ff3734c
//
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    typealias E = Element
    func diff(_ other: [E]) -> [E] {
        let all = self + other
        var counter: [E: Int] = [:]
        all.forEach { counter[$0] = (counter[$0] ?? 0) + 1 }
        return all.filter { (counter[$0] ?? 0) == 1 }
    }
}
