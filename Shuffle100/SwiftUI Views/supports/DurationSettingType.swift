//
//  DurationSettingType.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/03.
//  Copyright © 2025 里 佳史. All rights reserved.
//

enum DurationSettingType {
    case twoPoems
    case kamiShimo
}

extension DurationSettingType {
    var halfPoems: (DurationSettingAudioHandler.HalfPoem,
                    DurationSettingAudioHandler.HalfPoem) {
        switch self {
        case .twoPoems:
            return (.h001b, .h002a)
        case .kamiShimo:
            return (.h001a, .h001b)
        }
    }
}
