//
//  ReciteSettingsViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then

class ReciteSettingsViewController: UITableViewController {
    let reuseID = "ReciteSettings"
    var settings: Settings!
    let settingNames = ["歌と歌の間隔", "上の句と下の句の間隔", "音量調整"]

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

        self.title = "いろいろな設定"
        view.backgroundColor = .white
        self.tableView = createTableViewForReciteSettingsScreen()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath).then {
            let name = settingNames[indexPath.row]
            $0.textLabel?.text = name
        }
        return cell
    }
    
    private func createTableViewForReciteSettingsScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        return tableView
    }
}
