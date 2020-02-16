//
//  PoemPickerCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/04.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class PoemPickerCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var settings: Settings
    private var screen: UIViewController?
    private var store: StoreManager
    
    init(navigator: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }
    
    func start() {
        let screen = PoemPickerViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            print("<Save> 選んだ歌のデータをセーブするよ！")
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
