//
//  ReciteSettingsViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class ReciteSettingsViewController: UITableViewController {
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

        self.title = "いろいろな設定"
        self.view.backgroundColor = .white
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
