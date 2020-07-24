//
//  VolumeSettingCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/19.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class VolumeSettingCoordinator: Coordinator, SaveSettings {
    internal var settings: Settings?
    internal var store: StoreManager?
    var screen: UIViewController?
    var navigator: UINavigationController
    
    init(navigator: UINavigationController, settings: Settings, store: StoreManager = StoreManager()) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }
    
    func start() {
        guard let settings = settings else { return }
        guard let store = store else { return }
        let screen = VolumeSettingViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
        navigator.pushViewController(screen, animated: true)
    }
}
