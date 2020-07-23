//
//  MainCoordinatorSetUpSettings.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

extension MainCoordinator {
    internal func setUpSettings() -> Settings {
        let defaultSettings = Settings()
        guard let store = self.store else { return defaultSettings}

        if let loadedSettings = store.load(key: Settings.userDefaultKey) as Settings? {
            if env.ignoreSavedData() {
                return defaultSettings
            } else {
                return loadedSettings
            }
        } else {
            if let gameSettings = tryLoadLegacyGameSettings() {
                if !env.ignoreSavedData() {
                    initSettings(defaultSettings, with: gameSettings)
                }
            }
            if let recitingSettings = tryLoadLegacyRecitingSettings() {
                if !env.ignoreSavedData() {
                    initSettings(defaultSettings, with: recitingSettings)
                }
            }
            saveSettingsPermanently(defaultSettings, into: store)
//            do {
//                try store.save(value: defaultSettings, key: Settings.userDefaultKey)
//            } catch {
//                assertionFailure("SttingsデータのUserDefautへの保存に失敗しました。")
//            }
        
            return defaultSettings
        }
    }
    
    private func tryLoadLegacyRecitingSettings() -> RecitingSettings? {
        if let loadedSettings = RecitingSettings.salvageDataFromUserDefaults() {
//            print("+++ Success loading Legacy Data")
//            loadedSettings.debugPrint()
            RecitingSettings.deleteLegacySavedData()
            return loadedSettings
        } else {
            return nil
        }
    }
    
    private func tryLoadLegacyGameSettings() -> GameSettings? {
        if let gameSettings = GameSettings.salvageDataFromUserDefaults() {
//            print("+++ Success loading legacy GameSettings")
//            gameSettings.debugPrint()
            GameSettings.deleteLegacySavedData()
            return gameSettings
        } else {
            return nil
        }
    }
    
    private func initSettings(_ settings: Settings, with gameSettings: GameSettings) {
        settings.fakeMode = gameSettings.fake_flg
        settings.reciteMode = .normal // still fail loading legacy saved symbol data
        settings.state100 = LegacyDataConverter.state100FromGameSettings(gameSettings)
        settings.savedFudaSets = LegacyDataConverter.savedFudaSetsFromGameSettings(gameSettings)
    }
    
    private func initSettings(_ settings: Settings, with recitingSettings: RecitingSettings) {
        settings.recitingConfig = LegacyDataConverter.convertRecitingSettings(recitingSettings)
    }
}
