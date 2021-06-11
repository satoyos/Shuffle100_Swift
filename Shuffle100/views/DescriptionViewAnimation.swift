//
//  DescriptionViewAnimation.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/06/11.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import UIKit

fileprivate let goldenRetio = 1.6180
fileprivate let fadeInDuration = 2.0
fileprivate let fadeOutDuration = fadeInDuration * goldenRetio

protocol DescriptionViewAnimation {
    func fadeInFadeOut()
}

extension DescriptionViewAnimation where Self: UILabel {
    func fadeInFadeOut() {
        self.alpha = 0.0
        UIView.animate(withDuration: fadeInDuration, animations: {
            self.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: fadeOutDuration, animations: {
                self.alpha = 0.0
            })
        })
    }
}
