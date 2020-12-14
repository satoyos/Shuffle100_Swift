//
//  SelectModeCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/07.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class SelectModeCoordinator: Coordinator, SaveSettings, HandleNavigator {
    internal var settings: Settings
    internal var store: StoreManager
    var  navigationController: UINavigationController
    var screen: UIViewController?
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
    }

    func start() {
        let screen = SelectModeViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings, weak self] in
            self?.saveSettingsPermanently(settings, into: store)
        }
        navigationController.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }
}
