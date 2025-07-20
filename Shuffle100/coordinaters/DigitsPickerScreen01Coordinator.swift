//
//  DigitsPickerScreen01Coordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/04.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

final class DigitsPickerScreen01Coordinator: Coordinator, SaveSettings, HandleNavigator {
  var screen: UIViewController?
  var settings: Settings
  var store: StoreManager
  var navigationController: UINavigationController
  var childCoordinator: Coordinator?
  
  init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
    self.navigationController = navigationController
    self.settings = settings
    self.store = store
  }
  
  func start() {
    let digitsPickerView = DigitsPicker<Digits01>(settings: settings)
    let hostController = ActionAttachedHostingController(rootView: digitsPickerView)
//      .environmentObject(ScreenSizeStore.shared)
    hostController.navigationItem.prompt = navigationItemPrompt
    hostController.navigationItem.title = Digits01.description
    hostController.actionForViewWillDissappear = {
      [digitsPickerView, weak self] in
      digitsPickerView.tasksForLeavingThisView()
      if let settings = self?.settings,
         let store = self?.store {
        self?.saveSettingsPermanently(settings, into: store)
      }
    }
    navigationController.pushViewController(hostController, animated: true)
    self.screen = hostController
  }
}
