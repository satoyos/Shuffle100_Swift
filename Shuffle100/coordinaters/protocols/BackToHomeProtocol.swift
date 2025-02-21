//
//  BackToHomeProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/02/22.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation

protocol BackToHome {
  func backToHomeScreen()
}

extension BackToHome where Self: Coordinator {
  func backToHomeScreen() {
    navigationController.popToRootViewController(animated: true)
  }
}

