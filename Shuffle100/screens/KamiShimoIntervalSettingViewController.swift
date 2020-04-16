//
//  KamiShimoIntervalSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class KamiShimoIntervalSettingViewController: TimeSettingViewController {

    override func viewDidLoad() {
        self.initialTime = settings.kamiShimoInterval
        self.title = "上の句と下の句の間隔"
        super.viewDidLoad()
    }
    
}
