//
//  FudaSetsCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/28.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class FudaSetsCoordinator: Coordinator {
    var screen: UIViewController?
    private var settings: Settings
    private var store: StoreManager
    private var navigator: UINavigationController

    init(navigator: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }
    
    func start() {
        let screen = FudaSetsViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            assert(true, "<Save> 選んだ歌のデータをセーブするよ！")
            do {
                try store.save(value: settings, key: Settings.userDefaultKey)
            } catch {
                assertionFailure("SttingsデータのUserDefautへの保存に失敗しました。")
            }
        }
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
    
}
