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

enum NgramSelectedStatus {
    case full
    case partial
    case none
}

private let selectedImageDic: [NgramSelectedStatus: UIImage] = [
    .full: UIImage(named: "blue_circle_full.png")!,
    .partial: UIImage(named: "blue_circle_half.png")!,
    .none: UIImage(named: "blue_circle_empty.png")!
]

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
            $0.imageView?.image = circleImage(for: indexPath, withHeight: cellHeight(of: $0))
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
    
    private func cellHeight(of cell: UITableViewCell) -> CGFloat {
        return cell.frame.height
    }
    
    private func circleImage(for indexPath: IndexPath, withHeight height: CGFloat) -> UIImage {
//
//        ToDo: ここ、イメージを決め打ちにしているので、正しいイメージが表示されるようにする！
//        
        let image = selectedImageDic[.full]!
        return image.reSizeImage(reSize: CGSize(width: height, height: height))
    }
}
