//
//  PoemRecitation.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/12/10.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

/// 序歌と下の句の読み上げ機能を提供するプロトコル（全モード共通）
protocol PoemRecitation: RecitePoemCore {
  func jokaFinished() -> Void
  func reciteShimoFinished(number: Int, counter: Int) -> Void
  func goNextPoem() -> Void
}

extension PoemRecitation where Self: Coordinator {

  // rewindToPrevious()のデフォルト実装
  // KamiShimoRecitationではオーバーライドされる
  internal func rewindToPrevious() {
    guard let side = poemSupplier.side else {
      assert(true, "序歌の冒頭でrewidが押された")
      backToHomeScreen()
      return
    }

    // 北海道モードでは常に下の句のみなので、.shimoの場合のみ処理
    if side == .shimo {
      backToPreviousPoem()
    }
  }

  private func backToPreviousPoem() {
    if let prevPoem = poemSupplier.rollBackPrevPoem() {
      // 一つ前の歌(prevPoem)に戻す
      let number = prevPoem.number
      let counter = poemSupplier.currentIndex

      // rollBackPrevPoem()は下の句に戻るので、sideを.shimoに更新
      poemSupplier.stepIntoShimo()

      if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
        baseViewModel.playerFinishedAction = { [weak self] in
          self?.reciteShimoFinished(number: number, counter: counter)
        }
        baseViewModel.goBackToPrevPoem(number: number, at: counter, total: poemSupplier.size)
      } else {
        assertionFailure("Couldn't get baseViewModel")
      }

    } else {
      // もう戻す歌がない (今が1首め)
      assert(true, "1首目の上の句の冒頭でrewindが押された！")
      backToHomeScreen()
    }
  }
}
