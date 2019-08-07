//
//  RecitePoemCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/07.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class RecitePoemCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var settings: Settings
    private var screen: UIViewController?
    
    init(navigator: UINavigationController, settings: Settings) {
        self.navigator = navigator
        self.settings = settings
    }
    
    func start() {
        let screen = RecitePoemViewController(settings: settings)
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
}
