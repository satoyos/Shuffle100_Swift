//
//  DurationSettingViewModel+Fixtures.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/03.
//  Copyright © 2025 里 佳史. All rights reserved.
//

@testable import Shuffle100

extension DurationSettingViewModel {
    static func fixture(
        durationType: DurationSettingType = .twoPoems,
        startTime: Double = 1.0,
        singer: Singer = Singers.defaultSinger
    ) -> DurationSettingViewModel {
        .init(durationType: durationType, startTime: startTime)
    }
}
