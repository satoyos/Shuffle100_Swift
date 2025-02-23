//
//  HelpListScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/21.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension HelpListScreen: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    goDetailAction?(indexPath)
  }
}
