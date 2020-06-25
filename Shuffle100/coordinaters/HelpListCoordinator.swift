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
        HelpListDataSource(name: "設定できること", type: .html, fileName: "aaa"),
        HelpListDataSource(name: "試合の流れ (通常モード)", type: .html, fileName: "bbb"),
        HelpListDataSource(name: "「初心者モード」とは？", type: .html, fileName: "ccc"),
        HelpListDataSource(name: "試合の流れ (初心者モード)", type: .html,  fileName: "ddd"),
        HelpListDataSource(name: "「ノンストップ・モード」とは？", type: .html, fileName: "eee"),
        HelpListDataSource(name: "「札セット」とその使い方", type: .html, fileName: "fff")
    ]),
    HelpListSection(name: "その他", dataSources: [
        HelpListDataSource(name: "「いなばくん」について", type: .html, fileName: "hhh"),
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
    
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func start() {
        let screen = HelpListViewController(sections: helpListSections)
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
    
    
}
