//
//  PoemPickerCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/04.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

final class PoemPickerCoordinator: Coordinator, SaveSettings, HandleNavigator {
  
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
    var poemPickerView = PoemPickerView(settings: settings)
    poemPickerView.openNgramPickerAction = { [weak self] in
      self?.openNgramPicker()
    }
    poemPickerView.openFudaSetsScreenAction = { [weak self] in
      self?.openFudaSetsScreen()
    }
    poemPickerView.openFiveColorsScreenAction = { [weak self] in
      self?.openFiveColorsScreen()
    }
    poemPickerView.openDigitsPicker01Action = { [weak self] in
      self?.openDigitsPickerScreen01()
    }
    poemPickerView.openDigitsPicker10Action = { [weak self] in
      self?.openDigitsPickerScreen10()
    }
    poemPickerView.showTorifudaAction = { [weak self] number in
      self?.showTorifudaScreenFor(number: number)
    }
    poemPickerView.saveSetAction = { [weak self] in
      self?.handleSaveSet()
    }
    
    let hostController = ActionAttachedHostingController(
      rootView: poemPickerView
        .environmentObject(ScreenSizeStore()))
    hostController.navigationItem.prompt = navigationItemPrompt
    hostController.navigationItem.title = "歌を選ぶ"
    hostController.actionForViewWillDissappear = { [poemPickerView, weak self] in
      poemPickerView.tasksForLeavingThisView()
      if let settings = self?.settings, let store = self?.store {
        self?.saveSettingsPermanently(settings, into: store)
      }
    }
    navigationController.pushViewController(hostController, animated: true)
    self.screen = hostController
  }
  
  internal func openNgramPicker() {
    clearSearchResult()
    let coordinator = NgramPickerCoordinator(navigationController: navigationController, settings: settings, store: store)
    coordinator.start()
    self.childCoordinator = coordinator
  }
  
  internal func openFudaSetsScreen() {
    clearSearchResult()
    let coordinator = FudaSetsCoordinator(navigationController: navigationController, settings: settings, store: store)
    coordinator.start()
    self.childCoordinator = coordinator
  }
  
  internal func openFiveColorsScreen() {
    clearSearchResult()
    let coordinator = FiveColorsCoordinator(navigationController: navigationController, settings: settings, store: store)
    coordinator.start()
    self.childCoordinator = coordinator
  }
  
  internal func openDigitsPickerScreen01() {
    clearSearchResult()
    let coordinator = DigitsPickerScreen01Coordinator(navigationController: navigationController, settings: settings, store: store)
    coordinator.start()
    self.childCoordinator = coordinator
  }
  
  internal func openDigitsPickerScreen10() {
    clearSearchResult()
    let coordinator = DigitsPickerScreen10Coordinator(navigationController: navigationController, settings: settings, store: store)
    coordinator.start()
    self.childCoordinator = coordinator
  }
  
  internal func showTorifudaScreenFor(number: Int) {
    let poem = PoemSupplier.originalPoems[number-1]
    let coordinator = TorifudaCoordinator(navigationController: navigationController, poem: poem)
    coordinator.start()
    self.childCoordinator = coordinator
  }
  
  private func clearSearchResult() {
    // SwiftUI版では検索結果のクリアは不要
    // （各Coordinatorから戻った時に自動的にリセットされる）
  }
  
  private func handleSaveSet() {
    guard settings.state100.selectedNum > 0 else {
      showAlertInhibited(title: "歌を選びましょう", message: "空の札セットは保存できません。")
      return
    }
    showActionSheetForSaving()
  }
  
  private func showAlertInhibited(title: String, message: String?) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let backAction = UIAlertAction(title: "戻る", style: .cancel, handler: nil)
    ac.addAction(backAction)
    screen?.present(ac, animated: true)
  }
  
  private func showActionSheetForSaving() {
    // UIKit版のPoemPickerScreenDelegate+FudaSetと同等の処理
    // 実装は省略（元のUIKit版のロジックを参照）
    // TODO: 札セット保存のアクションシート表示
  }
}
