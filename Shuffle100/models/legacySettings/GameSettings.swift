//
//  GameSettings.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/12.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct SerializedKey {
    static let statuses_for_deck = "statuses_for_deck"
    static let fake_flg          = "fake_flg"
    static let beginner_flg      = "beginner_flg"
    static let singer_index      = "singer_index"
    static let recite_mode_id    = "recite_mode_id"
    static let fuda_sets         = "fuda_sets"
}

fileprivate struct DefaultValue {
    static let statuses_for_deck = [SelectedStatus100()]
    static let fake_flg          = false
    static let beginner_flg      = false
    static let singer_index      = 0
    static let recite_mode_id    = "normal"
//    static let fuda_sets         = []
}

@objc (GameSettings)
class GameSettings: NSObject, NSCoding {
    var statuses_for_deck: [SelectedStatus100]
    var fake_flg: Bool
    var beginner_flg: Bool
    var singer_index: Int
    var recite_mode_id: String
//    var fuda_sets:
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(statuses_for_deck, forKey: SerializedKey.statuses_for_deck)
        aCoder.encode(fake_flg, forKey: SerializedKey.fake_flg)
        aCoder.encode(beginner_flg, forKey: SerializedKey.beginner_flg)
        aCoder.encode(singer_index, forKey: SerializedKey.singer_index)
        aCoder.encode(recite_mode_id, forKey: SerializedKey.recite_mode_id)
//        aCoder.encode(fuda_sets, forKey: SerializedKey.fuda_sets)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.statuses_for_deck = aDecoder.decodeObject(forKey: SerializedKey.statuses_for_deck) as! [SelectedStatus100]
        self.fake_flg = aDecoder.decodeObject(forKey: SerializedKey.fake_flg) as! Bool
        self.beginner_flg = aDecoder.decodeObject(forKey: SerializedKey.beginner_flg) as! Bool
        self.singer_index = aDecoder.decodeObject(forKey: SerializedKey.singer_index) as! Int
        self.recite_mode_id = aDecoder.decodeObject(forKey: SerializedKey.recite_mode_id) as! String
    }
    
    static func salvageDataFromUserDefaults() -> GameSettings? {
        if let rsData = UserDefaults.standard.object(forKey: "game_settings"),
            let settings = NSKeyedUnarchiver.unarchiveObject(with: rsData as! Data) {
            return settings as? GameSettings
        }
        return nil
    }
}
