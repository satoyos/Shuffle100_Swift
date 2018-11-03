//
//  HomeViewController.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/09/08.
//  Copyright © 2018年 里 佳史. All rights reserved.
//

import UIKit

enum HomeCellType {
    case poems
    case reciteMode
    case beginnerMode
    case singers
}

class HomeViewController: UIViewController {
    let titleName = "トップ"
    var tableView: UITableView!
    var dataSource = HomeViewControllerDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        self.view.backgroundColor = UIColor.white
        self.tableView = UITableView(frame: view.bounds, style: .grouped)
        dataSource.setupDataSources(withTypes: homeCells())
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(HomeScreenTableCell.self, forCellReuseIdentifier: "HomeScreenTableCell")
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func homeCells() -> [HomeCellType] {
        return [.poems, .reciteMode, .beginnerMode, .singers]
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return [30, 20][section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}


