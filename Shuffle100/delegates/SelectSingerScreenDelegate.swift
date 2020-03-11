//
//  SelectSingerScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/11.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension SelectSingerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let index = pickerView.selectedRow(inComponent: 0)
        settings.singerID = Singers.all[index].id
    }
    
}
