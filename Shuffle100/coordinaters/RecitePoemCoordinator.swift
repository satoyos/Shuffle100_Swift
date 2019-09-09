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
        
        // 序歌の読み上げは画面遷移が完了したタイミングで開始したいので、
        // CATransanctionを使って、遷移アニメーション完了コールバックを使う。
        CATransaction.begin()
        navigator.pushViewController(screen, animated: true)
        CATransaction.setCompletionBlock {
            screen.playJoka()
        }
        CATransaction.commit()
        self.screen = screen
    }
}
