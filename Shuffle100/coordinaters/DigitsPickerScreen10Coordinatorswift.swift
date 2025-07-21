//
//  DigitsPickerScreen10Coordinatorswift.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/23.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

final class DigitsPickerScreen10Coordinator: Coordinator, SaveSettings, HandleNavigator {
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
    let digitsPickerView = DigitsPicker<Digits10>(settings: settings)
    let hostController = ActionAttachedHostingController(rootView: digitsPickerView)
    hostController.navigationItem.prompt = navigationItemPrompt
    hostController.navigationItem.title = Digits10.description
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
