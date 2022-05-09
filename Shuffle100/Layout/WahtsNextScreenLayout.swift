//
//  WahtsNextScreenLayout.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/29.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit
import Then

extension WhatsNextScreen {
    internal func layoutButtons() {
        layoutRefrainButton()
        layoutTorifudaButton()
        layoutGoNextButton()
    }
    
    private func layoutRefrainButton() {
        _ = refrainButton.then {
            setCommonLayout(button: $0)
            $0.initWithImage(filename: "refrain.png")
            $0.setTitle("下の句をもう一度読む", for: .normal)
            // center => [50%, 50%]
            $0.center.y = view.center.y
        }
    }
    
    private func layoutTorifudaButton() {
        _ = torifudaButton.then {
            setCommonLayout(button: $0)
            $0.initWithImage(filename: "torifuda.png")
            $0.setTitle("取り札を見る", for: .normal)
            // center => [50%, 30%]
            $0.center.y = viewHeight() * 0.3
        }
    }
    
    private func layoutGoNextButton() {
        _ = goNextButton.then {
            setCommonLayout(button: $0)
            $0.initWithImage(filename: "go_next.png")
            $0.setTitle("次の歌へ！", for: .normal)
            // center => [50%, 70%]
            $0.center.y = viewHeight() * 0.7
        }
    }
    
    private func setCommonLayout(button: LargeImageAttachedButton) {
        _ = button.then {
            $0.frame.size = buttonSize()
            $0.center.x = view.center.x
            $0.setStandardTitleColor()
        }
    }
    
    private func buttonSize() -> CGSize {
        CGSize(width: viewWidth() * 0.8, height: sizes.whatsNextButtonHeight)
    }
    
    private func viewWidth() -> CGFloat {
        return view.frame.size.width
    }
    
    private func viewHeight() -> CGFloat {
        return view.frame.size.height
    }
    
    private func retinaSclae() -> CGFloat {
        return UIScreen.main.scale
    }

}

