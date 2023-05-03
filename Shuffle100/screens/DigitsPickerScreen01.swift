//
//  DigitsPickerScreen01ViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/03.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

final class DigitsPickerScreen01: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarSetUp()
    }
    
    private func navigationBarSetUp() {
        self.title = "1の位の数で選ぶ"
//        navigationItem.rightBarButtonItems = [
//            selectedNumBadgeItem
//        ]
    }

}
