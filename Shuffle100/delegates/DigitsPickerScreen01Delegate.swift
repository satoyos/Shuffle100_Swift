//
//  DigitsPickerScreen01Delegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/05.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

extension DigitsPickerScreen01: UITableViewDelegate, TableViewHandler {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCell = cellFor(path: indexPath) as! NgramPickerTableCell
        let newState100 = flippedState(
            from: tappedCell.selectedStatus,
            for: cardNumbers[indexPath.row])
        settings.state100 = newState100
        updateTableAndBadge()
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
