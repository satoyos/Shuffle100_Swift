//
//  MainCoordinatorSetUpSettings.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

extension MainCoordinator {
    static func setUpSettings(store: StoreManager) -> Settings {
        let defaultSettings = Settings()
        
        guard !env.ignoreSavedData() else { return defaultSettings }
        guard let loadedSettings =
                store.load(key: Settings.userDefaultKey) as Settings? else {
            return defaultSettings
        }
        
        loadedSettings.fixOptionalProperties()
        return loadedSettings
    }
}
