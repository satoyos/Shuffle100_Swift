//
//  PoemPickerScreenDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem

extension PoemPickerViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let number: Int
        if searchController.isActive {
            let selectedPoem = filteredPoems[indexPath.row]
            number = selectedPoem.number
        } else {
            number = indexPath.row + 1
        }
        settings.state100.reverseInNumber(number)
        tableView.reloadData()
        updateBadge()
        return
    }
    
    @objc func saveButtonTapped(button: UIButton) {
        assert(true, "Save Button Tapped!")
        showActionSheetForSaving(button)
    }

    @objc func cancelAllButtonTapped() {
        settings.state100.cancelAll()
        tableView.reloadData()
        updateBadge()
    }
    
    @objc func selectAllButtonTapped() {
        settings.state100.selectAll()
        tableView.reloadData()
        updateBadge()
    }
    
    @objc func selectByGroupButtonTapped() {
        let ngramAction = UIAlertAction(title: "1字目で選ぶ", style: .default) { action in
            self.openNgramPickerAction?()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        let ac = UIAlertController(title: "どうやって選びますか？", message: nil, preferredStyle: .actionSheet)
        ac.addAction(ngramAction)
        ac.addAction(cancelAction)
        if let pc = ac.popoverPresentationController {
            pc.sourceView = navigationController!.toolbar
            pc.sourceRect = CGRect(x: view.frame.width, y: 0, width: 1, height: 1)
        }
        present(ac, animated: true)
    }
    
    private func showActionSheetForSaving(_ button: UIButton) {
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel)
        let ac = UIAlertController(title: "選んでいる札をどのように保存しますか？", message: nil, preferredStyle: .actionSheet)
        ac.addAction(cancel)
        if let pc = ac.popoverPresentationController {
            pc.sourceView = self.view
            pc.sourceView = button
        }
        present(ac, animated: true)
    }
}
