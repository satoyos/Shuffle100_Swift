//
//  PoemExt.swift
//  Poems
//
//  Created by 里 佳史 on 2017/04/16.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import Foundation

extension Poem {
    // 歌番号と歌文字列からなる文字列を返す
    func strWithNumberAndLiner() -> String {
        return "\(self.number). \(self.liner[0]) \(self.liner[1]) \(self.liner[2]) \(self.liner[3]) \(self.liner[4])"
    }
}
