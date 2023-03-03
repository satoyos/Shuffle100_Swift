//
//  NgramPickerScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension NgramPickerScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCell = cellForIndexPath(indexPath)
        let id = tappedCell.accessibilityLabel!
        guard let numbers = numbersDic[id] else { fatalError("「\(id)」に対応する歌番号の配列が見つかりません")}
        let newState100 =
        flippedState(from: tappedCell.selectedStatus,
                 for: numbers)
        settings.state100 = newState100
        updateTableAndBadge()
    }
    
    internal func cellForIndexPath(_ indexPath: IndexPath) -> NgramPickerTableCell {
        return tableView(tableView, cellForRowAt: indexPath) as! NgramPickerTableCell
    }
    
    private func flippedState(
        from selectedState: PoemsSelectedState,
        for numbers: [Int]) -> SelectedState100 {
            
        switch selectedState {
        case .full:
            return settings.state100.cancelInNumbers(numbers)
        default:
            return settings.state100.selectInNumbers(numbers)
        }
    }
}
