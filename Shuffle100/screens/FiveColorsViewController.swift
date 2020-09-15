//
//  FiveColorsViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/09/10.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class FiveColorsViewController: SettingsAttachedViewController {
    let blueButton = WhatsNextButton()
    let yellowButton = WhatsNextButton()
    let greenButton = WhatsNextButton()
    let pinkButton = WhatsNextButton()
    let orangeButton = WhatsNextButton()
    internal let sizes = SizeFactory.createSizeByDevice()
    let colorsDic = FiveColorsDataHolder.sharedDic

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "五色百人一首"
        view.backgroundColor = StandardColor.backgroundColor
        addColorButtonsAsSubviews()
        layoutButtons()
    }
    
    private func addColorButtonsAsSubviews() {
        view.addSubview(blueButton)
        view.addSubview(yellowButton)
        view.addSubview(greenButton)
        view.addSubview(pinkButton)
        view.addSubview(orangeButton)
    }

}
