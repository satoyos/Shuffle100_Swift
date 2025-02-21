//
//  KamiShimoIntervalSettingCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/17.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class KamiShimoIntervalSettingCoordinator: Coordinator, SaveSettings {
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
    let durationSettingView = KamiShimoDurationSetting(settings: settings)
    let hostController = ActionAttachedHostingController(rootView: durationSettingView
      .environmentObject(ScreenSizeStore()))
    hostController.actionForViewWillDissappear = { [durationSettingView] in
      durationSettingView.tasksForLeavingThisView()
    }
    hostController.title = "上の句と下の句の間隔"
    navigationController.pushViewController(hostController, animated: true)
    self.screen = hostController
  }
}
