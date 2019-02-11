//
//  SelectModeViewController.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/02/09.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

class SelectModeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let screenTitle = "読み上げモードを選ぶ"
    let reciteModeTitles = ["通常 (競技かるた)", "初心者 (チラし取り)", "ノンストップ (止まらない)"]
    lazy var picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = screenTitle
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(picker)
        picker.dataSource = self
        picker.delegate = self
        picker.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ReciteMode.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reciteModeTitles[row]
    }

}
