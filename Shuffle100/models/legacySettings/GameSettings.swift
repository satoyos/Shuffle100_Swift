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
    static let fuda_sets         = [FudaSet]()
}

@objc (Symbol)
class Symbol: NSObject, NSCoding {
    var value: NSString = "初期値"
    
    func encode(with aCoder: NSCoder) {
        print("___inside ENCODE____")
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("___inside initWitDecoder____")
        if let decodedObject = aDecoder.decodeObject() {
            print("+++ decodeObjectは成功したよ！ \(decodedObject)+++")
        } else {
            print("---- decodeObjectに失敗してるよ！ ----")
        }
    }
    
}

@objc (GameSettings)
class GameSettings: NSObject, NSCoding {
    var statuses_for_deck: [SelectedStatus100]
    var fake_flg: Bool
    var beginner_flg: Bool
    var singer_index: Int
    var recite_mode_id: String
    var fuda_sets: [FudaSet]
    
    func encode(with aCoder: NSCoder) { }
    
    init(status100: SelectedStatus100 = SelectedStatus100(status: Bool100.allTrueBoolArray()), fake_flg: Bool = false, beginner_flg: Bool = false, singer_index: Int = 0, recite_mode_id: String = "デフォルト", fuda_sets: [FudaSet] = [FudaSet]()) {
        self.statuses_for_deck = [status100]
        self.fake_flg = fake_flg
        self.beginner_flg = beginner_flg
        self.singer_index = singer_index
        self.recite_mode_id = recite_mode_id
        self.fuda_sets = fuda_sets
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.statuses_for_deck = aDecoder.decodeObject(forKey: SerializedKey.statuses_for_deck) as! [SelectedStatus100]
        self.fake_flg = aDecoder.decodeBool(forKey: SerializedKey.fake_flg)
        self.beginner_flg = aDecoder.decodeBool(forKey: SerializedKey.beginner_flg)
        let loadedIndex = aDecoder.decodeInt32(forKey: SerializedKey.singer_index)
        self.singer_index = Int(loadedIndex)
        let loadedID = aDecoder.decodeObject(forKey: SerializedKey.recite_mode_id) as! Symbol
        self.recite_mode_id = loadedID.value as String
        self.fuda_sets = aDecoder.decodeObject(forKey: SerializedKey.fuda_sets) as! [FudaSet]
    }
    
    func debugPrint() {
        print("-----------")
        print("GameSettings:")
        print("   fake_flg:    \(fake_flg)")
        print("   reciteMode:  \(recite_mode_id)")
        print("   selectedNum: \(statuses_for_deck[0].selectedNum)")
        print("   fuda_sets:   \(fuda_sets.map{$0.name})")
        print("   fuda_sets_selectedNum:  \(fuda_sets.map{$0.status100.selectedNum})")
    }

    static func salvageDataFromUserDefaults() -> GameSettings? {
        if let rsData = UserDefaults.init(suiteName: "game_settings")?.object(forKey: "game_settings"),
            let settings = NSKeyedUnarchiver.unarchiveObject(with: rsData as! Data) {
            return settings as? GameSettings
        }
        return nil
    }
}
