//
//  HomeScreen.swift
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

final class HomeScreen: SettingsAttachedScreen {
    let titleName = "トップ"
    let navBarButtonSize = 32
    var tableView: UITableView!
    internal let settingsReuseId = "HomeScreenTableCell"
    internal let startGameReuseId = "GameStartCell"
    var sections: [TableSection]!
    var selectPoemAction: InjectedAction?
    var selectModeAction: InjectedAction?
    var selectSingerAction: InjectedAction?
    var startGameAction: InjectedAction?
    var reciteSettingsAction: InjectedAction?
    var helpActioh: InjectedAction?
    var memorizeTimerAction: InjectedAction?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        self.view.backgroundColor = UIColor.white
        self.tableView = createTableViewForHomeScreen()
        view.addSubview(tableView)
        setNavigationBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        setupDataSources(with: homeCells())
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createTableViewForHomeScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        setupDataSources(with: homeCells())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingTableCell.self, forCellReuseIdentifier: settingsReuseId)
        tableView.register(GameStartCell.self, forCellReuseIdentifier: startGameReuseId)
        return tableView
    }
    
    private func homeCells() -> [HomeCellType] {
        var homeCellTypes: [HomeCellType] = [.poems, .reciteMode, .fakeMode, .singers]
        if settings.reciteMode == .beginner {
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
            style: UIBarButtonItem.Style.plain, target: self, action: #selector(gearButtonTapped))
        gearButton.accessibilityLabel = "GearButton"
        
        self.navigationItem.leftBarButtonItem = gearButton
    }
    
    private func setHelpButton(withSize reSize: CGSize) {
        let helpButton = UIBarButtonItem(
            image: UIImage(named: "question_white.png")?.reSizeImage(reSize: reSize),
            style: UIBarButtonItem.Style.plain, target: self, action: #selector(helpButtonTapped))
        helpButton.accessibilityLabel = "HelpButton"
        self.navigationItem.rightBarButtonItem = helpButton
    }    
}
