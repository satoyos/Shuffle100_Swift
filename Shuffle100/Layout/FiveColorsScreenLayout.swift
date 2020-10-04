//
//  FiveColorsScreenLayout.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/09/12.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
// import SnapKit
import Then

//CENTER_Y_POSITIONS = {
//    blue:   '20%',
//    pink:   '35%',
//    yellow: '50%',
//    orange: '65%',
//    green:  '80%'
//}


extension FiveColorsViewController: SHViewSizeGetter {
    
    internal func layoutButtons() {
        layoutButton(blueButton,   centerYRatio: 0.20)
        layoutButton(pinkButton,   centerYRatio: 0.35)
        layoutButton(yellowButton, centerYRatio: 0.50)
        layoutButton(orangeButton, centerYRatio: 0.65)
        layoutButton(greenButton,  centerYRatio: 0.80)
    }
    
    internal func refreshImageOnButtons() {
        allColorButtons.forEach { button in
            button.setImageOf(filename: imageFilePathFor(color: button.color))
        }
    }
    
    private func layoutButton(_ colorButton: ColorOfFiveButton, centerYRatio: CGFloat) {
        guard let colorDic = colorsDic[colorButton.color] else { return }
        let filePath = imageFilePathFor(color: colorButton.color)
        _ = colorButton.then {
            setCommonLayout(button: $0)
            $0.initWithImage(filename: filePath)
            $0.setTitle(colorDic.name, for: .normal)
            // center => [50%, centerYRatio]
            $0.center.y = viewHeight() * centerYRatio
        }
    }
    
    private func setCommonLayout(button: ColorOfFiveButton) {
        _ = button.then {
            $0.frame.size = buttonSize()
            $0.center.x = view.center.x
            $0.setStandardTitleColor()
        }
    }

    private func buttonSize() -> CGSize {
        return CGSize(width: viewWidth() * 0.8, height: sizes.whatsNextButtonHeight())
    }

}
