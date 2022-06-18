//
//  poem.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2017/04/16, with code generator "swift_poem_creator.rb".
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import Foundation

struct Liner2Parts: Codable {
	var kami: String
	var shimo: String
}

struct Poem: Codable {
    let number: Int
    let poet: String
    let living_years: String
    let liner: [String]
    let in_hiragana: Liner2Parts
    let in_modern_kana: [String]
    let kimari_ji: String
    var searchText: String {
        let multiDimensionalArray: [[String]] = [[String(number)], liner, [in_hiragana.kami, in_hiragana.shimo], in_modern_kana, [poet], [kimari_ji]]
        return multiDimensionalArray.joined().joined(separator: " ")
    }
}

extension Poem {
    // 歌番号と歌文字列からなる文字列を返す
    func strWithNumberAndLiner() -> String {
        return "\(self.number). \(self.liner[0]) \(self.liner[1]) \(self.liner[2]) \(self.liner[3]) \(self.liner[4])"
    }
}
