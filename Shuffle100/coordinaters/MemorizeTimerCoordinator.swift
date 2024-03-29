//
//  MemorizeTimerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class MemorizeTimerCoordinator: Coordinator, HandleNavigator {
    var screen: UIViewController?
    var navigationController: UINavigationController
    var childCoordinator: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let screen = MemorizeTimerScreen()
        setUpNavigationController(navigationController)
        navigationController.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt
        self.screen = screen
    }
}

