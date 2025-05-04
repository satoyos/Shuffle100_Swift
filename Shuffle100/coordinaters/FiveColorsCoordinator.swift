//
//  FiveColorsCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/10/04.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class FiveColorsCoordinator: Coordinator, SaveSettings, HandleNavigator {
  
  internal var settings: Settings
  internal var store: StoreManager
  var navigationController: UINavigationController
  internal var screen: UIViewController?
  var childCoordinator: Coordinator?
  
  init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
    self.navigationController = navigationController
    self.settings = settings
    self.store = store
  }
  
  func start() {
    let fiveColorsView = FiveColorsView(settings: settings)
    let hostController = ActionAttachedHostingController(
      rootView: fiveColorsView
        .environmentObject(ScreenSizeStore()))
    hostController.navigationItem.prompt = navigationItemPrompt
    hostController.navigationItem.title = "五色百人一首"
    hostController.actionForViewWillDissappear = { [fiveColorsView, weak self] in
      fiveColorsView.tasksForLeavingThisVIew()
      if let settings = self?.settings, let store = self?.store {
        self?.saveSettingsPermanently(settings, into: store)
      }
    }
    navigationController.pushViewController(hostController, animated: true)
    self.screen = hostController
  }
}
