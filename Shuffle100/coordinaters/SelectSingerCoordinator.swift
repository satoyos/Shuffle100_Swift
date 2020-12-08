//
//  SelectSingerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class SelectSingerCoordinator: Coordinator, SaveSettings, HandleNavigator {
    internal var settings: Settings?
    internal var store: StoreManager?
    var navigationController: UINavigationController
    var screen: UIViewController?
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
    }

    func start() {
        guard let settings = settings else { return }
        let screen = SelectSingerViewController(settings: settings)
        setSaveSettingsActionTo(screen: screen, settings: settings)
        navigationController.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }

    private func setSaveSettingsActionTo(screen: SelectSingerViewController, settings: Settings ) {
        guard let store = store else { return }
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
    }
}
