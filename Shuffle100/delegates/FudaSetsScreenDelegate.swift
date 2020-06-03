//
//  FudaSetsScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/25.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension FudaSetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settings.state100 = settings.savedFudaSets[indexPath.row].state100
    }
}


