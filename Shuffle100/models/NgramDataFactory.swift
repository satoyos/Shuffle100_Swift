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

enum NgramSelectedStatus {
    case full
    case partial
    case none
}

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
           
           
           // pseudo return value
           return ["あ": [1, 3, 4]]
       }
}
