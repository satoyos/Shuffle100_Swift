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
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    actionForViewWillDissappear?()
  }
}

