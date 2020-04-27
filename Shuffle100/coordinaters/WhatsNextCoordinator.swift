//
//  WhatsNextCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class WhatsNextCoordinator: Coordinator {
    private var screen: WhatsNextViewController!
    private var fromScreen: UIViewController
    private var navigator: UINavigationController!
    
    init(fromScreen: UIViewController) {
        self.fromScreen = fromScreen
    }
    
    func start() {
        let screen = WhatsNextViewController()
        self.navigator = UINavigationController(rootViewController: screen)
        setUpNavigationController()
        fromScreen.present(navigator, animated: true)
        self.screen = screen
    }
    
    private func setUpNavigationController() {
        navigator.interactivePopGestureRecognizer?.isEnabled = false
        navigator.navigationBar.barTintColor = StandardColor.barTintColor
        navigator.modalPresentationStyle = .fullScreen
    }
}
