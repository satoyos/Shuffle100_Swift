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
    let fudaSetsView = FudaSetsView(settings: settings)
    let hostController = ActionAttachedHostingController(
      rootView: fudaSetsView
        .environmentObject(ScreenSizeStore()))
    hostController.navigationItem.prompt = navigationItemPrompt
    hostController.navigationItem.title = "作った札セットから選ぶ"
    hostController.actionForViewWillDissappear = { [fudaSetsView, weak self] in
      fudaSetsView.tasksForLeavingThisView()
      if let settings = self?.settings, let store = self?.store {
        self?.saveSettingsPermanently(settings, into: store)
      }
    }
    navigationController.pushViewController(hostController, animated: true)
    self.screen = hostController
  }
}
