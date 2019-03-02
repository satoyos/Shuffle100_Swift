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
    case fakeMode = "fakeModeCell"
    case singers = "singersCell"
}

class HomeViewController: UIViewController {
    let titleName = "トップ"
    let navBarButtonSize = 32
    var tableView: UITableView!
    var sections = [TableSection]()
    var gameSettings: GameSettings!
    
    init(gameSettings: GameSettings) {
        self.gameSettings = gameSettings
        
        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    // 新しく init を定義した場合に必須
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(gameSettings: GameSettings())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        self.view.backgroundColor = UIColor.white
        self.tableView = createTableViewForHomeScreen()
        view.addSubview(tableView)
        setNavigationBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        tableView.register(HomeScreenTableCell.self, forCellReuseIdentifier: HomeScreenTableCell.identifier)
        tableView.register(GameStartCell.self, forCellReuseIdentifier: GameStartCell.identifier)
        return tableView
    }
    
    private func homeCells() -> [HomeCellType] {
        var homeCellTypes: [HomeCellType] = [.poems, .reciteMode, .fakeMode, .singers]
        if gameSettings.reciteMode == .beginner {
           homeCellTypes.remove(at: 2)
        }
        return homeCellTypes
    }
    
    private func setNavigationBarButtons() {
        let reSize = CGSize(width: navBarButtonSize, height: navBarButtonSize)
        setSettingsButton(withSize: reSize)
        setHelpButton(withSize: reSize)
    }
    
    private func setSettingsButton(withSize reSize: CGSize) {
        let gearButton = UIBarButtonItem(
            image: UIImage(named: "gear-520.png")?.reSizeImage(reSize: reSize),
            style: UIBarButtonItem.Style.plain, target: self, action: nil)
        gearButton.accessibilityLabel = "GearButton"
        self.navigationItem.leftBarButtonItem = gearButton
    }
    
    private func setHelpButton(withSize reSize: CGSize) {
        let helpButton = UIBarButtonItem(
            image: UIImage(named: "question_white.png")?.reSizeImage(reSize: reSize),
            style: UIBarButtonItem.Style.plain, target: self, action: nil)
        helpButton.accessibilityLabel = "HelpButton"
        self.navigationItem.rightBarButtonItem = helpButton
    }
    
}
