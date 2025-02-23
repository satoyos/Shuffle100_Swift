//
//  TableViewHandlerProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/06.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

protocol TableViewHandler where Self: UITableViewDataSource {
  var tableView: UITableView! { get }
  
  func cellFor(path: IndexPath) -> UITableViewCell
  func cellIn1stSection(row: Int) -> UITableViewCell
}

extension TableViewHandler {
  func cellFor(path: IndexPath) -> UITableViewCell {
    tableView(tableView, cellForRowAt: path)
  }
  
  func cellIn1stSection(row: Int) -> UITableViewCell {
    cellFor(path: IndexPath(row: row, section: 0))
  }
}


