//
//  ReciteSettingsCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/02.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class ReciteSettingsCoordinator: Coordinator, SaveSettings {
  internal var settings: Settings
  internal var store: StoreManager
  private var fromScreen: UIViewController
  internal var screen: UIViewController?
  var childCoordinator: Coordinator?

  // Coordinatorプロトコル準拠のために必要だが、このCoordinatorでは使用しない
  var navigationController: UINavigationController

  init(settings: Settings,
       fromScreen: UIViewController,
       store: StoreManager) {
    self.settings = settings
    self.fromScreen = fromScreen
    self.store = store
    // ダミーのnavigationController（使用しない）
    self.navigationController = UINavigationController()
  }
  
  @MainActor
  func start() {
    // ViewModelの初期化
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    // dismissアクションを設定
    viewModel.dismissAction = { [weak self] in
      self?.screen?.dismiss(animated: true)
    }

    // SwiftUIビューの生成
    let reciteSettingsView = ReciteSettingsView(viewModel: viewModel)

    // ActionAttachedHostingControllerでラップ
    let hostController = ActionAttachedHostingController(rootView: reciteSettingsView)

    // modalPresentationStyleを設定
    hostController.modalPresentationStyle = .automatic

    // UIHostingControllerを直接モーダル表示
    fromScreen.present(hostController, animated: true)
    self.screen = hostController
  }
}
