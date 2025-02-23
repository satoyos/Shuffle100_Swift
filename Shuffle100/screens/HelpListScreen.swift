//
//  HelpListScreen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class HelpListScreen: Screen {
  internal var helpListSections: [HelpListSection]!
  var tableView: UITableView!
  let cellReuseId = "HelpList"
  var goDetailAction: ((_ indexPath: IndexPath) -> Void)?
  
  init(sections: [HelpListSection] = []) {
    self.helpListSections = sections
    
    // クラスの持つ指定イニシャライザを呼び出す
    super.init(nibName: nil, bundle: nil)
  }
  
  // 新しく init を定義した場合に必須
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "ヘルプ"
    self.tableView = createTableViewForScreen()
    tableView.register(HelpListTableViewCell.self, forCellReuseIdentifier: cellReuseId)
    view.addSubview(tableView)
  }
  
  private func createTableViewForScreen() -> UITableView {
    let tableView = UITableView(frame: view.bounds, style: .grouped)
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }
}
