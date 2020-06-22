//
//  HelpListCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class HelpListCoordinator: Coordinator {
    private var screen: HelpListViewController!
    private var navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func start() {
        let screen = HelpListViewController()
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
}
