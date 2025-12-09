//
//  WhatsNextSupport.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/12/07.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import UIKit

/// 「次はどうする?」画面を使用するモード（初心者モード、北海道モード）用のプロトコル
protocol WhatsNextSupport: RecitePoemViewModelHolder {
  var screen: UIViewController? { get set }
  var navigationController: UINavigationController { get }
  var settings: Settings { get set }
  var store: StoreManager { get set }
  var poemSupplier: PoemSupplier { get set }
  var whatsNextCoordinator: WhatsNextCoordinator? { get set }
  var childCoordinator: Coordinator? { get set }

  func backToHomeScreen()

  /// 「次はどうする?」画面を表示
  func openWhatsNextScreen()
  /// 下の句を読み返す
  func refrainShimo()
  /// 次の詩へ進む
  func goNextPoem()
  /// ゲームを終了
  func exitGame()
}

extension WhatsNextSupport where Self: Coordinator {

  func openWhatsNextScreen() {
    guard let screen = screen else { return }
    guard let currentPoem = poemSupplier.currentPoem else { return }
    let coordinator = WhatsNextCoordinator(
      fromScreen: screen,
      currentPoem: currentPoem,
      settings: settings,
      store: store,
      navigationController: navigationController)
    coordinator.refrainEscalatingAction = { [weak self] in
      self?.refrainShimo()
    }
    coordinator.goNextPoemEscalatingAction = { [weak self] in
      self?.goNextPoem()
    }
    coordinator.exitGameEscalationgAction = { [weak self] in
      self?.exitGame()
    }
    coordinator.start()
    self.whatsNextCoordinator = coordinator
    self.childCoordinator = coordinator
  }

  func refrainShimo() {
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex

    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      baseViewModel.refrainShimo(number: number, count: counter)
    } else {
      assertionFailure("Couldn't get baseViewModel")
    }
  }

  func exitGame() {
    backToHomeScreen()
  }
}
