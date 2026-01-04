//
//  ReciteSettingsDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import Foundation

struct ReciteSettingsDataSource: Hashable {
  let title: String
  let value: String
  let route: ReciteSettingsRoute
}

struct ReciteSettingsSection {
  let title: String
  var rows: [ReciteSettingsDataSource]
}
