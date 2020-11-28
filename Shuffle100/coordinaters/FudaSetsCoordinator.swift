//
//  FudaSetsCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/28.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class FudaSetsCoordinator: Coordinator, SaveSettings {
    internal var settings: Settings?
    internal var store: StoreManager?
    var screen: UIViewController?
    private var navigator: UINavigationController
    var childCoordinators = [Coordinator]()

    init(navigator: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }

    func start() {
        guard let settings = settings else { return }
        guard let store = store else { return }
        let screen = FudaSetsViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
        navigator.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }
}
