//
//  HomeViewController.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/09/08.
//  Copyright © 2018年 里 佳史. All rights reserved.
//

import UIKit

enum HomeCellType: String {
    case poems = "poemsCell"
    case reciteMode = "reciteModeCell"
    case beginnerMode = "beginnerModeCell"
    case singers = "singersCell"
    case startGame = "startGameCell"
}

class HomeViewController: UIViewController {
    let titleName = "トップ"
    var tableView: UITableView!
    var sections = [TableSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        self.view.backgroundColor = UIColor.white
        self.tableView = createTableViewForHomeScreen()
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createTableViewForHomeScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        setupDataSources(withTypes: homeCells())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeScreenTableCell.self, forCellReuseIdentifier: "HomeScreenTableCell")
        tableView.register(GameStartCell.self, forCellReuseIdentifier: "GameStartCell")
        return tableView
    }
    
    private func homeCells() -> [HomeCellType] {
        return [.poems, .reciteMode, .beginnerMode, .singers]
    }
}
