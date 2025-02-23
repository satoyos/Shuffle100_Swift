//
//  SelectSingerScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/11.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension SelectSingerScreen: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    Singers.all.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    Singers.all[row].name
  }
  
}
