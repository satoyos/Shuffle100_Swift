//
//  ReciteSettingsCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/02.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class ReciteSettingsCoordinator: Coordinator, SaveSettings {
  internal var settings: Settings
  internal var store: StoreManager
  var navigationController: UINavigationController
  private var fromScreen: UIViewController
  internal var screen: UIViewController?
  var childCoordinator: Coordinator?
  
  init(settings: Settings,
       fromScreen: UIViewController,
       store: StoreManager,
       navigationController: UINavigationController) {
    self.settings = settings
    self.fromScreen = fromScreen
    self.store = store
    self.navigationController = navigationController
  }
  
  func start() {
    let screen = ReciteSettingsScreen(settings: settings)
    self.navigationController = UINavigationController(rootViewController: screen)
    setUpNavigationController()
    screen.intervalSettingAction = { [weak self] in
      self?.openIntervalSettingScreen()
    }
    screen.kamiShimoIntervalSettingAction = { [weak self] in
      self?.openKamiShimoIntervalSettingScreen()
    }
    screen.volumeSettingAction = { [weak self] in
      self?.openVolumeSettingScreen()
    }
    screen.saveSettingsAction = { [store, settings, weak self] in
      self?.saveSettingsPermanently(settings, into: store)
    }
    fromScreen.present(navigationController, animated: true)
    self.screen = screen
  }
  
  private func setUpNavigationController() {
    navigationController.interactivePopGestureRecognizer?.isEnabled = false
    navigationController.navigationBar.barTintColor = StandardColor.barTintColor
    
    // modalPresentationStyleは、UIKit時代は.fullScreenにせざるを得なかったが、
    // Swift UI化してから、その制約がなくなった。
//    navigationController.modalPresentationStyle = .fullScreen
    navigationController.modalPresentationStyle = .automatic
  }
  
  private func openIntervalSettingScreen() {
    assert(true, "これから、歌の間隔を調整する画面を開きます")
    let coordinator = IntervalSettingCoordinator(navigationController: navigationController, settings: settings, store: store)
    coordinator.start()
    self.childCoordinator = coordinator
  }
  
  private func openKamiShimoIntervalSettingScreen() {
    assert(true, "これから、上の句と下の句の間隔を調整する画面を開きます")
    let coordinator = KamiShimoIntervalSettingCoordinator(navigationController: navigationController, settings: settings, store: store)
    coordinator.start()
    self.childCoordinator = coordinator
  }
  
  private func openVolumeSettingScreen() {
    assert(true, "これから、音量をちょうせうする画面を開きます")
    let coordinator = VolumeSettingCoordinator(navigationController: navigationController, settings: settings, store: store)
    coordinator.start()
    self.childCoordinator = coordinator
  }
}
