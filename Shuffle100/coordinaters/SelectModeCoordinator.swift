//
//  SelectModeCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/07.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class SelectModeCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var settings: Settings
    private var store: StoreManager
    private var screen: UIViewController?
    
    init(navigator: UINavigationController, settings: Settings, store: StoreManager  = StoreManager()) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }
    
    func start() {
        let screen = SelectModeViewController(settings: settings)
        setSaveSettingsActionTo(screen: screen, settings: settings)
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
    
    private func setSaveSettingsActionTo(screen: SelectModeViewController, settings: Settings ) {
        screen.saveSettingsAction = { [store, settings] in
            do {
                try store.save(value: settings, key: Settings.userDefaultKey)
            } catch {
                assertionFailure("SettingsデータのUserDefautへの保存に失敗しました。")
            }
        }
    }
}
