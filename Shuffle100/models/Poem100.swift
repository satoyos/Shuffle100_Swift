//
//  Poem100.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/06/07.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import Foundation

extension PoemSupplier {
    struct Poem100 {
        
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
        
        static func createFrom(state100: SelectedState100) -> [Poem] {
            var resultPoems = [Poem]()
            for i in 0..<100 {
                if state100.bools[i] {
                    resultPoems.append(originalPoems[i])
                }
            }
            return resultPoems
        }
    }
}
