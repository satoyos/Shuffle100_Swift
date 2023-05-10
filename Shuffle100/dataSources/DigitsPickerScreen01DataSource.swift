//
//  DigitsPickerScreen01DataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/03.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

fileprivate let cellHeight: CGFloat = 40

extension DigitsPickerScreen01: UITableViewDataSource, PoemSelectedStateHandler {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return 0 }
        return cardNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseId,
            for: indexPath)
        let (config, selecteeState) = contentConfigAndSelectedState(for: indexPath.row)
        cell.contentConfiguration = config
        (cell as! SelectByGroupCell).selectedState = selecteeState
        cell.accessibilityLabel = config.text
        return cell
    }
    
    private func contentConfigAndSelectedState(for rowNumber: Int) ->  (config: UIListContentConfiguration,
                  state: PoemsSelectedState) {

        var content = UIListContentConfiguration.cell()
        content.text = cardNumbers[rowNumber].first?.description
        content.secondaryText = "歌番号: " + cardNumbers[rowNumber].description
            .dropFirst()
            .dropLast()
        let state = selectedState(for: rowNumber)
        content.image = state.circleImage
        content.imageProperties.maximumSize =
            CGSize(width: cellHeight, height: cellHeight)
        return (content, state.selectedState)
    }

    private func  selectedState(for rowNumber: Int) -> (selectedState: PoemsSelectedState, circleImage: UIImage) {
        let allNumbersForDigit = cardNumbers[rowNumber]
        let resultState = selectedState(
                                of: selectedNumbers,
                                in: allNumbersForDigit)
        let image = SelectByGroupCell.selectedImageDic[resultState]!
        return (resultState, image)

    }
    
}
