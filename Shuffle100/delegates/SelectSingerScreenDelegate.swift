//
//  SelectSingerScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/11.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension SelectSingerScreen: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let index = pickerView.selectedRow(inComponent: 0)
    let selectedSinger = Singers.all[index]
    
    // いなばくんが選択された場合、音声ファイルの存在を確認
    if selectedSinger.id == "inaba" && !selectedSinger.hasRequiredAudioFiles() {
      showMissingFilesAlert()
      // デフォルト（IA）に戻す
      settings.singerID = Singers.defaultSinger.id
      picker.selectRow(0, inComponent: 0, animated: true)
    } else {
      settings.singerID = selectedSinger.id
    }
  }
  
  private func showMissingFilesAlert() {
    let alert = UIAlertController(
      title: "音声ファイルが見つかりません",
      message: "読み手として「いなばくん」を選ぶには、必要な音声ファイルを入手して `resources/audio/inaba/` フォルダに配置してください。現在はIA（ボーカロイド）を選択します。",
      preferredStyle: .alert
    )
    
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
  }
  
}
