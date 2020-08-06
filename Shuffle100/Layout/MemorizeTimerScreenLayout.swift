//
//  MemorizeTimerScreenLayout.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit
import Then

extension MemorizeTimerViewController {
    internal func layoutScreen() {
        configureTimerContainer()
    }
    
    private func configureTimerContainer() {
        _ = timerContaier.then {
            $0.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: sizeByDevice.memorizeTimerLabelPointSize())
            $0.backgroundColor = .red
            $0.snp.makeConstraints { (make) -> Void in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.center.y)
            }
        }
    }
}
