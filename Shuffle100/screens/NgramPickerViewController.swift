//
//  NgramPickerViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then
import BBBadgeBarButtonItem


class NgramPickerViewController: SettingsAttachedViewController {
    
    internal let cellReuseId = "ngrams"
    var tableView: UITableView!
    var sections = NgramDataFactory.createNgramPickerSctions()
    var numbersDic = NgramDataFactory.createNgramNumbersDic()
    var badgeItem: BBBadgeBarButtonItem!
    
    var selectedNum: Int {
        get {
            return settings.state100.selectedNum
        }
    }
    
    var allSelectedNumbers: [Int] {
        get {
            return settings.state100.allSelectedNumbers
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.prompt = "百首読み上げ"
        self.title = "1字目で選ぶ"
        self.tableView = createTableViewForScreen()
        tableView.register(NgramPickerTableCell.self, forCellReuseIdentifier: cellReuseId);        view.addSubview(tableView)
        self.badgeItem = dummyButtonItem()
        updateBadgeItem()
        navigationItem.rightBarButtonItem = badgeItem
    }
    

    private func createTableViewForScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    private func dummyButtonItem() -> BBBadgeBarButtonItem {
        let button = UIButton(type: .custom).then {
            $0.setTitle(" ", for: .normal)
        }
        let buttonItem = BBBadgeBarButtonItem(customUIButton: button)!.then {
            $0.badgeOriginX = -50
            $0.badgeOriginY = 0
        }
        return buttonItem
    }

    internal func updateBadgeItem() {
        badgeItem.badgeValue = "\(selectedNum)首"
    }
}
