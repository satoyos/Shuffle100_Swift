//
//  SelectSingerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class SelectSingerCoordinator: Coordinator, SaveSettings {
       internal var settings: Settings?
    internal var store: StoreManager?
    private let navigator: UINavigationController
    var screen: UIViewController?
    var childCoordinators = [Coordinator]()

    init(navigator: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }

    func start() {
        guard let settings = settings else { return }
        let screen = SelectSingerViewController(settings: settings)
        setSaveSettingsActionTo(screen: screen, settings: settings)
        navigator.pushViewController(screen, animated: true)
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
