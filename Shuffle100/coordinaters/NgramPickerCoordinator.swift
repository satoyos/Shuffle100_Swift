//
//  NgramPickerCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class NgramPickerCoordinator: Coordinator {
    var screen: UIViewController?
    private var settings: Settings
    private var store: StoreManager
    private var navigator: UINavigationController
    
    init(navigator: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }
    
    func start() {
        let screen = NgramPickerViewController(settings: settings)
        navigator.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }
}
