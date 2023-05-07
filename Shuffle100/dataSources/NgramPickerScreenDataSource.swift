//
//  NgramPickerScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then

fileprivate let cellHeight: CGFloat = 44

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
            var content = UIListContentConfiguration.cell()
            content.text = itemForIndex(indexPath).title
            let state = selectedState(for: indexPath)
            content.image = state.circleImage
            content.imageProperties.maximumSize = CGSize(width: cellHeight, height: cellHeight)
            $0.contentConfiguration = content
            $0.accessibilityLabel = itemForIndex(indexPath).id
            ($0 as! SelectByGroupCell).selectedStatus = state.status
        }
        return cell
    }
    
    private func itemForIndex(_ indexPath: IndexPath) -> NgramPickerItem {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    private func  selectedState(for indexPath: IndexPath) -> (status: PoemsSelectedState, circleImage: UIImage) {
        let idForCell = itemForIndex(indexPath).id
        let allNumbersSetForId = Set(numbersDic[idForCell]!)
        let selectedNumbersSet = Set(allSelectedNumbers)
        let resultStatus = comparePoemNumbers(selected: selectedNumbersSet, with: allNumbersSetForId)
        let image = SelectByGroupCell.selectedImageDic[resultStatus]!
        return (resultStatus, image)

    }
}
