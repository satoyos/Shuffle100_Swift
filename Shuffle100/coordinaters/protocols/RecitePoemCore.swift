//
//  RecitePoemCore.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/12/07.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

/// 歌の読み上げに関する基礎機能を提供するプロトコル
protocol RecitePoemCore: BackToHome, RecitePoemViewModelHolder, Coordinator {
  var screen: UIViewController? { get set }
  var settings: Settings { get set }
  var store: StoreManager { get set }
  var poemSupplier: PoemSupplier { get set }
  var childCoordinator: Coordinator? { get set }

  func startPostMortem() -> Void
  func start() -> Void
}

extension RecitePoemCore {

  func startPostMortem() {
    print("!! Coordinatorから感想戦を始めますよ！!")
    poemSupplier.resetCurrentIndex()
    self.start()
  }

  // 歯車ボタンが押されたときの画面遷移をここでやる！
  @MainActor
  internal func openReciteSettings() {
    if let hostController = self.screen {
      // Both SwiftUI and UIKit use the same coordinator
      let coordinator = ReciteSettingsCoordinator(
        settings: settings,
        fromScreen: hostController,
        store: store)
      coordinator.start()
      self.childCoordinator = coordinator
    }
  }
}
