//
//  HelpListCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

private var helpListSections: [HelpListSection] = [
    HelpListSection(name: "使い方", dataSources: [
        HelpListDataSource(name: "設定できること", type: .html, fileName: "html/options"),
        HelpListDataSource(name: "試合の流れ (通常モード)", type: .html, fileName: "html/game_flow"),
        HelpListDataSource(name: "「初心者モード」とは？", type: .html, fileName: "html/what_is_beginner_mode"),
        HelpListDataSource(name: "試合の流れ (初心者モード)", type: .html,  fileName: "html/beginner_mode_flow"),
        HelpListDataSource(name: "「ノンストップ・モード」とは？", type: .html, fileName: "html/what_is_nonstop_mode"),
        HelpListDataSource(name: "「札セット」とその使い方", type: .html, fileName: "html/fuda_set"),
        HelpListDataSource(name: "五色百人一首", type: .html, fileName: "html/five_colors"),
        HelpListDataSource(name: "暗記時間タイマー", type: .html, fileName: "html/memorize_timer"),
        HelpListDataSource(name: "「感想戦」のサポート", type: .html, fileName: "html/postmortem")
    ]),
    HelpListSection(name: "その他", dataSources: [
        HelpListDataSource(name: "「いなばくん」について", type: .html, fileName: "html/about_inaba_kun"),
        HelpListDataSource(name: "このアプリを評価する", type: .review, fileName: nil),
        HelpListDataSource(name: "バージョン", type: .value1, fileName: nil, detail: appVersion())
    ])
]

private func appVersion() -> String {
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    return version
}

final class HelpListCoordinator: Coordinator, HandleNavigator {
    var screen: UIViewController?
    var navigationController: UINavigationController
    private var detailHelpScreen: HelpDetailScreen!
    var childCoordinator: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
#if HOKKAI
        helpListSections[0].dataSources.insert(
            HelpListDataSource(
                name: "「下の句かるたモード」とは？",
                type: .html,
                fileName: "html/what_is_hokkaido_mode"),
            at: 5)
#endif
        let screen = HelpListScreen(sections: helpListSections)
        screen.goDetailAction = { [weak self] indexPath in
            self?.goDetailScreen(indexPath: indexPath)
        }
        navigationController.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt
        self.screen = screen
    }

    private func goDetailScreen(indexPath: IndexPath) {
        let dataSource = helpListSections[indexPath.section].dataSources[indexPath.row]
        if let htmlFileName = dataSource.fileName {
            print("html for HELP => \(htmlFileName)")
            let screen = HelpDetailScreen(title: dataSource.name, htmlFileName: htmlFileName)
            navigationController.pushViewController(screen, animated: true)
            screen.navigationItem.prompt = navigationItemPrompt
            self.detailHelpScreen = screen
        } else if dataSource.type == .review {
            showAlertConfirmingGotoReview()
        }
    }

    private func showAlertConfirmingGotoReview() {
        let ac = UIAlertController(title: "このアプリを評価するために、App Storeアプリを立ち上げますか？", message: nil, preferredStyle: .alert)
        let openAction = UIAlertAction(title: "立ち上げる", style: .default) { _ in
            self.openAppStoreReview()
        }
        let cancelAction = UIAlertAction(title: "やめておく", style: .cancel)
        ac.addAction(openAction)
        ac.addAction(cancelAction)
        screen?.present(ac, animated: true)
    }

    private func openAppStoreReview() {
        if let url = URL(string: "https://itunes.apple.com/us/app/itunes-u/id857819404?action=write-review") {
           UIApplication.shared.open(url)
        }
    }
}
