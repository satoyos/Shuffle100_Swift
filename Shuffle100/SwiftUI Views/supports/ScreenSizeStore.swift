//
//  ScreenSizeStore.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/04/21.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class ScreenSizeStore: ObservableObject {
  @Published private(set) var screenWidth: CGFloat
  @Published private(set) var screenHeight: CGFloat
  
  // 一旦デフォルトの画面サイズで初期化
  init() {
    self.screenWidth = UIScreen.main.bounds.width
    self.screenHeight = UIScreen.main.bounds.height
  }
  
  func update(width: CGFloat, height: CGFloat) {
    self.screenWidth = width
    self.screenHeight = height
  }
}
