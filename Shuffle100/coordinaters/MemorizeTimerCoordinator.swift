//
//  MemorizeTimerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

final class MemorizeTimerCoordinator: Coordinator, HandleNavigator {
  var screen: UIViewController?
  var navigationController: UINavigationController
  var childCoordinator: Coordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    setUpNavigationController(navigationController)
    let memorizeTimerView = MemorizeTimer(viewModel: .init(
      totalSec: 15 * 60,
      completion: { [weak self] in
        self?.navigationController.popViewController(animated: true)
      }))
    let hostController = UIHostingController(rootView: memorizeTimerView)
    hostController.navigationItem.prompt = navigationItemPrompt
    hostController.title = "暗記時間タイマー"
    
    navigationController.pushViewController(hostController, animated: true)
  }
}

