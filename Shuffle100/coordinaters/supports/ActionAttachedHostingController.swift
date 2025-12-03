//
//  ActionAttachedHostingController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/12/31.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ActionAttachedHostingController<Content>: UIHostingController<Content> where Content: View {

  var actionForViewWillDissappear: InjectedAction?
  var actionForViewWillAppear: InjectedAction?

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // SwiftUIの.toolbar(.hidden)設定を上書きして、ナビゲーションバーを表示状態に戻す
    navigationController?.setNavigationBarHidden(false, animated: animated)
    actionForViewWillDissappear?()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    actionForViewWillAppear?()
  }
}

