//
//  NgramPickerScreen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then


final class NgramPickerScreen: SettingsAttachedScreen, SelectedPoemsNumber, PickerWithCircleImage {
    
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
        updateTableAndBadge()
    }
    
//    internal  func updateTableAndBadge() {
//        updateBadge()
//        tableView.reloadData()
//    }
    
    private func tableViewSetUp() {
        self.tableView = createTableViewForScreen()
        tableView.register(SelectByGroupCell.self, forCellReuseIdentifier: cellReuseId);        view.addSubview(tableView)
    }
    
//    private func createTableView() -> UITableView {
//        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
//        tableView.dataSource = self
//        tableView.delegate = self
//        return tableView
//    }
    
    private func navigationBarSetUp() {
        self.title = "1字目で選ぶ"
        navigationItem.rightBarButtonItems = [
            selectedNumBadgeItem
        ]
    }
}
