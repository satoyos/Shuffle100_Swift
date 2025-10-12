//
//  RecitePoemProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/01/28.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

protocol RecitePoemProtocol: BackToHome {
  var settings: Settings { get set }
  var store: StoreManager { get set }
  var poemSupplier: PoemSupplier { get set }

  func jokaFinished() -> Void
  func reciteKamiFinished(number: Int, counter: Int ) -> Void
  func reciteShimoFinished(number: Int, counter: Int) -> Void
  func goNextPoem() -> Void
  func startPostMortem() -> Void
  func addKamiScreenActionsForKamiEnding()

  // Helper methods for accessing the current RecitePoemBaseViewModel
  func getCurrentRecitePoemBaseViewModel() -> RecitePoemBaseViewModel?
  func setCurrentRecitePoemBaseViewModel(_ viewModel: RecitePoemBaseViewModel)
}

extension RecitePoemProtocol where Self: Coordinator {

  func start() {
    startWithSwiftUI()
  }

  private func startWithSwiftUI() {
    let baseViewModel = RecitePoemBaseViewModel(settings: settings)
    setCurrentRecitePoemBaseViewModel(baseViewModel)

    baseViewModel.recitePoemViewModel.backToPreviousAction = { [weak self] in
      self?.rewindToPrevious()
    }
    baseViewModel.recitePoemViewModel.openSettingsAction = { [weak self] in
      self?.openReciteSettings()
    }
    baseViewModel.recitePoemViewModel.backToHomeScreenAction = { [weak self] in
      self?.backToHomeScreen()
    }
    baseViewModel.recitePoemViewModel.startPostMortemAction = { [weak self] in
      self?.startPostMortem()
    }

    let recitePoemBaseView = RecitePoemBaseView(settings: settings, viewModel: baseViewModel)
    let hostController = ActionAttachedHostingController(
      rootView: recitePoemBaseView
        .environmentObject(ScreenSizeStore.shared)
    )

    // 序歌の読み上げは画面遷移が完了したタイミングで開始したいので、
    // CATransanctionを使って、遷移アニメーション完了コールバックを使う。
    CATransaction.begin()
    navigationController.pushViewController(hostController, animated: true)
    let shorten = settings.shortenJoka
    CATransaction.setCompletionBlock {
      baseViewModel.playerFinishedAction = { [weak self] in
        self?.jokaFinished()
      }
      baseViewModel.skipToNextScreenAction = { [weak self] in
        self?.jokaFinished()
      }
      hostController.loadViewIfNeeded()
      baseViewModel.initView(title: "序歌")
      baseViewModel.recitePoemViewModel.playJoka(shorten: shorten)
    }
    CATransaction.commit()
    self.screen = hostController
  }

  // Legacy UIKit version - deprecated but kept for reference
  private func startWithUIKit() {
    let screen = RecitePoemScreen(settings: settings)
    screen.backToPreviousAction = { [weak self] in
      self?.rewindToPrevious()
    }
    screen.openSettingsAction = { [weak self] in
      self?.openReciteSettings()
    }
    screen.backToHomeScreenAction = { [weak self] in
      self?.backToHomeScreen()
    }
    screen.startPostMortemAction = { [weak self] in
      self?.startPostMortem()
    }
    // 序歌の読み上げは画面遷移が完了したタイミングで開始したいので、
    // CATransanctionを使って、遷移アニメーション完了コールバックを使う。
    CATransaction.begin()
    navigationController.pushViewController(screen, animated: true)
    let shorten = settings.shortenJoka
    CATransaction.setCompletionBlock {
      screen.playerFinishedAction = { [weak self] in
        self?.jokaFinished()
      }
      screen.skipToNextScreenAction = { [weak self] in
        self?.jokaFinished()
      }
      screen.loadViewIfNeeded()
      screen.playJoka(shorten: shorten)
    }
    CATransaction.commit()
    self.screen = screen
  }
  
  func jokaFinished() {
    assert(true, "序歌の読み上げ終了!!")
    guard let firstPoem = poemSupplier.drawNextPoem() else { return }

    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      // SwiftUI版
      let number = firstPoem.number
      baseViewModel.playerFinishedAction = { [weak self, number] in
        self?.reciteKamiFinished(number: number, counter: 1)  // 序歌を読み上げたばかりなので、counterは1首目確定
      }
      addKamiScreenActionsForKamiEnding()
      let side: Side = settings.reciteMode == .hokkaido ? .shimo : .kami
      baseViewModel.stepIntoNextPoem(number: number, at: 1, total: poemSupplier.size, side: side)

    } else if let screen = self.screen as? RecitePoemScreen {
      // Legacy UIKit版
      let number = firstPoem.number
      screen.playerFinishedAction = { [weak self, number] in
        self?.reciteKamiFinished(number: number, counter: 1)
      }
      addKamiScreenActionsForKamiEnding()
      screen.stepIntoNextPoem(number: number, at: 1, total: poemSupplier.size)
    }
  }
  
  func reciteShimoFinished(number: Int, counter: Int) {
    assert(true, "\(counter)番めの歌(歌番号: \(number))の下の句の読み上げ終了。")

    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      // SwiftUI版
      if let poem = poemSupplier.drawNextPoem() {
        let number = poem.number
        let counter = poemSupplier.currentIndex
        baseViewModel.playerFinishedAction = { [weak self, number, counter] in
          self?.reciteKamiFinished(number: number, counter: counter)
        }
        addKamiScreenActionsForKamiEnding()
        let side: Side = settings.reciteMode == .hokkaido ? .shimo : .kami
        baseViewModel.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size, side: side)
      } else {
        assert(true, "歌は全て読み終えた！")
        baseViewModel.stepIntoGameEnd()
      }

    } else if let screen = self.screen as? RecitePoemScreen {
      // Legacy UIKit版
      if let poem = poemSupplier.drawNextPoem() {
        let number = poem.number
        let counter = poemSupplier.currentIndex
        screen.playerFinishedAction = { [weak self, number, counter] in
          self?.reciteKamiFinished(number: number, counter: counter)
        }
        addKamiScreenActionsForKamiEnding()
        screen.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)
      } else {
        assert(true, "歌は全て読み終えた！")
        screen.stepIntoGameEnd()
      }
    }
  }

  internal func rewindToPrevious() {
    guard let side = poemSupplier.side else {
      assert(true, "序歌の冒頭でrewidが押された")
      backToHomeScreen()
      return
    }

    if side == .kami {
      backToPreviousPoem()
    } else {  // 下の句の冒頭でrewindが押された場合
      guard let number = poemSupplier.currentPoem?.number else { return }
      let counter = poemSupplier.currentIndex
      let size = poemSupplier.size
      poemSupplier.backToKami()

      if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
        // SwiftUI版
        baseViewModel.slideBackToKami(number: number, at: counter, total: size)
        baseViewModel.playerFinishedAction = { [weak self, number, counter] in
          self?.reciteKamiFinished(number: number, counter: counter)
        }
      } else if let screen = self.screen as? RecitePoemScreen {
        // Legacy UIKit版
        screen.slideBackToKami(number: number, at: counter, total: size)
        screen.playerFinishedAction = { [weak self, number, counter] in
          self?.reciteKamiFinished(number: number, counter: counter)
        }
      }
    }
  }
  
  internal func goNextPoem() {
    assert(true, "次の詩へ進むボタンが押されたことを、初心者モードのCoordinatorが知ったよ！")
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex
    // 次の詩に進むことが決まった後は、Normalモードと同じで、デフォルトの動作をする
    reciteShimoFinished(number: number, counter: counter)
  }
  
  internal func startPostMortem() {
    print("!! Coordinatorから感想戦を始めますよ！!")
    poemSupplier.resetCurrentIndex()
    self.start()
  }
  
  // 歯車ボタンが押されたときの画面遷移をここでやる！
  internal func openReciteSettings() {
    let newNavController = UINavigationController()

    if let hostController = self.screen {
      // Both SwiftUI and UIKit use the same coordinator
      let coordinator = ReciteSettingsCoordinator(
        settings: settings,
        fromScreen: hostController,
        store: store,
        navigationController: newNavController)
      coordinator.start()
      self.childCoordinator = coordinator
    }
  }
  
  private func backToPreviousPoem() {
    if let prevPoem = poemSupplier.rollBackPrevPoem() {
      // 一つ前の歌(prevPoem)に戻す
      let number = prevPoem.number
      let counter = poemSupplier.currentIndex

      if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
        // SwiftUI版
        baseViewModel.playerFinishedAction = { [weak self] in
          self?.reciteShimoFinished(number: number, counter: counter)
        }
        baseViewModel.goBackToPrevPoem(number: number, at: counter, total: poemSupplier.size)

      } else if let screen = self.screen as? RecitePoemScreen {
        // Legacy UIKit版
        screen.playerFinishedAction = { [weak self] in
          self?.reciteShimoFinished(number: number, counter: counter)
        }
        screen.goBackToPrevPoem(number: number, at: counter, total: poemSupplier.size)
      }

    } else {
      // もう戻す歌がない (今が1首め)
      assert(true, "1首目の上の句の冒頭でrewindが押された！")
      backToHomeScreen()
    }
  }
}
