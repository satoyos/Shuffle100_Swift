//
//  LegacyDataConverter.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/29.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct  LegacyDataConverter {
    static func state100FromGameSettings(_ gameSettings: GameSettings) -> SelectedState100 {
        let loadedStatus100 = gameSettings.statuses_for_deck[0]
        return state100FromSelectedStatus100(loadedStatus100)
    }
    
    static func state100FromSelectedStatus100(_ selectedStatus100: SelectedStatus100) -> SelectedState100 {
        let bool100 = Bool100(bools: selectedStatus100.status)
        return SelectedState100(bool100: bool100)
    }
    
    static func convertRecitingSettings(_ recitingSettings: RecitingSettings) -> RecitingConfig {
        return RecitingConfig(
            volume: recitingSettings.volume,
            interval: recitingSettings.interval,
            kamiShimoInterval: recitingSettings.kamiShimoInterval)
    }
    
    static func savedFudaSetsFromGameSettings(_ gameSettings: GameSettings) -> [SavedFudaSet] {
        return gameSettings.fuda_sets.map{savedFudaSetFromFudaSet($0)}
    }
    
    static func savedFudaSetFromFudaSet(_ fudaSet: FudaSet) -> SavedFudaSet {
        let name = fudaSet.name
        let state100 = state100FromSelectedStatus100(fudaSet.status100)
        return SavedFudaSet(name: name, state100: state100)
    }
}
