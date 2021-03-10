//
//  ExitGameProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

protocol ExitGameProtocol {
    func confirmExittingGame(onScreen: UIViewController?) -> Void
//    func exitGame() -> Void
}

extension ExitGameProtocol {
    func confirmExittingGame(onScreen: UIViewController?) {
        guard  let screen = onScreen as? RecitePoemScreen else { return }
        let ac = UIAlertController(title: "試合を終了しますか？", message: nil, preferredStyle: .alert)
        let quit = UIAlertAction(title: "終了する", style: .cancel) { action in
            screen.backToHomeScreenAction?()
        }
        ac.addAction(quit)
        let cancel = UIAlertAction(title: "続ける", style: .default, handler: nil)
        ac.addAction(cancel)
        screen.present(ac, animated: true)
    }
}
