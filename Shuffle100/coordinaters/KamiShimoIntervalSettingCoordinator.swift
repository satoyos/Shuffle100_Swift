//
//  KamiShimoIntervalSettingCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/17.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class KamiShimoIntervalSettingCoordinator: Coordinator {
    var screen: UIViewController?
    var settings: Settings
    var store: StoreManager
    var navigator: UINavigationController
    
    init(navigator: UINavigationController, settings: Settings, store: StoreManager = StoreManager()) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }
    
    func start() {
        let screen = KamiShimoIntervalSettingViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            print("<Save> データをセーブするよ！")
            do {
                try store.save(value: settings, key: Settings.userDefaultKey)
            } catch {
                assertionFailure("SettingsデータのUserDefautへの保存に失敗しました。")
            }
        }
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
    
    
}
