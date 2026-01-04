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
  var navigationController: UINavigationController
  private var fromScreen: UIViewController
  internal var screen: UIViewController?
  var childCoordinator: Coordinator?
  
  init(settings: Settings,
       fromScreen: UIViewController,
       store: StoreManager,
       navigationController: UINavigationController) {
    self.settings = settings
    self.fromScreen = fromScreen
    self.store = store
    self.navigationController = navigationController
  }
  
  @MainActor
  func start() {
    // ViewModelの初期化
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    // SwiftUIビューの生成
    let reciteSettingsView = ReciteSettingsView(viewModel: viewModel)

    // ActionAttachedHostingControllerでラップ
    let hostController = ActionAttachedHostingController(rootView: reciteSettingsView)

    // ナビゲーション設定
    hostController.navigationItem.title = "いろいろな設定"

    // 閉じるボタン設定
    hostController.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "設定終了",
      style: .plain,
      target: self,
      action: #selector(dismissButtonTapped)
    )

    // モーダル表示用のUINavigationController
    self.navigationController = UINavigationController(rootViewController: hostController)
    setUpNavigationController()

    fromScreen.present(navigationController, animated: true)
    self.screen = hostController
  }

  @objc private func dismissButtonTapped() {
    // Settingsは既にViewModelで保存済みなので、dismissだけ
    navigationController.dismiss(animated: true)
  }
  
  private func setUpNavigationController() {
    navigationController.interactivePopGestureRecognizer?.isEnabled = false
    navigationController.navigationBar.barTintColor = StandardColor.barTintColor

    // modalPresentationStyleは、UIKit時代は.fullScreenにせざるを得なかったが、
    // Swift UI化してから、その制約がなくなった。
    navigationController.modalPresentationStyle = .automatic
  }
}
