//
//  ReciteSettingsCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/02.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class ReciteSettingsCoordinator: Coordinator {
    private var settings: Settings
    private var store: StoreManager
    private var navigator: UINavigationController!
    private var fromScreen: UIViewController
    internal var screen: UIViewController?

    init(settings: Settings, fromScreen: UIViewController, store: StoreManager = StoreManager()) {
        self.settings = settings
        self.fromScreen = fromScreen
        self.store = store
    }
    
    func start() {
//        print("歯車ボタンが押された！")
        let screen = ReciteSettingsViewController(settings: settings)
        self.navigator = UINavigationController(rootViewController: screen)
        setUpNavigationController()
        screen.intervalSettingAction = { [weak self] in
            self?.openIntervalSettingScreen()
        }
        screen.kamiShimoIntervalSettingAction = { [weak self] in
            self?.openKamiShimoIntervalSettingScreen()
        }
        screen.volumeSettingAction = { [weak self] in
            self?.openVolumeSettingScreen()
        }
        
        fromScreen.present(navigator, animated: true)
        self.screen = screen
    }
    
    private func setUpNavigationController() {
        navigator.interactivePopGestureRecognizer?.isEnabled = false
        navigator.navigationBar.barTintColor = StandardColor.barTintColor
//
// 次の modalPresentationStyle の値は、本来はデフォルト値のまま .automaticにしたい
// デフォルトでは、アプリ画面のスクリーンよりも小さなViewControllerがPopする
// しかし、2020/03/14の時点では、 ReciteSettingsScreenから呼び出す
// IntervalSettingScreenのViewレイアウトを設定する際に、
// そのViewControllerのviewの幅をプログラムから取得した時点でお問題が起きる。
// `view.frame.size.width`によって取得してみると、実際のサイズ (700台)ではなく
// HomeScrennの幅(1024)が取得できてしまう。(iPad Pro 3rd genの場合)
// これでは、Subviewに適切なサイズを割り当てることができない。
// そのため、モダンなmodal表示を諦め、フルスクリーンのmodal表示を採用する。
// 「なぜか`view.frame.size.width`が違う幅の値になってしまう」問題が
// 解決したら、ぜひモダンなデフォルト表示にしたい。
//
        navigator.modalPresentationStyle = .fullScreen
    }
    
    private func openIntervalSettingScreen() {
        assert(true, "これから、歌の間隔を調整する画面を開きます")
        let coordinator = IntervalSettingCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()        
    }
    
    private func openKamiShimoIntervalSettingScreen() {
        assert(true, "これから、上の句と下の句の間隔を調整する画面を開きます")
        let coordinator = KamiShimoIntervalSettingCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
    }
    
    private func openVolumeSettingScreen() {
        assert(true, "これから、音量をちょうせうする画面を開きます")
        let coordinator = VolumeSettingCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
    }
}
