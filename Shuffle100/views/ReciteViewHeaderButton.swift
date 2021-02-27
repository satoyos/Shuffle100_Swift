//
//  ReciteViewHeaderButton.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class ReciteViewHeaderButton: UIButton {

    var tappedAction:  ( ()->Void )?
    
    func setAction(action: @escaping () -> Void) {
        tappedAction = action
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    @objc func tapped(btn: UIButton) {
        guard let action = tappedAction else {
            print("No action is set to this button!")
            return
        }
        action()
    }
}
