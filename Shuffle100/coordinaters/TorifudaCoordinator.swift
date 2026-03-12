//
//  TorifudaCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/11/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

final class TorifudaCoordinator: Coordinator, HandleNavigator {
  var screen: UIViewController?
  var navigationController: UINavigationController  // ダミー（プロトコル準拠用）
  private var fromScreen: UIViewController
  private var poem: Poem
  var childCoordinator: Coordinator?
  let showPrompt: Bool

  init(fromScreen: UIViewController, poem: Poem, showPrompt: Bool = true) {
    self.fromScreen = fromScreen
    self.poem = poem
    self.showPrompt = showPrompt
    self.navigationController = UINavigationController()  // ダミー
  }

  func start() {
    var title = "\(poem.number)."
    for partStr in poem.liner {
      title += " \(partStr)"
    }
    let torifudaView = TorifudaView(
      shimoStr: poem.in_hiragana.shimo,
      fullLiner: poem.liner
    )
    let hostController = UIHostingController(rootView: torifudaView)
    hostController.title = title
    if showPrompt {
      hostController.navigationItem.prompt = navigationItemPrompt
    }
    hostController.navigationItem.rightBarButtonItem = UIBarButtonItem(
      systemItem: .close,
      primaryAction: UIAction { [weak self] _ in
        self?.screen?.dismiss(animated: true)
      }
    )

    let navController = UINavigationController(rootViewController: hostController)
    navController.modalPresentationStyle = .automatic
    fromScreen.present(navController, animated: true)
    self.screen = navController
  }
}
