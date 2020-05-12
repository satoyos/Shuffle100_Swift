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

internal let cellReuseId = "ngrams"

class NgramPickerViewController: SettingsAttachedViewController {
    
    var tableView: UITableView!
    var sections = NgramDataFactory.createNgramPickerSctions()
    lazy var numbersDic = NgramDataFactory.createNgramNumbersDic()
    internal var allSelectedNumbers: [Int]!
    
    var selectedNum: Int {
        get {
            return settings.state100.selectedNum
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.prompt = "百首読み上げ"
        self.title = "1字目で選ぶ"
        self.allSelectedNumbers = settings.state100.allSelectedNumbers
        self.tableView = createTableViewForScreen()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = dummyButtonItem()
    }
    

    private func createTableViewForScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    private func dummyButtonItem() -> UIBarButtonItem {
        let button = UIButton(type: .custom).then {
            $0.setTitle(" ", for: .normal)
        }
        let buttonItem = BBBadgeBarButtonItem(customUIButton: button)!.then {
            $0.badgeValue = "\(selectedNum)首"
            $0.badgeOriginX = -50
            $0.badgeOriginY = 0
        }
        return buttonItem
    }

    

}
