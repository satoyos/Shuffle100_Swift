//
//  NgramPickerScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then

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
    
    
    private func itemForIndex(_ indexPath: IndexPath) -> NgramPickerItem {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    private func cellHeight(of cell: UITableViewCell) -> CGFloat {
        return cell.frame.height
    }
    
    private func circleImage(for indexPath: IndexPath, withHeight height: CGFloat) -> UIImage {
//        let idForCell = itemForIndex(indexPath).id
//        let allNumbersForId = Set(arrayLiteral: numbersDic[idForCell])
        let image = selectedImageDic[.full]!
        return image.reSizeImage(reSize: CGSize(width: height, height: height))
    }
}
