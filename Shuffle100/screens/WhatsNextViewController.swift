//
//  WhatsNextViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

private let navBarButtonSize: CGFloat = 32

class WhatsNextViewController: UIViewController {
    var torifudaButton = WhatsNextButton()
    var refrainButton = WhatsNextButton()
    var goNextButton = WhatsNextButton()
    var gearButton: UIBarButtonItem!
    var exitButton: UIBarButtonItem!
    let sizes = SizeFactory.createSizeByDevice()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = StandardColor.backgroundColor
        self.title = "次はどうする？"
        view.addSubview(torifudaButton)
        view.addSubview(refrainButton)
        view.addSubview(goNextButton)
        setNavBarButtons()
        layoutButtons()
        setAccessibilityLabelToButtons()
        setButtonActions()
    }
    
    private func setNavBarButtons() {
        let size = CGSize(width: navBarButtonSize, height: navBarButtonSize)
        setGearButton(with: size)
        setExitButton(with: size)
    }
    
    private func setGearButton(with size: CGSize) {
        let gearButton = UIBarButtonItem(
            image: UIImage(named: "gear-520.png")?.reSizeImage(reSize: size),
            style: UIBarButtonItem.Style.plain, target: self, action: #selector(gearButtonTapped))
        
        self.navigationItem.leftBarButtonItem = gearButton
        self.gearButton = gearButton
    }
    
    private func setExitButton(with size: CGSize) {
        let exitButton = UIBarButtonItem(
            image: UIImage(named: "exit_square.png")?.reSizeImage(reSize: size),
            style: UIBarButtonItem.Style.plain, target: self, action: #selector(exitButtonTapped))
        
        self.navigationItem.rightBarButtonItem = exitButton
        self.exitButton = exitButton
    }
    
    private func setAccessibilityLabelToButtons() {
        torifudaButton.accessibilityLabel = "torifuda"
        refrainButton.accessibilityLabel = "refrain"
        goNextButton.accessibilityLabel = "goNext"
        gearButton.accessibilityLabel = "gear"
        exitButton.accessibilityLabel = "exit"
    }
    
    private func setButtonActions() {
        torifudaButton.addTarget(self, action: #selector(torifudaButtonTapped), for: .touchUpInside)
        refrainButton.addTarget(self, action: #selector(refrainButtonTapped), for: .touchUpInside)
        goNextButton.addTarget(self, action: #selector(goNextButtonTapped), for: .touchUpInside)
    }
    
}
