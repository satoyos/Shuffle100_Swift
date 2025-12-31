//
//  ConfigureButtonTypeCellProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/01/23.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import UIKit

protocol ConfigureButtonTypeCell {
  func configure(dataSource: ButtonTypeCellDataSource)
}

extension ConfigureButtonTypeCell where Self: UITableViewCell {
  func configure(dataSource: ButtonTypeCellDataSource) {
    
    self.contentConfiguration = createListContentConfiguration(from: dataSource)
    self.accessibilityLabel = dataSource.accessibilityLabel
    self.accessibilityIdentifier = dataSource.title
  }
  
  private func createListContentConfiguration(from dataSource: ButtonTypeCellDataSource) -> UIListContentConfiguration {
    var content: UIListContentConfiguration = .cell()
    content.text = dataSource.title
    content.textProperties.color = colorFromDataSource(dataSource)
    content.textProperties.font = UIFont.preferredFont(for: .body, weight: fontWeightFromDataSource(dataSource))
    content.textProperties.alignment = .center
    return content
  }
  
  private func colorFromDataSource(_ dataSource: ButtonTypeCellDataSource) -> UIColor {
    let color: UIColor
    switch dataSource.titleColor {
    case .red:
      color = .systemRed
    default:
      color = .label
    }
    return color
  }
  
  private func fontWeightFromDataSource(_ dataSource: ButtonTypeCellDataSource) -> UIFont.Weight {
    let weight: UIFont.Weight
    switch dataSource.fontWeight {
    case .bold:
      weight = .bold
    default:
      weight = .regular
    }
    return weight
  }
}
