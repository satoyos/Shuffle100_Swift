//
//  Screen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/12/19.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class Screen: UIViewController {
    var viewDidAppearAction: (() -> Void)?

    override func viewDidAppear(_ animated: Bool) {
        self.viewDidAppearAction?()
        super.viewDidAppear(animated)
    }
}
