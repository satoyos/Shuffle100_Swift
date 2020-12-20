//
//  SelectSingerScreen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/12.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

final class SelectSingerScreen: SettingsAttachedScreen {
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "読手を選ぶ"
        self.view.backgroundColor = StandardColor.backgroundColor
        self.view.addSubview(picker)
        initPicker()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.saveSettingsAction?()
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
        picker.selectRow(row(for: settings.singerID)!, inComponent: 0, animated: false)
    }
    
    private func row(for id: String) -> Int? {
        for i in 0..<(Singers.all.count) {
            if Singers.all[i].id == id {
                return i
            }
        }
        fatalError("Singer \(id) is not supported!")
    }
}
