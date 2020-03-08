//
//  ReciteSettingsCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/02.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class ReciteSettingsCoordinator: Coordinator {
    private var settings: Settings
    private var store: StoreManager
    private var navigator: UINavigationController!
    private var fromScreen: UIViewController
    private var screen: UIViewController?

    init(settings: Settings, fromScreen: UIViewController, store: StoreManager = StoreManager()) {
        self.settings = settings
        self.fromScreen = fromScreen
        self.store = store
    }
    
    func start() {
        print("歯車ボタンが押された！")
        let screen = ReciteSettingsViewController(settings: settings)
        self.navigator = UINavigationController(rootViewController: screen)
        setUpNavigationController()
        screen.intervalSettingAction = { [weak self] in
            self?.openIntervalSettingScreen()
        }
        fromScreen.present(navigator, animated: true)
        self.screen = screen
    }
    
    private func setUpNavigationController() {
        navigator.interactivePopGestureRecognizer?.isEnabled = false
        navigator.navigationBar.barTintColor = StandardColor.barTintColor
    }
    
    private func openIntervalSettingScreen() {
        print("これから、歌の間隔を調整する画面を開きます")
        let coordinator = IntervalSettingCoordinator(navigator: navigator, settings: settings)
        coordinator.start()        
    }
}
