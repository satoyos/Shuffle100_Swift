//
//  HelpRoute.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import Foundation

enum HelpRoute: Hashable {
  case detail(title: String, fileName: String)
  case appStoreReview
}
