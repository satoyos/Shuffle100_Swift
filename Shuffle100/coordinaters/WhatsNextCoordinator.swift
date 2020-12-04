//
//  WhatsNextCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class WhatsNextCoordinator: Coordinator {
    internal var screen: UIViewController?
    private var fromScreen: UIViewController
    var navigationController: UINavigationController
    private var currentPoem: Poem!
    private var settings: Settings
    private var store: StoreManager
    internal var refrainEscalatingAction: (() -> Void)?
    internal var goNextPoemEscalatingAction: (() -> Void)?
    internal var exitGameEscalationgAction: (() -> Void)?
    var childCoordinators = [Coordinator]()

    init(fromScreen: UIViewController, currentPoem: Poem, settings: Settings, store: StoreManager, navigationController: UINavigationController = UINavigationController()) {
        self.fromScreen = fromScreen
        self.currentPoem = currentPoem
        self.settings = settings
        self.store = store
        self.navigationController = navigationController
    }

    func start() {
        let screen = WhatsNextViewController(currentPoem: currentPoem)
        self.navigationController = UINavigationController(rootViewController: screen)
        setUpNavigationController()
        screen.refrainAction = { [weak self] in
            self?.refrainShimo()
        }
        screen.goNextAction = { [weak self] in
            self?.goNextPoem()
        }
        screen.exitGameAction = { [weak self] in
            self?.exitGame()
        }
        screen.goSettingAction = { [weak self] in
            self?.openSettingScreen()
        }
        fromScreen.present(navigationController, animated: true)
        self.screen = screen
    }

    private func setUpNavigationController() {
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        navigationController.navigationBar.barTintColor = StandardColor.barTintColor
        navigationController.modalPresentationStyle = .fullScreen
    }

    internal func refrainShimo() {
        refrainEscalatingAction?()
    }

    internal func goNextPoem() {
        goNextPoemEscalatingAction?()
    }

    internal func exitGame() {
        exitGameEscalationgAction?()
    }

    internal func openSettingScreen() {
        guard let screen = self.screen else { return }
        let coordinator = ReciteSettingsCoordinator(settings: settings, fromScreen: screen, store: store)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
