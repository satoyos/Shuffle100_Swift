//
//  PoemPickerScreenDataSource.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

extension PoemPickerViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredPoems.count
        } else {
            return Poem100.poems.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fontSizeForVerse() * 3
    }
    
    private func fontSizeForVerse() -> CGFloat {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize
    }
    
    private func colorFor(poem: Poem) -> UIColor {
        if try! settings.state100.of_number(poem.number) {
            return Color.nadeshiko.UIColor
        }
        return UIColor.white
    }
}
