//
//  VolumeSettingCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/19.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class VolumeSettingCoordinator: Coordinator, SaveSettings {
    internal var settings: Settings
    internal var store: StoreManager
    var screen: UIViewController?
    var navigationController: UINavigationController
    var childCoordinator: Coordinator?

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
    }

    func start() {
//        let screen = VolumeSettingScreen(settings: settings)
//        screen.saveSettingsAction = { [store, settings, weak self] in
//            self?.saveSettingsPermanently(settings, into: store)
//        }
        let volumeSettingView = VolumeSetting(settings: settings)
        let hostController = ActionAttachedHostingController(rootView: volumeSettingView
            .environmentObject(ScreenSizeStore()))
        hostController.actionForViewWillDissappear = {
            [volumeSettingView,weak self] in
            volumeSettingView.tasksForLeavingThisView()
            if let settings = self?.settings, let store = self?.store {
                self?.saveSettingsPermanently(settings, into: store)
            }
        }
        hostController.title = "音量の調整"
        navigationController.pushViewController(hostController, animated: true)
        self.screen = hostController
    }
}
