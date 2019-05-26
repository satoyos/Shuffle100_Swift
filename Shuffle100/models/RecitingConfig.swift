//
//  File.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/26.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct RecitingConfig {
    var volume: Float = 1.0
    var interval: Float = 1.10
    var kamiShimoInterval: Float = 1.0
    
    func debugPrint() {
        print("---------------")
        print("RecitingConfig:")
        print("   volume:            \(volume)")
        print("   interval:          \(interval)")
        print("   kamiShimoInterval: \(kamiShimoInterval)")
        print("---------------")
    }
}