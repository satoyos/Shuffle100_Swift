//
//  SelectModeCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/07.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

fileprivate let reciteModes = [
  ReciteModeHolder(mode: .normal,
                   title: "通常 (競技かるた)"),
  ReciteModeHolder(mode: .beginner,
                   title: "初心者 (チラし取り)"),
  ReciteModeHolder(mode: .nonstop,
                   title: "ノンストップ (止まらない)"),
  ReciteModeHolder(mode: .hokkaido,
                   title: "下の句かるた (北海道式)")
]

final class SelectModeCoordinator: Coordinator, SaveSettings, HandleNavigator {
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
    let viewModel = SelectModeView.ViewModel(
      settings: settings,
      reciteModeHolders: reciteModes
    )
    let view = SelectModeView(viewModel: viewModel)

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
