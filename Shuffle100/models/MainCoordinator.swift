//
//  File.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/04/21.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator {
    var navigationController = UINavigationController()

    func start() {
        let settings = Settings()
        if let gameSettings = tryLoadLegacyGameSettings() {
            if !nowTesting() {
                initSettings(settings, with: gameSettings)
            }
        }
        if let recitingSettings = tryLoadLegacyRecitingSettings() {
            if !nowTesting() {
                initSettings(settings, with: recitingSettings)
            }
        }
        let homeScreen = HomeViewController(settings: settings)
        navigationController.pushViewController(homeScreen as UIViewController, animated: false)
        setUpNavigationController()
        
        homeScreen.selectPoemAction = {[weak self, unowned settings] in
            self?.selectPoem(settings: settings)
        }
        
        homeScreen.selectModeAction = {[weak self, unowned settings] in
            self?.selectMode(settings: settings)
        }
    }
    
    private func setUpNavigationController() {
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        navigationController.navigationBar.topItem?.prompt = "百首読み上げ"
        navigationController.navigationBar.barTintColor = UIColor(hex: "cee4ae")
    }
    
    private func selectPoem(settings: Settings) {
        navigationController.pushViewController(PoemPickerViewController(settings: settings), animated: true)
    }
    
    private func selectMode(settings: Settings) {
        navigationController.pushViewController(SelectModeViewController(settings: settings), animated: true)
    }

    private func tryLoadLegacyRecitingSettings() -> RecitingSettings? {
        if let loadedSettings = RecitingSettings.salvageDataFromUserDefaults() {
            print("+++ Success loading Legacy Data")
            loadedSettings.debugPrint()
            return loadedSettings
        } else {
            return nil
        }
    }
    
    private func tryLoadLegacyGameSettings() -> GameSettings? {
        if let gameSettings = GameSettings.salvageDataFromUserDefaults() {
            print("+++ Success loading legacy GameSettings")
            gameSettings.debugPrint()
            return gameSettings
        } else {
            return nil
        }
    }
    
    private func initSettings(_ settings: Settings, with gameSettings: GameSettings) {
        settings.fakeMode = gameSettings.fake_flg
        settings.reciteMode = .normal // still fail loading legacy saved symbol data
//        let loadedStatus100 = gameSettings.statuses_for_deck[0]
        settings.state100 = LegacyDataConverter.state100FromGameSettings(gameSettings)
    }
    
    private func initSettings(_ settings: Settings, with recitingSettings: RecitingSettings) {
        settings.recitingConfig = LegacyDataConverter.convertRecitingSettings(recitingSettings)
    }
    
    private func nowTesting() -> Bool {
        let testing = (ProcessInfo.processInfo.environment["IS_TESTING"] == "1")
        return testing
    }
}
