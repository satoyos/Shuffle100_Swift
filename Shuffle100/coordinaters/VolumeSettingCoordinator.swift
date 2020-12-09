//
//  VolumeSettingCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/19.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class VolumeSettingCoordinator: Coordinator, SaveSettings {
    internal var settings: Settings
    internal var store: StoreManager
    var screen: UIViewController?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
    }

    func start() {
        let screen = VolumeSettingViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
        navigationController.pushViewController(screen, animated: true)
    }
}
