//
//  File.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct SerializedKey {
    static let interval          = "interval_time"
    static let kamiShimoInterval = "kami_shimo_interval"
    static let volume            = "volume"
}

fileprivate struct DefaultValue {
    static let interval:Float = 1.10
    static let kamiShimoInterval = 1.00
    static let volume = 0.8
}

@objc (RecitingSettings)
class RecitingSettings: NSObject, NSCoding {
    var interval: Float
    var kamiShimoInterval: Float
    var volume: Float
    static var shared: RecitingSettings?
    static let userDefaultKey = "reciting_settings"
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(interval, forKey: SerializedKey.interval)
        aCoder.encode(kamiShimoInterval, forKey: SerializedKey.kamiShimoInterval)
        aCoder.encode(volume, forKey: SerializedKey.volume)
    }
    
    init(volume: Float, interval: Float, kamiShimoInterval: Float) {
        self.volume = volume
        self.interval = interval
        self.kamiShimoInterval = kamiShimoInterval
    }
    
    required init?(coder aDecoder: NSCoder) {
        let loadedInterval = aDecoder.decodeObject(forKey: SerializedKey.interval) as! NSNumber
        self.interval         = Float(truncating: loadedInterval)
        let loadedKSInterval = aDecoder.decodeObject(forKey: SerializedKey.kamiShimoInterval) as! NSNumber
        self.kamiShimoInterval = Float(truncating: loadedKSInterval)
        let loadedVolume = aDecoder.decodeObject(forKey: SerializedKey.volume) as! NSNumber
        self.volume = Float(truncating: loadedVolume)
    }
    
    static func salvageDataFromUserDefaults() -> RecitingSettings? {
        if let rsData = UserDefaults.standard.object(forKey: userDefaultKey) {
            let convertedData = rsData as! Data
            do {
                let settings = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(convertedData) as! RecitingSettings
                return settings
            } catch {
                print("レガシーデータ(RecitingSettings)はあるが、Swiftで読み出すことができない！")
                return nil
            }
        }
        return nil
    }
    
    static func deleteLegacySavedData() {
        if let _ = UserDefaults.standard.object(forKey: userDefaultKey) {
            UserDefaults.standard.removeObject(forKey: userDefaultKey)
        }
    }
    
    func debugPrint() {
        print("---------------")
        print("RecitingSettings:")
        print("   volume:            \(volume)")
        print("   interval:          \(interval)")
        print("   kamiShimoInterval: \(kamiShimoInterval)")
        print("---------------")
    }
}
