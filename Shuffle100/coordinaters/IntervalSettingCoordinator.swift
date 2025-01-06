//
//  IntervalSettingCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

final class IntervalSettingCoordinator: Coordinator, SaveSettings {
    internal var settings: Settings
    internal var store: StoreManager
    var childCoordinator: Coordinator?

    internal var screen: UIViewController?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
    }

    func start() {
        let durationSettingView = InterPoemDurationSetting(
            durationType: .twoPoems, startTime: Double(settings.interval),
            settings: settings)
        let hostController = ActionAttachedHostingController(rootView: durationSettingView
            .environmentObject(ScreenSizeStore()))
        hostController.actionForViewWillDissappear = { [durationSettingView] in
            durationSettingView.reflectSliderValueToSettings()
        }
        hostController.title = "歌の間隔の調整"
        navigationController.pushViewController(hostController, animated: true)
        self.screen = hostController

    }
}
