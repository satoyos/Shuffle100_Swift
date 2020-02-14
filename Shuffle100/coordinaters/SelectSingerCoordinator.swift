//
//  SelectSingerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class SelectSingerCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var settings: Settings
    private var screen: UIViewController?
        
    init(navigator: UINavigationController, settings: Settings) {
        self.navigator = navigator
        self.settings = settings
    }
        
    func start() {
        let screen = SelectSingerViewController(settings: settings)
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
}
