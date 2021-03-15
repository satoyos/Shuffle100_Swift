//
//  WhatsNextScreen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

private let navBarButtonSize: CGFloat = 32

final class WhatsNextScreen: Screen {
    var torifudaButton = LargeImageAttachedButton()
    var refrainButton = LargeImageAttachedButton()
    var goNextButton = LargeImageAttachedButton()
    var gearButton: UIBarButtonItem!
    var exitButton: UIBarButtonItem!
    let sizes = SizeFactory.createSizeByDevice()
    var currentPoem: Poem!
    var showTorifudaAction: (() -> Void)?
    var refrainAction: (() -> Void)?
    var goNextAction: (() -> Void)?
    var backToHomeScreenAction: (() -> Void)?
    var goSettingAction: (() -> Void)?

    init(currentPoem: Poem) {
        self.currentPoem = currentPoem
        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    // 新しく init を定義した場合に必須
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 自動的にスリープに入るのを防ぐ
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // スリープを有効に戻す
        UIApplication.shared.isIdleTimerDisabled = false
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
