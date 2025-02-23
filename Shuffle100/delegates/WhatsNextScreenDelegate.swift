//
//  WhatsNextScreenDelegate.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/04/30.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit

extension WhatsNextScreen {
  
  @objc func gearButtonTapped() {
    assert(true, "歯車ボタンが押された！")
    goSettingAction?()
  }
  
  @objc func exitButtonTapped() {
    confirmExittingGame()
  }
  
  @objc func torifudaButtonTapped() {
    assert(true,"取り札ボタンが押された！")
    showTorifudaAction?()
  }
  
  @objc func refrainButtonTapped() {
    assert(true, "読み直しボタンが押された！")
    dismiss(animated: true)
    refrainAction?()
  }
  
  @objc func goNextButtonTapped() {
    assert(true, "次の歌に進むボタンが押された！")
    dismiss(animated: true, completion: {
      self.goNextAction?()
    })
  }
}
