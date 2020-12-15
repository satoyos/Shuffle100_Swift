//
//  NgramPickerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class NgramPickerCoordinator: Coordinator, HandleNavigator {
    var screen: UIViewController?
    private var settings: Settings
    private var store: StoreManager
    var navigationController: UINavigationController
//    var childCoordinators = [Coordinator]()
    var childCoordinator: Coordinator?

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
    }

    func start() {
        let screen = NgramPickerViewController(settings: settings)
        navigationController.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }
}
