//
//  SelectSingerViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/12.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

class SelectSingerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let picker = UIPickerView()
    
    var settings: Settings!

    init(settings: Settings = Settings()) {
        self.settings = settings

        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    // 新しく init を定義した場合に必須
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "読手を選ぶ"
        navigationItem.prompt = "百首読み上げ"
        self.view.backgroundColor = StandardColor.backgroundColor
        self.view.addSubview(picker)
        initPicker()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Singers.all.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Singers.all[row].name
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
