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
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        let ac = UIAlertController(title: "どうやって選びますか？", message: nil, preferredStyle: .actionSheet)
        if settings.savedFudaSets.count > 0 {
            let selectSavedSetAction = UIAlertAction(title: "作った札セットから選ぶ", style: .default) { _ in
                self.openFudaSetsScreenAction?()
            }
            ac.addAction(selectSavedSetAction)
        }
        ac.addAction(ngramAction)
        ac.addAction(cancelAction)
        if let pc = ac.popoverPresentationController {
            pc.sourceView = navigationController!.toolbar
            pc.sourceRect = CGRect(x: view.frame.width, y: 0, width: 1, height: 1)
        }
        present(ac, animated: true)
    }
    
    private func showActionSheetForSaving(_ button: UIButton) {
        let newSetAction = UIAlertAction(title: "新しい札セットとして保存する", style: .default) { action in
            self.saveNewFudaSet()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        let ac = UIAlertController(title: "選んでいる札をどのように保存しますか？", message: nil, preferredStyle: .actionSheet)
        ac.addAction(newSetAction)
        ac.addAction(cancelAction)
        if let pc = ac.popoverPresentationController {
            pc.sourceView = button
            pc.sourceRect = button.frame
        }
        present(ac, animated: true)
    }
    
    func addNewFudaSet(name: String) {
        let newFudaSet = SavedFudaSet(name: name, state100: self.settings.state100)
        self.settings.savedFudaSets.append(newFudaSet)
        self.saveSettingsAction?()
        showSuccessfullySavedMessage(name: name)
    }
    
    internal func saveNewFudaSet() {
        var alertTextField: UITextField?

        let ac = UIAlertController(
            title: "新しい札セットの名前",
            message: nil,
            preferredStyle: .alert)
        ac.addTextField(configurationHandler: { (textField: UITextField!) in
            alertTextField = textField
            alertTextField?.placeholder = "札セットの名前"
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        let okAction = UIAlertAction(title: "決定", style: .default) { _ in
            if let name = alertTextField?.text {
                guard name.count > 0 else {
                    self.showAlertInhibeted(title: "新しい札セットの名前を決めましょう", message: nil) { action in
                        self.saveNewFudaSet()
                        alertTextField?.resignFirstResponder()
                    }
                    return
                }
                self.addNewFudaSet(name: name)
            }
        }
        ac.addAction(cancelAction)
        ac.addAction(okAction)
        present(ac, animated: true)
    }
    
    private func showAlertInhibeted(title: String, message: String?, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let backAction = UIAlertAction(title: "戻る", style: .cancel, handler: handler)
        ac.addAction(backAction)
        present(ac, animated: true)
    }
    
    private func showSuccessfullySavedMessage(name: String) {
        let ac = UIAlertController(title: "保存完了", message: "新しい札セット「\(name)」を保存しました。", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        ac.addAction(okAction)
        present(ac, animated: true)
    }
    
}
