//
//  VolumeSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/18.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class VolumeSettingViewController: SettingsAttachedViewController {
    var slider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "音量の調整"
    }

}
