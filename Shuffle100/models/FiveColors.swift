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
    let file: String
}

fileprivate let blueSetNumbers =   [ 3,  5,  6, 12, 14, 24, 30, 31, 50, 57, 61, 62, 69, 70, 74, 75, 76, 82, 91, 100]
fileprivate let yellowSetNumbers = [ 2,  7, 10, 18, 32, 33, 37, 39, 46, 47, 55, 60, 78, 79, 81, 85, 87, 89, 94, 96]
fileprivate let greenSetNumbers =  [ 8,  9, 11, 15, 17, 20, 23, 26, 29, 35, 36, 38, 41, 42, 54, 59, 68, 71, 92, 93]
fileprivate let pinkSetNumbers =   [ 1,  4, 13, 16, 22, 28, 34, 40, 48, 51, 58, 65, 66, 72, 73, 80, 83, 84, 86, 97]
fileprivate let orangeSetNumbers = [19, 21, 25, 27, 43, 44, 45, 49, 52, 53, 56, 63, 64, 67, 77, 88, 90, 95, 98, 99]

struct FiveColorsDataHolder {
    static let sharedDic: Dictionary<FiveColors,FiveColorData> = [
        .blue: FiveColorData(type: .blue, poemNumbers: blueSetNumbers, name: "青", file: "blue.png"),
        .yellow: FiveColorData(type: .yellow, poemNumbers: yellowSetNumbers, name: "黄", file: "yellow.png"),
        .green: FiveColorData(type: .green, poemNumbers: greenSetNumbers, name: "緑", file: "green.png"),
        .pink: FiveColorData(type: .pink, poemNumbers: pinkSetNumbers, name: "桃(ピンク)", file: "pink.png"),
            .orange: FiveColorData(type: .orange, poemNumbers: orangeSetNumbers, name: "橙(オレンジ)", file: "orange.png")
    ]
}
