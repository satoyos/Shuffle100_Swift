//
//  PoemPickerViewController.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/03/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem
import Then

class PoemPickerViewController: UITableViewController {
    var settings: Settings!
    private var searchController: UISearchController!
    
    var selected_num: Int {
        get {
            return settings.state100.selectedNum
        }
    }

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
        navigationItem.prompt = "百首読み上げ"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "poems")
        self.navigationItem.title = "歌を選ぶ"
        navigationItem.rightBarButtonItem = saveButtonItem()
        searchSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateBadge()
    }
    
    internal func updateBadge() {
        if let btnWithBadge = navigationItem.rightBarButtonItem as? BBBadgeBarButtonItem {
            btnWithBadge.badgeValue = "\(selected_num)首"
        }
    }
    
    private func saveButtonItem() -> UIBarButtonItem? {
        let button = UIButton(type: .custom).then {
            $0.setTitle("保存", for: .normal)
            $0.setStandardColor()
            $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        }
        let buttonItem = BBBadgeBarButtonItem(customUIButton: button)!.then {
            $0.badgeValue = "\(selected_num)首"
            $0.badgeOriginX = -50
            $0.badgeOriginY = 5
        }
        return buttonItem
    }
    
    private func searchSetup() {
        searchController = UISearchController(searchResultsController: nil).then {
            $0.searchResultsUpdater = self
            $0.searchBar.placeholder = "歌を検索"
        }
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}
