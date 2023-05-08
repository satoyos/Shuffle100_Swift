//
//  NgramPickerScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension NgramPickerScreen: UITableViewDelegate, TableViewHandler {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCell = selectByGroupCell(path: indexPath)
        let id = tappedCell.accessibilityLabel!
        guard let numbers = numbersDic[id] else { fatalError("「\(id)」に対応する歌番号の配列が見つかりません")}
        let newState100 =
        flippedState(from: tappedCell.selectedStatus,
                 for: numbers)
        settings.state100 = newState100
        updateTableAndBadge()
    }
    
    func selectByGroupCell(path indexPath: IndexPath) -> SelectByGroupCell {
        cellFor(path: indexPath) as! SelectByGroupCell
    }

//    private func flippedState(
//        from selectedState: PoemsSelectedState,
//        for numbers: [Int]) -> SelectedState100 {
//            
//        switch selectedState {
//        case .full:
//            return settings.state100.cancelInNumbers(numbers)
//        default:
//            return settings.state100.selectInNumbers(numbers)
//        }
//    }
}
