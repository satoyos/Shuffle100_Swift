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
    let reciteModeHolders = [
        ReciteModeHolder(mode: .normal, title: "通常 (競技かるた)"),
        ReciteModeHolder(mode: .beginner, title: "初心者 (チラし取り)"),
        ReciteModeHolder(mode: .nonstop, title: "ノンストップ (止まらない)")
    ]
    
    lazy var picker = UIPickerView()
    var gameSettings: GameSettings!
    
    init(gameSettings: GameSettings = GameSettings()) {
        self.gameSettings = gameSettings
        
        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    // 新しく init を定義した場合に必須
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = screenTitle
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(picker)
        initPicker()
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
    
    fileprivate func initPicker() {
        picker.dataSource = self
        picker.delegate = self
        layoutPicker()
        initialRowSelectInPicker()
    }
    
    fileprivate func layoutPicker() {
        picker.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    private func initialRowSelectInPicker() {
        picker.selectRow(row(for: gameSettings.reciteMode)!, inComponent: 0, animated: false)
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
