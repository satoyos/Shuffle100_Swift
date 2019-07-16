//
//  RecitePoemScreenDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/15.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

extension RecitePoemViewController {
    internal func exitButtonTapped() {
        let ac = UIAlertController(title: "試合を終了しますか？", message: nil, preferredStyle: .alert)
        let quit = UIAlertAction(title: "終了する", style: .cancel) {[weak self] action in
            _ = self?.navigationController?.popViewController(animated: true)
        }
        ac.addAction(quit)
        let cancel = UIAlertAction(title: "続ける", style: .default, handler: nil)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
}
