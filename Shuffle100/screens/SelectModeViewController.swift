//
//  SelectModeViewController.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/02/09.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

class SelectModeViewController: SettingsAttachedViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let screenTitle = "読み上げモードを選ぶ"
    let reciteModeHolders = [
        ReciteModeHolder(mode: .normal, title: "通常 (競技かるた)"),
        ReciteModeHolder(mode: .beginner, title: "初心者 (チラし取り)"),
        ReciteModeHolder(mode: .nonstop, title: "ノンストップ (止まらない)")
    ]
    
    lazy var picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = screenTitle
        self.view.backgroundColor = StandardColor.backgroundColor
        self.view.addSubview(picker)
        initPicker()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.saveSettingsAction?()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ReciteMode.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reciteModeHolders[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        settings.reciteMode = reciteModeHolders[row].mode
    }
    
    private func initPicker() {
        picker.dataSource = self
        picker.delegate = self
        layoutPicker()
        initialRowSelectInPicker()
    }
    
    private func layoutPicker() {
        picker.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    private func initialRowSelectInPicker() {
        picker.selectRow(row(for: settings.reciteMode)!, inComponent: 0, animated: false)
    }
    
    private func row(for mode: ReciteMode) -> Int? {
        for i in 0..<(reciteModeHolders.count) {
            if reciteModeHolders[i].mode == mode {
                return i
            }
        }
        fatalError("ReciteMode \(mode) is not supported!")
    }

}
