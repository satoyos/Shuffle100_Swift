//
//  TorifudaCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/11/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class TorifudaCoordinator: Coordinator {
    var screen: UIViewController?
    private var navigator: UINavigationController
    private var poem: Poem
    var childCoordinators = [Coordinator]()

    init(navigator: UINavigationController, poem: Poem) {
        self.navigator = navigator
        self.poem = poem
    }

    func start() {
        let shimoStr = poem.in_hiragana.shimo
        var title = "\(poem.number)."
        for partStr in poem.liner {
            title += " \(partStr)"
        }
        let screen = FudaViewController(shimoString: shimoStr, title: title, fullLiner: poem.liner)
        navigator.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }
}
