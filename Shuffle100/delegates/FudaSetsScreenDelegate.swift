//
//  FudaSetsScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/25.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension FudaSetsScreen: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    settings.state100 = settings.savedFudaSets[indexPath.row].state100
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    settings.savedFudaSets.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath] , with: .automatic)
  }
}


