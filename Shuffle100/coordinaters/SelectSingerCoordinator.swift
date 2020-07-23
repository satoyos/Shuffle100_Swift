//
//  SelectSingerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class SelectSingerCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var settings: Settings
    private var store: StoreManager
    var screen: UIViewController?
        
    init(navigator: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }
        
    func start() {
        let screen = SelectSingerViewController(settings: settings)
        setSaveSettingsActionTo(screen: screen, settings: settings)
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
    
    private func setSaveSettingsActionTo(screen: SelectSingerViewController, settings: Settings ) {
        screen.saveSettingsAction = { [store, settings] in
            do {
                try store.save(value: settings, key: Settings.userDefaultKey)
            } catch {
                assertionFailure("SettingsデータのUserDefautへの保存に失敗しました。")
            }
        }
    }

}
