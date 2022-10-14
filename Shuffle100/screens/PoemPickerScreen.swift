//
//  PoemPickerScreen.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/03/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import Then

final class PoemPickerScreen: SettingsAttachedScreen, SelectedPoemsNumber {
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
        if let numBadgeItem = navigationItem.rightBarButtonItems?.last {
            if let badgeView = numBadgeItem.customView as? BadgeSwift {
                badgeView.setTextWithAnimation("\(selected_num)首")
            }
        } 
    }
    
    private func tableViewSetUp() {
        self.tableView = tableViewForPoemPicker
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "poems")
        view.addSubview(tableView)
    }
    
    private func navigationBarSetUp() {
        self.navigationItem.title = "歌を選ぶ"
        navigationItem.rightBarButtonItems = [
            saveButtonItem,
            selectedNumBadgeItem
        ]
    }
    
    private var tableViewForPoemPicker: UITableView {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    private var saveButtonItem: UIBarButtonItem {
         UIBarButtonItem(
            title: "保存",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped))
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
    
//    private var selectedNumBadgeItem: UIBarButtonItem {
//        let badgeView = BadgeSwift().then {
//            $0.text = "\(selected_num)首"
//            $0.insets = CGSize(width: 5, height: 5)
//            $0.font = UIFont.preferredFont(forTextStyle: .caption1)
//            $0.textColor = .white
//            $0.badgeColor = .systemRed
//            $0.sizeToFit()
//        }
//        return UIBarButtonItem(customView: badgeView)
//    }
}
