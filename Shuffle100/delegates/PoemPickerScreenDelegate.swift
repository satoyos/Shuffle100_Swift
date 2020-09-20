//
//  PoemPickerScreenDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem

extension PoemPickerViewController: UITableViewDelegate, UIGestureRecognizerDelegate {
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
        guard selected_num > 0 else {
            showAlertInhibeted(title: "歌を選びましょう", message: "空の札セットは保存できません。", handler: nil)
            return
        }
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
        // 五色百人一首はVersion 6.2から導入するので、それまではユーザから隠す
//        let fiveColorsAction = UIAlertAction(title: "五色百人一首の色で選ぶ", style: .default) { _ in
//            print("+五色百人一首の色から選ぶよ！")
//        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        let ac = UIAlertController(title: "どうやって選びますか？", message: nil, preferredStyle: .actionSheet)
        if settings.savedFudaSets.count > 0 {
            let selectSavedSetAction = UIAlertAction(title: "作った札セットから選ぶ", style: .default) { _ in
                self.openFudaSetsScreenAction?()
            }
            ac.addAction(selectSavedSetAction)
        }
        ac.addAction(ngramAction)
// 五色百人一首はVersion 6.2から導入するので、それまではユーザから隠す
//        ac.addAction(fiveColorsAction)
        ac.addAction(cancelAction)
        if let pc = ac.popoverPresentationController {
            pc.sourceView = navigationController!.toolbar
            pc.sourceRect = CGRect(x: view.frame.width, y: 0, width: 1, height: 1)
        }
        present(ac, animated: true)
    }
    
    @objc func cellLongPressed(recognizer: UILongPressGestureRecognizer) {
        // 押された位置でcellのPathを取得
        let point = recognizer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        if recognizer.state == UIGestureRecognizer.State.began  {
            showTorifudaAction?(indexPath)
        }
    }

    internal func showAlertInhibeted(title: String, message: String?, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let backAction = UIAlertAction(title: "戻る", style: .cancel, handler: handler)
        ac.addAction(backAction)
        present(ac, animated: true)
    }
    


 
}
