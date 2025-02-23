//
//  GameEndViiew.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/12/20.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class SimpleGameEndView: UIView, AllPoemsRecitedView {
  var backToHomeButton = UIButton()
  var headerContainer = UIView()
  var headerTitle: String?
  var backToHomeButtonAction: ( ()->Void )?
  
  internal func setTargetToButtons() {
    backToHomeButton.addTarget(self, action: #selector(backToHomeButtonTapped), for: .touchUpInside)
  }
  
  @objc func backToHomeButtonTapped() {
    backToHomeButtonAction?()
  }
}
