//
//  NgramPickerScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

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
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
    
    
}
