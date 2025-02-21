//
//  FudaSetsCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/28.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class FudaSetsCoordinator: Coordinator, SaveSettings, HandleNavigator {
  internal var settings: Settings
  internal var store: StoreManager
  var screen: UIViewController?
  var navigationController: UINavigationController
  var childCoordinator: Coordinator?
  
  init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
    self.navigationController = navigationController
    self.settings = settings
    self.store = store
  }
  
  func start() {
    let screen = FudaSetsScreen(settings: settings)
    screen.saveSettingsAction = { [store, settings, weak self] in
      self?.saveSettingsPermanently(settings, into: store)
    }
    navigationController.pushViewController(screen, animated: true)
    screen.navigationItem.prompt = navigationItemPrompt
    self.screen = screen
  }
}
