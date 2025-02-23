//
//  SettingsAttachedViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/09.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class SettingsAttachedScreen: Screen {
  
  var settings: Settings!
  var saveSettingsAction: (() -> Void)?
  
  
  var selectedNum: Int {
    get {
      return settings.state100.selectedNum
    }
  }
  
  var selectedNumbers: [Int] {
    get {
      settings.state100.allSelectedNumbers
    }
  }
  
  init(settings: Settings = Settings()) {
    self.settings = settings
    
    // クラスの持つ指定イニシャライザを呼び出す
    super.init(nibName: nil, bundle: nil)
  }
  
  // 新しく init を定義した場合に必須
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
