//
//  Singer.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/24.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct Singer: Codable {
    let id: String
    let path: String
    let name: String
    let shortenJokaStartTime: Float
}

struct Singers {
    static var all = readSingersFromJson()
    
    static func readSingersFromJson() -> [Singer] {
        let jsonPath = Bundle.main.path(forResource: "Singers", ofType: "json")!
        if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
            let decoder = JSONDecoder()
            if let singers = try? decoder.decode([Singer].self, from: jsonData) {
                return singers
            } else {
                fatalError("読手のJSONデータのデコードに失敗")
            }
        } else {
            fatalError("読手のJSONデータの読み込みに失敗")
        }
    }
    
    static func defaultSinger() -> Singer {
        return all[0]
    }
    
    static func getSingerOfID(_ id: String) -> Singer? {
        if let singer = all.first(where: {$0.id == id}) {
            return singer
        } else {
            return nil
        }
    }
}
