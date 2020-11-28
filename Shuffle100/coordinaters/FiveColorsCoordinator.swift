//
//  FiveColorsCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/10/04.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class FiveColorsCoordinator: Coordinator, SaveSettings, HandleNavigator {

    internal var settings: Settings?
    internal var store: StoreManager?
    private let navigator: UINavigationController
    internal var screen: UIViewController?
    var childCoordinators = [Coordinator]()

    init(navigator: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }

    func start() {
        guard let settings = settings else { return }
        guard let store = store else { return }
        let screen = FiveColorsViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
        navigator.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }


}
