//
//  NgramDataFactory.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/10.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

struct NgramPickerItem: Codable {
    var id: String
    var title: String
}

struct NgramPickerSecion: Codable {
    var sectionId: String
    var headerTitle: String
    var items: [NgramPickerItem]
}

private let firstCharDic: [String: Character] = [
  "mu": "む",  "su": "す",  "me": "め",  "fu": "ふ",  "sa": "さ",  "ho": "ほ",  "se": "せ",
  "u": "う",  "tsu": "つ",  "shi": "し",  "mo": "も",  "yu": "ゆ",
  "i": "い",  "chi": "ち",  "hi": "ひ",  "ki": "き",
  "ha": "は",  "ya": "や",  "yo": "よ",  "ka": "か",
  "mi": "み",
  "ta": "た",  "ko": "こ",
  "o": "お",  "wa": "わ",
  "na": "な",
  "a": "あ"
]

struct NgramDataFactory {
    static func createNgramPickerSctions() -> [NgramPickerSecion] {
        let jsonPath = Bundle.main.path(forResource: "ngram", ofType: "json")!
        if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
            let decoder = JSONDecoder()
            if let sections = try? decoder.decode([NgramPickerSecion].self, from: jsonData) {
                return sections
            } else {
                fatalError("JSONデータのデコードに失敗")
            }
        } else {
            fatalError("JSONデータの読み込みに失敗")
        }
    }
    
    static func createNgramNumbersDic() -> [String: [Int]] {
        var dic = [String: [Int]]()
        
        for (id, char) in firstCharDic {
            let hitPoems = PoemSupplier.originalPoems.filter{$0.kimari_ji.first == char}
            dic[id] = hitPoems.map{$0.number}
        }
        var justOneArray = [Int]()
        for char in ["mu", "su", "me", "fu", "sa", "ho", "se"] {
            guard let numArray = dic[char] else { fatalError("字[\(char)]に対応する歌番号が見つかりません！")}
            justOneArray += numArray
        }
        dic["just_one"] = justOneArray
        return dic
    }
}
