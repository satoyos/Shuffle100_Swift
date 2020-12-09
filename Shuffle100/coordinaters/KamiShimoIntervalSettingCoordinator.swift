//
//  KamiShimoIntervalSettingCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/17.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class KamiShimoIntervalSettingCoordinator: Coordinator, SaveSettings {
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
//        guard let settings = settings else { return }
//        guard let store = store else { return }
        let screen = KamiShimoIntervalSettingViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
        navigationController.pushViewController(screen, animated: true)
        self.screen = screen
    }


}
