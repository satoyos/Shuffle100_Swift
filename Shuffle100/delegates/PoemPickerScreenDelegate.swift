//
//  PoemPickerScreenDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

extension PoemPickerViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settings.selectedStatus100.reverse_in_index(indexPath.row)
        tableView.reloadData()
        updateBadge()
        return
    }
    
    @objc func saveButtonTapped(btn: UIBarButtonItem) {
        print("Save Button Tapped!")
    }

}
