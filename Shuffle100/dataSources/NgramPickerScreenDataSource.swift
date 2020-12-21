//
//  NgramPickerScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then

extension NgramPickerScreen: UITableViewDataSource, PoemSelectedStateHandler {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath).then {
            $0.textLabel?.text = itemForIndex(indexPath).title
            $0.accessibilityLabel = itemForIndex(indexPath).id
            let state = selectedState(for: indexPath, withHeight: cellHeight(of: $0))
            $0.imageView?.image = state.circleImage
            ($0 as! NgramPickerTableCell).selectedStatus = state.status
        }
        return cell
    }
    
    private func itemForIndex(_ indexPath: IndexPath) -> NgramPickerItem {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    private func cellHeight(of cell: UITableViewCell) -> CGFloat {
        return cell.frame.height
    }
    
    private func  selectedState(for indexPath: IndexPath, withHeight height: CGFloat) -> (status: PoemsSelectedState, circleImage: UIImage) {
        let idForCell = itemForIndex(indexPath).id
        let allNumbersSetForId = Set(numbersDic[idForCell]!)
        let selectedNumbersSet = Set(allSelectedNumbers)
        let resultStatus = comparePoemNumbers(selected: selectedNumbersSet, with: allNumbersSetForId)
        let image = NgramPickerTableCell.selectedImageDic[resultStatus]!
        return (resultStatus, image.reSizeImage(reSize: CGSize(width: height, height: height)))
    }
}
