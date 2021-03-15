//
//  WhatsNextCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class WhatsNextCoordinator: Coordinator, BackToHome {
    internal var screen: UIViewController?
    private var fromScreen: UIViewController
    var navigationController: UINavigationController
    var anotherNavController: UINavigationController!
    private var currentPoem: Poem
    private var settings: Settings
    private var store: StoreManager
    internal var refrainEscalatingAction: (() -> Void)?
    internal var goNextPoemEscalatingAction: (() -> Void)?
    internal var exitGameEscalationgAction: (() -> Void)?
    var childCoordinator: Coordinator?

    init(fromScreen: UIViewController, currentPoem: Poem, settings: Settings, store: StoreManager, navigationController: UINavigationController) {
        self.fromScreen = fromScreen
        self.currentPoem = currentPoem
        self.settings = settings
        self.store = store
        self.navigationController = navigationController
    }

    func start() {
        let screen = WhatsNextScreen(currentPoem: currentPoem)
        self.anotherNavController = UINavigationController(rootViewController: screen)
        setUpNavigationController()
        screen.showTorifudaAction = { [weak self] in
            self?.showTorifuda()
        }
        screen.refrainAction = { [weak self] in
            self?.refrainShimo()
        }
        screen.goNextAction = { [weak self] in
            self?.goNextPoem()
        }
        screen.backToHomeScreenAction = { [weak self] in
            screen.dismiss(animated: true)
            self?.backToHomeScreen()
        }
        screen.goSettingAction = { [weak self] in
            self?.openSettingScreen()
        }
        screen.viewDidAppearAction = { [weak self] in
            self?.childCoordinator = nil
        }
        fromScreen.present(anotherNavController, animated: true)
        self.screen = screen
    }

    private func setUpNavigationController() {
        anotherNavController.interactivePopGestureRecognizer?.isEnabled = false
        anotherNavController.navigationBar.barTintColor = StandardColor.barTintColor
        anotherNavController.modalPresentationStyle = .fullScreen
    }
    
    private func showTorifuda() {
        let shimoStr = currentPoem.in_hiragana.shimo
        var title = "\(currentPoem.number)."
        for partStr in currentPoem.liner {
            title += " \(partStr)"
        }
        let torifudaScreen = TorifudaScreen(shimoString: shimoStr, title: title)
        anotherNavController.pushViewController(torifudaScreen, animated: true)
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
        self.childCoordinator = coordinator
    }
}
