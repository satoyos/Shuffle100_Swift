//
//  SelectModeCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/07.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class SelectModeCoordinator: Coordinator, SaveSettings {
    internal var settings: Settings?
    internal var store: StoreManager?
    var  navigationController: UINavigationController
    var screen: UIViewController?
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager  = StoreManager()) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
    }

    func start() {
        guard let settings = settings else { return }
        let screen = SelectModeViewController(settings: settings)
        setSaveSettingsActionTo(screen: screen, settings: settings)
        navigationController.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }

    private func setSaveSettingsActionTo(screen: SelectModeViewController, settings: Settings ) {
        guard let store = store else { return }
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
    }
}
