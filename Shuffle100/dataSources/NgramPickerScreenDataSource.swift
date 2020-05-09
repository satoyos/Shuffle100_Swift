//
//  NgramPickerScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then

internal struct NgramPickerItem: Codable {
    var id: String
    var title: String
}

internal struct NgramPickerSecion: Codable {
    var sectionId: String
    var headerTitle: String
    var items: [NgramPickerItem]
}

extension NgramPickerViewController: UITableViewDataSource {
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
        }
        return cell
    }
    
    internal func loadDataJson() -> [NgramPickerSecion] {
        let jsonPath = Bundle.main.path(forResource: "ngram", ofType: "json")!
        if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
            let decoder = JSONDecoder()
            if let sections = try? decoder.decode([NgramPickerSecion].self, from: jsonData) {
                return sections
            } else {
                fatalError("JSONデータのデコードに失敗")
            }
        } else {
            fatalError("JSONデータの読み込みに失敗")
        }
    }
    
    private func itemForIndex(_ indexPath: IndexPath) -> NgramPickerItem {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    
}
