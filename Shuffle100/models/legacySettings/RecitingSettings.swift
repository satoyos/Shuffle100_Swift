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
    var kamiSimoInterval: Float
    var volume: Float
    static var shared: RecitingSettings?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(interval, forKey: SerializedKey.interval)
        aCoder.encode(kamiSimoInterval, forKey: SerializedKey.kamiShimoInterval)
        aCoder.encode(volume, forKey: SerializedKey.volume)
    }
    //    init(interval: Float, kamiShimoInterval: Float, volume: Float) {
    //        self.interval = interval
    //        self.kamiSimoInterval = kamiShimoInterval
    //        self.volume = volume
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        //        RecitingSettings.shared = nil
        let loadedInterval = aDecoder.decodeObject(forKey: SerializedKey.interval) as! NSNumber
        self.interval         = Float(truncating: loadedInterval)
        let loadedKSInterval = aDecoder.decodeObject(forKey: SerializedKey.kamiShimoInterval) as! NSNumber
        self.kamiSimoInterval = Float(truncating: loadedKSInterval)
        //        print("+++ kamiShimoInterval => \(kamiSimoInterval)")
        let loadedVolume = aDecoder.decodeObject(forKey: SerializedKey.volume) as! NSNumber
        self.volume = Float(truncating: loadedVolume)
        //        RecitingSettings.shared = RecitingSettings(interval: interval, kamiShimoInterval: kamiSimoInterval, volume: volume)
    }
    
    static func salvageDataFromUserDefaults() -> RecitingSettings? {
        if let rsData = UserDefaults.standard.object(forKey: "reciting_settings"),
            let settings = NSKeyedUnarchiver.unarchiveObject(with: rsData as! Data){
            return settings as? RecitingSettings
        }
        return nil
    }
}
