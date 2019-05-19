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

    init() {
        tryLoadingLegacyData()
    }
    
    func start() {
        let settings = Settings()
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
    
    private func tryLoadingLegacyData() {
        if let loadedSettings = RecitingSettings.salvageDataFromUserDefaults() {
            print("---- interval -> \(loadedSettings.interval)")
            print("---- kamiShimo -> \(loadedSettings.kamiSimoInterval)")
            print("---- volume   -> \(loadedSettings.volume)")
        }
        
        if let gameSettings = GameSettings.salvageDataFromUserDefaults() {
            print("++++ fake_flg -> \(gameSettings.fake_flg)")
            print("++++ selectedNum -> \(gameSettings.statuses_for_deck[0].selectedNum)")
            print("++++ fuda_sets -> \(gameSettings.fuda_sets.map{$0.name}) ++++")
            print("++++ fuda_sets_selectedNum -> \(gameSettings.fuda_sets.map{$0.status100.selectedNum}) ++++")
        }
    }
}
