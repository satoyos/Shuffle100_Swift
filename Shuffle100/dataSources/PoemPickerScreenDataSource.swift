//
//  PoemPickerScreenDataSource.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

extension PoemPickerViewController: UITableViewDataSource, UIPickerViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredPoems.count
        } else {
            return Poem100.poems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let poem: Poem
        if searchController.isActive {
            poem = filteredPoems[indexPath.row]
        } else {
            poem = Poem100.poems[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "poems", for: indexPath).then {
            $0.textLabel?.text = poem.strWithNumberAndLiner()
            $0.textLabel?.font = UIFont(name: "HiraMinProN-W6", size: fontSizeForVerse())
            $0.textLabel?.adjustsFontForContentSizeCategory = true
            $0.backgroundColor = colorFor(poem: poem)
            $0.tag = poem.number
            $0.accessibilityLabel = String(format: "%03d", poem.number)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fontSizeForVerse() * 3
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settings.savedFudaSets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return settings.savedFudaSets[row].name
    }
        
    private func fontSizeForVerse() -> CGFloat {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize
    }
    
    private func colorFor(poem: Poem) -> UIColor {
        if try! settings.state100.ofNumber(poem.number) {
            return StandardColor.selectedPoemBackColor
        }
        return UIColor.systemBackground
    }
}
