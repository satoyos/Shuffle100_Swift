//
//  PoemPickerScreenDelegate+FudaSet.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/12.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

extension PoemPickerScreen: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.rowForFudaSetOverwritten = row
  }
}

extension PoemPickerScreen {
  internal func showActionSheetForSaving() {
    
    let newSetAction = UIAlertAction(title: "新しい札セットとして保存する", style: .default) { action in
      self.saveNewFudaSet()
    }
    let overwriteSetAction = UIAlertAction(title: "前に作った札セットを上書きする", style: .default) { _ in
      self.overwriteExistingFudaSet()
    }
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
    let ac = UIAlertController(title: "選んでいる札をどのように保存しますか？", message: nil, preferredStyle: .actionSheet)
    ac.addAction(newSetAction)
    if settings.savedFudaSets.count > 0 {
      ac.addAction(overwriteSetAction)
    }
    ac.addAction(cancelAction)
    if let pc = ac.popoverPresentationController {
      pc.barButtonItem = navigationItem.rightBarButtonItems?.first
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
    let ac = UIAlertController(
      title: "新しい札セットの名前",
      message: nil,
      preferredStyle: .alert)
    ac.addTextField { textField in
      textField.placeholder = "札セットの名前"
    }
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
    let okAction = okAction(with: ac.textFields?.first)
    ac.addAction(cancelAction)
    ac.addAction(okAction)
    present(ac, animated: true)
  }
  
  private func okAction(with textField: UITextField?) ->  UIAlertAction {
    UIAlertAction(title: "決定", style: .default) { _ in
      if let name = textField?.text {
        guard name.count > 0 else {
          self.showAlertInhibeted(title: "新しい札セットの名前を決めましょう", message: nil) { _ in
            self.saveNewFudaSet()
          }
          return
        }
        self.addNewFudaSet(name: name)
      }
    }
  }
  
  internal func overwriteExistingFudaSet() {
    let sizeByDevice = SizeFactory.createSizeByDevice()
    let fudaSetPickerWidth = sizeByDevice.fudaSetPickerWidth
    let pickerView = UIPickerView(frame: CGRect(x: 0, y: 50, width: fudaSetPickerWidth, height: 150))
    pickerView.delegate = self
    pickerView.dataSource = self
    let ac = UIAlertController(title: "上書きする札セットを選ぶ", message: "\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    ac.view.addSubview(pickerView)
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
    let overwriteAction = UIAlertAction(title: "上書きする", style: .default) { _ in
      self.executeOverwrite()
    }
    ac.addAction(cancelAction)
    ac.addAction(overwriteAction)
    present(ac, animated: true)
  }
  
  private func showSuccessfullySavedMessage(name: String) {
    let ac = UIAlertController(title: "保存完了", message: "新しい札セット「\(name)」を保存しました。", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    ac.addAction(okAction)
    present(ac, animated: true)
  }
  
  private func executeOverwrite() {
    let currentFudaSet = settings.savedFudaSets[rowForFudaSetOverwritten]
    let newFudaSet = SavedFudaSet(name: currentFudaSet.name, state100: settings.state100)
    settings.savedFudaSets[self.rowForFudaSetOverwritten] = newFudaSet
    saveSettingsAction?()
    popupOverwritingResult(name: currentFudaSet.name)
  }
  
  private func popupOverwritingResult(name: String) {
    let ac = UIAlertController(title: "上書き完了", message: "前に作った札セット「\(name)」を上書き保存しました。", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    ac.addAction(okAction)
    present(ac, animated: true)
  }
}
