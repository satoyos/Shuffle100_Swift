//
//  NgramPickerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class NgramPickerCoordinator: Coordinator, SaveSettings, HandleNavigator {
  var screen: UIViewController?
  internal var settings: Settings
  internal var store: StoreManager
  var navigationController: UINavigationController
  var childCoordinator: Coordinator?
  
  init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
    self.navigationController = navigationController
    self.settings = settings
    self.store = store
  }
  
  func start() {   
    let ngramPickerView = NgramPickerView(settings: settings)
    let hostController = ActionAttachedHostingController(
      rootView: ngramPickerView
        .environmentObject(ScreenSizeStore.shared))
    hostController.navigationItem.prompt = navigationItemPrompt
    hostController.navigationItem.title = "1字目で選ぶ"
    hostController.actionForViewWillDissappear = { [ngramPickerView, weak self] in
      ngramPickerView.tasksForLeavingThisView()
      if let settings = self?.settings,
         let store = self?.store {
        self?.saveSettingsPermanently(settings, into: store)
      }
    }
    navigationController.pushViewController(hostController, animated: true)
    self.screen = hostController
  }
}
