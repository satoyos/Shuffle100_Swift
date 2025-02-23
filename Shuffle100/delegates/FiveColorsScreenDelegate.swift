//
//  FiveColorsScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/10/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension FiveColorsScreen {
  @objc func colorButtonTapped(_ colorButton: ColorOfFiveButton) {
    guard let colorDic = colorsDic[colorButton.color] else { return }
    let ac = UIAlertController(
      title: "\(colorDic.name)色の20首をどうしますか？",
      message: nil,
      preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
    ac.addAction(selectJust20Action(for: colorDic.type))
    ac.addAction(add20Action(for: colorDic.type))
    ac.addAction(cancelAction)
    if let pc = ac.popoverPresentationController {
      pc.sourceView = self.view
      pc.sourceRect = colorButton.frame
    }
    present(ac, animated: true)
  }
  
  private func selectJust20Action(for color: FiveColors) -> UIAlertAction {
    UIAlertAction(title: "この20首だけを選ぶ", style: .default) { _ in
      self.selectJust20Of(color: color)
    }
  }
  
  private func add20Action(for color: FiveColors) -> UIAlertAction {
    UIAlertAction(title: "今選んでいる札に加える", style: .default) { _ in
      self.add20of(color: color)
    }
  }
  
  func selectJust20Of(color: FiveColors) {
    guard let colorDic = colorsDic[color] else { return }
    let newState100 = SelectedState100()
      .cancelAll()
      .selectInNumbers(colorDic.poemNumbers)
    settings.state100 = newState100
    refreshImageOnButtons()
    updateBadge()
  }
  
  func add20of(color: FiveColors) {
    guard let colorDic = colorsDic[color] else { return }
    let newState100 = settings.state100.selectInNumbers(colorDic.poemNumbers)
    settings.state100 = newState100
    refreshImageOnButtons()
    updateBadge()
  }
}
