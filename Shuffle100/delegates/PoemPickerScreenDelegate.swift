//
//  PoemPickerScreenDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem

extension PoemPickerScreen: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let number = poemNumberFromIndexPath(indexPath)
       let newState100 = settings.state100.reverseInNumber(number)
        settings.state100 = newState100
        tableView.reloadData()
        updateBadge()
        return
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let number = poemNumberFromIndexPath(indexPath)
        showTorifudaAction?(number)
    }
    
    private func poemNumberFromIndexPath(_ indexPath: IndexPath) -> Int {
        let number: Int
        if searchController.isActive {
            let selectedPoem = filteredPoems[indexPath.row]
            number = selectedPoem.number
        } else {
            number = indexPath.row + 1
        }
        return number
    }
}

extension PoemPickerScreen: UIGestureRecognizerDelegate {
    
    internal func showAlertInhibeted(title: String, message: String?, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let backAction = UIAlertAction(title: "戻る", style: .cancel, handler: handler)
        ac.addAction(backAction)
        present(ac, animated: true)
    }
}

// exec actions related to each Button
extension PoemPickerScreen {
    @objc func saveButtonTapped(button: UIButton) {
        guard selected_num > 0 else {
            showAlertInhibeted(title: "歌を選びましょう", message: "空の札セットは保存できません。", handler: nil)
            return
        }
        showActionSheetForSaving(button)
    }

    @objc func cancelAllButtonTapped() {
        let newState100 = settings.state100.cancelAll()
        settings.state100 = newState100
        tableView.reloadData()
        updateBadge()
    }
    
    @objc func selectAllButtonTapped() {
        let newState100 = settings.state100.selectAll()
        settings.state100 = newState100
        tableView.reloadData()
        updateBadge()
    }
    
    @objc func selectByGroupButtonTapped() {
        let ngramAction = UIAlertAction(title: "1字目で選ぶ", style: .default) { action in
            self.openNgramPickerAction?()
        }
        let fiveColorsAction = UIAlertAction(title: "五色百人一首の色で選ぶ", style: .default) { _ in
            self.openFiveColorsScreenAction?()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        let ac = UIAlertController(title: "どうやって選びますか？", message: nil, preferredStyle: .actionSheet)
        if settings.savedFudaSets.count > 0 {
            let selectSavedSetAction = UIAlertAction(title: "作った札セットから選ぶ", style: .default) { _ in
                self.openFudaSetsScreenAction?()
            }
            ac.addAction(selectSavedSetAction)
        }
        ac.addAction(ngramAction)
        ac.addAction(fiveColorsAction)
        ac.addAction(cancelAction)
        if let pc = ac.popoverPresentationController {
            pc.sourceView = navigationController!.toolbar
            pc.sourceRect = CGRect(x: view.frame.width, y: 0, width: 1, height: 1)
        }
        present(ac, animated: true)
    }
}
