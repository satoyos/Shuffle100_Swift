//
//  SelectSingerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

final class SelectSingerCoordinator: Coordinator, SaveSettings, HandleNavigator {
  internal var settings: Settings
  internal var store: StoreManager
  var navigationController: UINavigationController
  var screen: UIViewController?
  var childCoordinator: Coordinator?

  init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
    self.navigationController = navigationController
    self.settings = settings
    self.store = store
  }

  func start() {
    let viewModel = SelectSingerView.ViewModel(
      settings: settings,
      singers: Singers.all
    )
    let view = SelectSingerView(viewModel: viewModel)

    let hostController = ActionAttachedHostingController(
      rootView: view.environmentObject(ScreenSizeStore.shared)
    )

    // viewWillDisappearで設定を保存
    hostController.actionForViewWillDissappear = { [weak self] in
      guard let self = self else { return }
      self.saveSettingsPermanently(settings, into: store)
    }

    navigationController.pushViewController(hostController, animated: true)
    hostController.navigationItem.prompt = navigationItemPrompt
    self.screen = hostController
  }
}
