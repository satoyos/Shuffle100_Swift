//
//  WhatsNextViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class WhatsNextViewController: UIViewController {
    var torifudaButton = WhatsNextButton()
    var refrainButton = WhatsNextButton()
    var goNextButton = WhatsNextButton()
    let sizes = SizeFactory.createSizeByDevice()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = StandardColor.backgroundColor
        self.title = "次はどうする？"
        view.addSubview(torifudaButton)
        view.addSubview(refrainButton)
        view.addSubview(goNextButton)
        layoutButtons()
    }
    
}
