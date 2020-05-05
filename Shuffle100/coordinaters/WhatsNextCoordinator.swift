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
    private var currentPoem: Poem!
    var refrainEscalatingAction: (() -> Void)?
    var goNextPoemEscalatingAction: (() -> Void)?
    
    init(fromScreen: UIViewController, currentPoem: Poem) {
        self.fromScreen = fromScreen
        self.currentPoem = currentPoem
    }
    
    func start() {
        let screen = WhatsNextViewController(currentPoem: currentPoem)
        self.navigator = UINavigationController(rootViewController: screen)
        setUpNavigationController()
        screen.refrainAction = { [weak self] in
            self?.refrainShimo()
        }
        screen.goNextAction = { [weak self] in
            self?.goNextPoem()
        }
        fromScreen.present(navigator, animated: true)
        self.screen = screen
    }
    
    private func setUpNavigationController() {
        navigator.interactivePopGestureRecognizer?.isEnabled = false
        navigator.navigationBar.barTintColor = StandardColor.barTintColor
        navigator.modalPresentationStyle = .fullScreen
    }
    
    internal func refrainShimo() {
        refrainEscalatingAction?()
    }
    
    internal func goNextPoem() {
        goNextPoemEscalatingAction?()
    }
}
