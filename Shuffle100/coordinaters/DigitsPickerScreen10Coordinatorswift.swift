//
//  DigitsPickerScreen10Coordinatorswift.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/23.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

final class DigitsPickerScreen10Coordinator: Coordinator, HandleNavigator {
  var screen: UIViewController?
  private var settings: Settings
  private var store: StoreManager
  var navigationController: UINavigationController
  var childCoordinator: Coordinator?
  
  init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
    self.navigationController = navigationController
    self.settings = settings
    self.store = store
  }
  
  func start() {
    let screen = DigitsPickerScreen10(settings: settings)
    navigationController.pushViewController(screen, animated: true)
    screen.navigationItem.prompt = navigationItemPrompt
    self.screen = screen
  }
}
