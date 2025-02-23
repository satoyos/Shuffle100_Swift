//
//  DigitsPickerScreen01Delegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/05.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

extension DigitsPickerScreen01: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let tappedCell = cellFor(path: indexPath) as! SelectByGroupCell
    let newState100 = flippedState(
      from: tappedCell.selectedState,
      for: cardNumbers[indexPath.row])
    settings.state100 = newState100
    updateTableAndBadge()
  }
}
