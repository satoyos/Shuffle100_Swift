//
//  NgramPickerScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension NgramPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCell = cellForIndexPath(indexPath)
        switch tappedCell.selectedStatus {
        case .full:
            makeSelectedNone(cell: tappedCell)
        default:
            makeSelectedFull(cell: tappedCell)
        }
    }
    
    internal func cellForIndexPath(_ indexPath: IndexPath) -> NgramPickerTableCell {
        return tableView(tableView, cellForRowAt: indexPath) as! NgramPickerTableCell
    }
    
    private func makeSelectedFull(cell: NgramPickerTableCell) {
        let id = cell.accessibilityLabel!
        guard let numbers = numbersDic[id] else { fatalError("「\(id)」に対応する歌番号の配列が見つかりません")}
        settings.state100.selectInNumbers(numbers)
        updateTableAndBadge()
    }
    
    private func makeSelectedNone(cell: NgramPickerTableCell) {
        let id = cell.accessibilityLabel!
        guard let numbers = numbersDic[id] else { fatalError("「\(id)」に対応する歌番号の配列が見つかりません")}
        settings.state100.cancelInNumbers(numbers)
        updateTableAndBadge()
    }
    
    private func updateTableAndBadge() {
        updateBadgeItem()
        tableView.reloadData()
    }
}
