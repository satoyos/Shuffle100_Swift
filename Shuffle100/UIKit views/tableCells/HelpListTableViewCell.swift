////
////  HelpListTableViewCell.swift
////  Shuffle100
////
////  Created by Yoshifumi Sato on 2020/06/21.
////  Copyright © 2020 里 佳史. All rights reserved.
////
//
//import UIKit
//
//final class HelpListTableViewCell: UITableViewCell {
//  
//  func configure(with dataSource: HelpListDataSource) {
//    var content = UIListContentConfiguration.cell()
//    
//    switch dataSource.type {
//    case .html:
//      self.accessoryType = .disclosureIndicator
//    case .value1:
//      content = UIListContentConfiguration.valueCell()
//      guard let detail = dataSource.detail else { return }
//      content.secondaryText = detail
//    default:
//      break
//    }
//    content.text = dataSource.name
//    self.contentConfiguration = content
//  }
//  
//}
