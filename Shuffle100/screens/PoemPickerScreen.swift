//
//  PoemPickerScreen.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/03/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem
import Then

final class PoemPickerScreen: SettingsAttachedScreen {
    internal var searchController: UISearchController!
    internal var filteredPoems = [Poem]()
    var tableView: UITableView!
    var selectByGroupAction: InjectedAction?
    var openNgramPickerAction: InjectedAction?
    var openFudaSetsScreenAction: InjectedAction?
    var openFiveColorsScreenAction: InjectedAction?
    var showTorifudaAction: ((_ number: Int) -> Void)?
    var rowForFudaSetOverwritten: Int = 0
    var fontSizeOfCell: CGFloat!
    
    var selected_num: Int {
        settings.state100.selectedNum
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetUp()
        navigationBarSetUp()
        searchSetup()
        toolBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateBadge()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         navigationController?.setToolbarHidden(false, animated: true)
        let firstCell = self.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        guard let content = firstCell.contentConfiguration as? UIListContentConfiguration else {
            assertionFailure("contentConfiguration must be UIListConentConfiguration")
            return
        }
        self.fontSizeOfCell = content.textProperties.font.pointSize
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.saveSettingsAction?()
        navigationController?.setToolbarHidden(true, animated: true)
        super.viewWillDisappear(animated)
    }
    
    internal func updateBadge() {
        if let btnWithBadge = navigationItem.rightBarButtonItem as? BBBadgeBarButtonItem {
            btnWithBadge.badgeValue = "\(selected_num)首"
        }
    }
    
    private func tableViewSetUp() {
        self.tableView = createTableViewForScreen()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "poems")
        view.addSubview(tableView)
    }
    
    private func navigationBarSetUp() {
        self.navigationItem.title = "歌を選ぶ"
        navigationItem.rightBarButtonItem = saveButtonItem()
    }
    
    private func createTableViewForScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
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
            $0.hidesNavigationBarDuringPresentation = false
            $0.obscuresBackgroundDuringPresentation = false
            $0.searchBar.placeholder = "歌を検索"
        }
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func toolBarSetup() {
        let cancelAllButton = UIBarButtonItem(title: "全て取消", style: .plain, target: self, action: #selector(cancelAllButtonTapped))
        let selectAllButton = UIBarButtonItem(title: "全て選択", style: .plain, target: self, action: #selector(selectAllButtonTapped))
        let selectGroupButton = UIBarButtonItem(title: "まとめて選ぶ", style: .plain, target: self, action: #selector(selectByGroupButtonTapped))
        let flexibleSpace1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolbarItems = [cancelAllButton, flexibleSpace1, selectAllButton, flexibleSpace1, selectGroupButton]
    }
}
