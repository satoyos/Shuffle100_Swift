//
//  NgramPickerScreen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then
import BBBadgeBarButtonItem


final class NgramPickerScreen: SettingsAttachedScreen, SelectedPoemsNumber {
    
    internal let cellReuseId = "ngrams"
    var tableView: UITableView!
    var sections = NgramDataFactory.createNgramPickerSctions()
    var numbersDic = NgramDataFactory.createNgramNumbersDic()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetUp()
        navigationBarSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateBadge()
    }
    
    private func tableViewSetUp() {
        self.tableView = tableViewForScreen
        tableView.register(NgramPickerTableCell.self, forCellReuseIdentifier: cellReuseId);        view.addSubview(tableView)
    }
    
    private var tableViewForScreen: UITableView {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    private func navigationBarSetUp() {
        self.title = "1字目で選ぶ"
        navigationItem.rightBarButtonItems = [
            selectedNumBadgeItem
        ]
    }
}
