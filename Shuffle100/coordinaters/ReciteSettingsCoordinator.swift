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
    private var fromScreen: UIViewController
    private var screen: UIViewController?
    
    init(settings: Settings, fromScreen: UIViewController) {
        self.settings = settings
        self.fromScreen = fromScreen
    }
    
    func start() {
        print("歯車ボタンが押された！")
        let screen = ReciteSettingsViewController()
        let navigator = UINavigationController(rootViewController: screen)
        setUpNavigationController(navigator)
        fromScreen.present(navigator, animated: true)
    }
    
    private func setUpNavigationController(_ navigator: UINavigationController) {
        navigator.interactivePopGestureRecognizer?.isEnabled = false
        navigator.navigationBar.barTintColor = StandardColor.barTintColor
    }
}
