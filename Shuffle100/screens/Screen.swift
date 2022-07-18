//
//  Screen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/12/19.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

typealias InjectedAction = () -> Void

class Screen: UIViewController {
    var viewDidAppearAction: InjectedAction?

    override func viewDidAppear(_ animated: Bool) {
        self.viewDidAppearAction?()
        super.viewDidAppear(animated)
    }
}
