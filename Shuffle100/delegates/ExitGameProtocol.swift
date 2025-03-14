//
//  ExitGameProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

protocol ExitGameProtocol {
  var backToHomeScreenAction: (() -> Void)? { get set }
  
  func confirmExittingGame() -> Void
}

extension ExitGameProtocol where Self: UIViewController {
  func confirmExittingGame() {
    let ac = UIAlertController(title: "試合を終了しますか？", message: nil, preferredStyle: .alert)
    let quit = UIAlertAction(title: "終了する", style: .cancel) { action in
      self.backToHomeScreenAction?()
    }
    ac.addAction(quit)
    let cancel = UIAlertAction(title: "続ける", style: .default, handler: nil)
    ac.addAction(cancel)
    present(ac, animated: true)
  }
}
