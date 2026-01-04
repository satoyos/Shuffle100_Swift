//
//  HelpListCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

final class HelpListCoordinator: @MainActor Coordinator, HandleNavigator {
  var screen: UIViewController?
  var navigationController: UINavigationController
  var childCoordinator: Coordinator?

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  @MainActor
  func start() {
    // ViewModelの初期化
    let viewModel = HelpList.ViewModel()

    // SwiftUIビューの生成
    let helpListView = HelpListView(viewModel: viewModel)

    // ActionAttachedHostingControllerでラップ
    let hostController = ActionAttachedHostingController(rootView: helpListView)

    // ナビゲーション設定
    hostController.navigationItem.title = "ヘルプ"
    hostController.navigationItem.prompt = navigationItemPrompt

    // pushViewController
    navigationController.pushViewController(hostController, animated: true)
    self.screen = hostController
  }
}
