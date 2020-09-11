//
//  FiveColors.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/09/11.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

enum FiveColors {
    case blue
    case yellow
    case green
    case pink
    case orange
}

struct FiveColorData {
    let type: FiveColors
    let poemNumbers: [Int]
    let name: String
}

struct FiveColorsDataHolder {
    static let sharedDic: Dictionary<FiveColors,FiveColorData> = [
        .blue: FiveColorData(type: .blue,
                             poemNumbers: [ 3,  5,  6, 12, 14, 24, 30, 31, 50, 57, 61, 62, 69, 70, 74, 75, 76, 82, 91, 100],
                             name: "青"),
        .yellow: FiveColorData(type: .yellow,
                               poemNumbers: [ 2,  7, 10, 18, 32, 33, 37, 39, 46, 47, 55, 60, 78, 79, 81, 85, 87, 89, 94, 96],
                               name: "黄")
    ]
}
