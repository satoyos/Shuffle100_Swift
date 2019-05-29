//
//  LegacyDataConverter.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/29.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct  LegacyDataConverter {
    static func convertSelectedStatus100(_ legacyStatus100: SelectedStatus100) -> SelectedState100 {
        let bool100 = Bool100(bools: legacyStatus100.status)
        return SelectedState100(bool100: bool100)
    }
}
