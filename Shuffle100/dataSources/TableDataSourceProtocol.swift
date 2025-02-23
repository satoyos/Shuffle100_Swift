//
//  TableDataSourceProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/01/14.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import UIKit

struct TableSection {
  var title: String
  var dataSources: [TableDataSource]
  
  init(title: String) {
    self.title = title
    self.dataSources = [TableDataSource]()
  }
}

protocol TableDataSource {
  var title: String { get set}
  var accessoryType: UITableViewCell.AccessoryType { get set }
  var accessibilityLabel: String? { get set }
}

