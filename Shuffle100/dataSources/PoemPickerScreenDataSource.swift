//
//  PoemPickerScreenDataSource.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

extension PoemPickerScreen: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredPoems.count
        } else {
            return Poem100.originalPoems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let poem: Poem
        if searchController.isActive {
            poem = filteredPoems[indexPath.row]
        } else {
            poem = Poem100.originalPoems[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "poems", for: indexPath).then {
            $0.contentConfiguration = poemPickerCellConfiguration(of: poem)
            $0.backgroundColor = colorFor(poem: poem)
            $0.tag = poem.number
            $0.accessibilityLabel = String(format: "%03d", poem.number)
            $0.accessoryType = .detailButton
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        fontSizeForPoem() * 3
    }
}

extension PoemPickerScreen:  UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        settings.savedFudaSets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        let fudaSet = settings.savedFudaSets[row]
        label.text = fudaSet.name + " (\(fudaSet.state100.selectedNum)首)"
        label.font = UIFont.systemFont(ofSize: fontSizeOfCell)
        label.textAlignment = .center
        return label
    }
    
    private func poemPickerCellConfiguration(of poem: Poem) -> UIListContentConfiguration {
        var content = UIListContentConfiguration.subtitleCell()
        content.text = poem.strWithNumberAndLiner()
        content.textProperties.font = UIFont(name: "HiraMinProN-W6", size: fontSizeForPoem()) ?? UIFont.systemFont(ofSize: fontSizeForPoem())
        content.textProperties.numberOfLines = 1
        content.secondaryText = "          \(poem.poet) \(poem.living_years)"
        content.textToSecondaryTextVerticalPadding = fontSizeForPoem() * 0.25
        return content
    }
        
    private func fontSizeForPoem() -> CGFloat {
        UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
            .pointSize
    }
    
    private func colorFor(poem: Poem) -> UIColor {
        if try! settings.state100.ofNumber(poem.number) {
            return StandardColor.selectedPoemBackColor
        }
        return UIColor.systemBackground
    }

}
