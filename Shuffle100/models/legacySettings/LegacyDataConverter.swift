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
        let bool100 = Bool100(bools: loadedStatus100.status)
        return SelectedState100(bool100: bool100)
    }
    
    static func convertRecitingSettings(_ recitingSettings: RecitingSettings) -> RecitingConfig {
        return RecitingConfig(
            volume: recitingSettings.volume,
            interval: recitingSettings.interval,
            kamiShimoInterval: recitingSettings.kamiShimoInterval)
    }
}
