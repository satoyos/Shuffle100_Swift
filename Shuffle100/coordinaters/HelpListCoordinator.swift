//
//  HelpListCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

final class HelpListCoordinator: @MainActor Coordinator {
  var screen: UIViewController?
  var childCoordinator: Coordinator?
  private var fromScreen: UIViewController

  // Coordinatorプロトコル準拠のために必要だが、このCoordinatorでは使用しない
  var navigationController: UINavigationController

  init(fromScreen: UIViewController) {
    self.fromScreen = fromScreen
    // ダミーのnavigationController（使用しない）
    self.navigationController = UINavigationController()
  }

  @MainActor
  func start() {
    // ViewModelの初期化
    let viewModel = HelpList.ViewModel()

    // dismissアクションを設定
    viewModel.dismissAction = { [weak self] in
      self?.screen?.dismiss(animated: true)
    }

    // SwiftUIビューの生成
    let helpListView = HelpListView(viewModel: viewModel)

    // ActionAttachedHostingControllerでラップ
    let hostController = ActionAttachedHostingController(rootView: helpListView)

    // modalPresentationStyleを設定
    hostController.modalPresentationStyle = .automatic

    // UIHostingControllerを直接モーダル表示
    fromScreen.present(hostController, animated: true)
    self.screen = hostController
  }
}
