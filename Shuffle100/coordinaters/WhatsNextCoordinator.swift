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
    let whatsNextView = WhatsNextView(currentPoem: currentPoem)
    whatsNextView.setActions(
      showTorifuda: { [weak self] in
        self?.showTorifuda()
      },
      refrain: { [weak self] in
        self?.anotherNavController.dismiss(animated: true)
        self?.refrainShimo()
      },
      goNext: { [weak self] in
        self?.anotherNavController.dismiss(animated: true)
        self?.goNextPoem()
      },
      goSetting: { [weak self] in
        self?.openSettingScreen()
      },
      backToHome: { [weak self] in
        self?.anotherNavController.dismiss(animated: true)
        self?.backToHomeScreen()
      }
    )

    let hostController = ActionAttachedHostingController(
      rootView: whatsNextView
        .environmentObject(ScreenSizeStore())
    )

    self.anotherNavController = UINavigationController(rootViewController: hostController)
    setUpNavigationController()

    fromScreen.present(anotherNavController, animated: true)
    self.screen = hostController
  }
  
  private func setUpNavigationController() {
    anotherNavController.interactivePopGestureRecognizer?.isEnabled = false
    anotherNavController.navigationBar.barTintColor = StandardColor.barTintColor
    anotherNavController.modalPresentationStyle = .fullScreen
  }
  
  private func showTorifuda() {
    // 既存のchildCoordinatorをクリアしてから新しいものを作成
    childCoordinator = nil

    let coordinator = TorifudaCoordinator(
      navigationController: anotherNavController,

      poem: currentPoem,
      showPrompt: false
    )
    coordinator.start()
    self.childCoordinator = coordinator
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
    let newNavController = UINavigationController()
    let coordinator = ReciteSettingsCoordinator(
      settings: settings,
      fromScreen: screen,
      store: store,
      navigationController: newNavController)
    coordinator.start()
    self.childCoordinator = coordinator
  }
}
