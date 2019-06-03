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
}

struct Poem100 {
    static var poems = readPoemsFromJson()
    
    static func readPoemsFromJson() -> [Poem] {
        let jsonPath = Bundle.main.path(forResource: "100", ofType: "json")!
        if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
            let decoder = JSONDecoder()
            if let poems = try? decoder.decode([Poem].self, from: jsonData) {
                return poems
            } else {
                fatalError("JSONデータのデコードに失敗")
            }
        } else {
            fatalError("JSONデータの読み込みに失敗")
        }
    }
}
