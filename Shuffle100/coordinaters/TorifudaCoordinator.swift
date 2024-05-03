//
//  TorifudaCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/11/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

final class TorifudaCoordinator: Coordinator, HandleNavigator {
    var screen: UIViewController?
    var navigationController: UINavigationController
    private var poem: Poem
    var childCoordinator: Coordinator?

    init(navigationController: UINavigationController, poem: Poem) {
        self.navigationController = navigationController
        self.poem = poem
    }

    func start() {
        var title = "\(poem.number)."
        for partStr in poem.liner {
            title += " \(partStr)"
        }
        let trialTorifudaView = 
        TrialTorifudaView(
            shimoStr: poem.in_hiragana.shimo,
            fullLiner: poem.liner
        ).environmentObject(ScreenSizeStore())
        let hostintController = UIHostingController(rootView: trialTorifudaView).then {
            $0.navigationItem.prompt = navigationItemPrompt
            $0.title = title
        }
        navigationController.pushViewController(hostintController, animated: true)
        
//        let screen = TorifudaScreen(shimoString: shimoStr, title: title, fullLiner: poem.liner)
//        navigationController.pushViewController(screen, animated: true)
//        screen.navigationItem.prompt = navigationItemPrompt
//        self.screen = screen
    }
}
