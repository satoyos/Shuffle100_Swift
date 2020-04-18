//
//  VolumeSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/18.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit
import Then

let minVolume: Float = 0.0
let maxVolume: Float = 1.0

class VolumeSettingViewController: SettingsAttachedViewController {
    
    internal let sizeByDevice = SizeFactory.createSizeByDevice()
    var slider = UISlider()
    var tryButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "音量の調整"
        view.addSubview(slider)
        view.addSubview(tryButton)
        layoutScreen()
        setActions()
    }

    private func setActions() {
        
    }
    
}
