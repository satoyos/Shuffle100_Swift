//
//  HelpListCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

private let helpListSections: [HelpListSection] = [
    HelpListSection(name: "使い方", dataSources: [
        HelpListDataSource(name: "設定できること", type: .html, fileName: "html/options"),
        HelpListDataSource(name: "試合の流れ (通常モード)", type: .html, fileName: "html/game_flow"),
        HelpListDataSource(name: "「初心者モード」とは？", type: .html, fileName: "html/what_is_beginner_mode"),
        HelpListDataSource(name: "試合の流れ (初心者モード)", type: .html,  fileName: "html/beginner_mode_flow"),
        HelpListDataSource(name: "「ノンストップ・モード」とは？", type: .html, fileName: "html/what_is_nonstop_mode"),
        HelpListDataSource(name: "「札セット」とその使い方", type: .html, fileName: "html/fuda_set")
    ]),
    HelpListSection(name: "その他", dataSources: [
        HelpListDataSource(name: "「いなばくん」について", type: .html, fileName: "html/about_inaba_kun"),
        HelpListDataSource(name: "このアプリを評価する", type: .html, fileName: "iii"),
        HelpListDataSource(name: "バージョン", type: .value1, fileName: nil, detail: appVersion())
    ])
]

private func appVersion() -> String {
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    return version
}

class HelpListCoordinator: Coordinator {
    var screen: HelpListViewController!
    private var navigator: UINavigationController
    private var detailHelpScreen: HelpDetailViewController!
    
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func start() {
        let screen = HelpListViewController(sections: helpListSections)
        screen.goDetailAction = { [weak self] indexPath in
            self?.goDetailScreen(indexPath: indexPath)
        }
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
    
    private func goDetailScreen(indexPath: IndexPath) {
        let dataSource = helpListSections[indexPath.section].dataSources[indexPath.row]
        if let htmlFileName = dataSource.fileName {
            print("html for HELP => \(htmlFileName)")
            let screen = HelpDetailViewController(title: dataSource.name, htmlFileName: htmlFileName)
            navigator.pushViewController(screen, animated: true)
            self.detailHelpScreen = screen
        }
    }
}
