//
//  ReciteSettingsViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then

class ReciteSettingsViewController: SettingsAttachedViewController, UITableViewDataSource, UITableViewDelegate {
    let reuseID = "ReciteSettings"
    var tableView: UITableView!
    let settingNames = ["歌と歌の間隔", "上の句と下の句の間隔", "音量調整"]
    var intervalSettingAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "いろいろな設定"
        view.backgroundColor = StandardColor.backgroundColor
        self.tableView = createTableViewForReciteSettingsScreen()
        view.addSubview(tableView)        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath).then {
            let name = settingNames[indexPath.row]
            $0.textLabel?.text = name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.intervalSettingAction?()
        default:
            assertionFailure("他の選択肢は対応していません！")
        }
    }
    
    private func createTableViewForReciteSettingsScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        return tableView
    }
}
