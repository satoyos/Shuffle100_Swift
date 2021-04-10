//
//  RecitePoemView-HeaderPart.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import SnapKit
import Then

private let headerButtonSize = CGSize(width: 32, height: 32)
private let headerButtonMargin = 10

extension RecitePoemView {
    internal func layoutHeaderContainer() {
        self.addSubview(headerContainer)
        headerContainer.backgroundColor = StandardColor.barTintColor
        headerContainer.snp.makeConstraints{(make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        layoutHeaderTitle()
        layoutSettingButton()
        layoutExitButton()
    }
    
    private func textColor() -> UIColor {
        return UIColor.label
    }
    
    private func layoutHeaderTitle() {
        let titleLabel = UILabel().then {
            $0.text = headerTitle
            $0.textAlignment = .center
            $0.sizeToFit()
            $0.backgroundColor = .clear
            $0.textColor = textColor()
            $0.accessibilityIdentifier = "screenTitle"
        }
        headerContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{(make) -> Void in
            make.center.equalToSuperview()
        }
    }
    
    private func layoutSettingButton() {
        gearButton = ReciteViewHeaderButton(type: .custom).then {
            let image = UIImage(named: "gear-520.png")!.reSizeImage(reSize: headerButtonSize)
            $0.setImageWithStarndardColor(image)
            $0.accessibilityLabel = "gear"
            $0.setAction {
                print("歯車ボタンに設定されたアクションを実行します。")
            }
        }
        headerContainer.addSubview(gearButton)
        gearButton.snp.makeConstraints{(make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(headerButtonMargin)
        }
    }
    
    private func layoutExitButton() {
        exitButton = ReciteViewHeaderButton(type: .custom).then {
            let image = UIImage(named: "exit_square.png")!.reSizeImage(reSize: headerButtonSize)
            $0.setImageWithStarndardColor(image)
            $0.accessibilityLabel = "exit"
            $0.setAction {
                print("脱出ボタンのアクションです")
            }
        }
        headerContainer.addSubview(exitButton)
        exitButton.snp.makeConstraints{(make) -> Void in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-1 * headerButtonMargin)
        }
    }
}
