//
//  ColorOfFiveButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/09/30.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit


final class ColorOfFiveButton: LargeImageAttachedButton {
  var color: FiveColors
  
  init(_ color: FiveColors) {
    self.color = color
    super.init(frame: CGRect.zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func initWithImage(filename: String) {
    imageView?.contentMode = .scaleToFill
    guard let colorData = FiveColorsDataHolder.sharedDic[color] else { return }
    imageView?.tintColor = colorData.uicolor
    setImageOf(filename: filename, with: .alwaysTemplate)
  }
}
