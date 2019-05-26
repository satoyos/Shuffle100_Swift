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
        let gameConfig = tryLoadLegacyGameSettings()
        let recitingConfig = tryLoadLegacyRecitingSettings()
        let settings = Settings(mode: gameConfig, recitingConfig: recitingConfig)
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

    private func tryLoadLegacyRecitingSettings() -> RecitingConfig {
        if let loadedSettings = RecitingSettings.salvageDataFromUserDefaults() {
            let recitingConfig = RecitingConfig(
                volume: loadedSettings.volume,
                interval: loadedSettings.interval,
                kamiShimoInterval: loadedSettings.kamiSimoInterval
            )
            print("+++ Success loading Legacy Data")
            recitingConfig.debugPrint()
            return recitingConfig
        } else {
            return RecitingConfig()
        }
    }
    
    private func tryLoadLegacyGameSettings() -> GameConfig {
        if let gameSettings = GameSettings.salvageDataFromUserDefaults() {

            // ToDo: 以下のデバッグ出力も GameConfigの処理として切り出そう
            
            print("++++ fake_flg -> \(gameSettings.fake_flg)")
            print("++++ selectedNum -> \(gameSettings.statuses_for_deck[0].selectedNum)")
            print("++++ fuda_sets -> \(gameSettings.fuda_sets.map{$0.name}) ++++")
            print("++++ fuda_sets_selectedNum -> \(gameSettings.fuda_sets.map{$0.status100.selectedNum}) ++++")
            let gameConfig = GameConfig(reciteMode: ReciteMode.normal, fakeMode: gameSettings.fake_flg)
            return gameConfig
        } else {
            print("--- Couldn't find Legacy Data for GameSettings ---")
            return GameConfig()
        }
    }
}
