//
//  IntervalSettingCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class IntervalSettingCoordinator: Coordinator {
    var settings: Settings
    var navigator: UINavigationController
    
    init(navigator: UINavigationController, settings: Settings) {
        self.navigator = navigator
        self.settings = settings
    }
        
    func start() {
        let screen = IntervalSettingViewController(settings: settings)
        navigator.pushViewController(screen, animated: true)
    }
}
