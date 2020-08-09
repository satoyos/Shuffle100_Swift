//
//  MemorizeTimerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class MemorizeTimerCoordinator: Coordinator {
    var screen: UIViewController?
    var navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let screen = MemorizeTimerViewController()
        navigator.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }
    
    
}

