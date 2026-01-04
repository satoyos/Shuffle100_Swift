//
//  HelpListDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/21.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

struct HelpListDataSource {
  enum SourceType {
    case html
    case review
    case value1
  }
  let name: String
  let type: SourceType
  let fileName: String?
  var detail: String? = nil
}

struct HelpListSection {
  let name: String
  var dataSources: [HelpListDataSource]
}
