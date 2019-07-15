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
        present(ac, animated: true)
    }
}
