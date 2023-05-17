//
//  DigitsPickerScreen10.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/15.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

final class DigitsPickerScreen10: SettingsAttachedScreen, SelectedPoemsNumber, PickerWithCircleImage {

    let cellReuseId = "digits10"
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetUp()
        navigationBarSetup()
    }
    
    private func tableViewSetUp() {
        self.tableView = createTableViewForScreen()
        tableView.register(SelectByGroupCell.self, forCellReuseIdentifier: cellReuseId);        view.addSubview(tableView)
    }
    
    private func navigationBarSetup() {
        self.title = "10の位の数で選ぶ"
        navigationItem.rightBarButtonItems = [
            selectedNumBadgeItem
        ]
    }
    
    func setTableDelegate(_: UITableView) {
        // to be moved somewhere
    }

}
