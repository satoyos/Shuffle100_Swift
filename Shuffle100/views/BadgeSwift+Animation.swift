//
//  BadgeSwift+Animation.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/10/10.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import UIKit

fileprivate let duration = 0.1
fileprivate let scale = 1.25

extension BadgeSwift {
    func setTextWithAnimation(_ text: String) {
        self.text = text
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        UIView.animate(withDuration: duration, animations: {
                self.transform = transform
            }) { _ in
                self.identity()
            }
    }
    
    private func identity() {
        UIView.animate(withDuration: duration) {
            self.transform = .identity
        }
    }
}
