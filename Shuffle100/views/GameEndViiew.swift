//
//  GameEndViiew.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/12/20.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

class GameEndViiew: UIView {
    let backToHomeButton = UIButton()

    func fixLayoutOn(baseView: UIView) {
        self.snp.remakeConstraints{(make) -> Void in
            make.top.equalTo(baseView.safeAreaInsets.top)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.left.equalToSuperview()
        }
        baseView.layoutSubviews()
    }

    private func backgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return .white
        }
    }
    
    func initView(title: String) {
        self.backgroundColor = backgroundColor()
        self.addSubview(backToHomeButton)
        layoutBackToHomeButton()
    }
    
    private func layoutBackToHomeButton() {
        backToHomeButton.setTitle("トップに戻る", for: .normal)
        backToHomeButton.sizeToFit()
        backToHomeButton.snp.makeConstraints{(make) -> Void in
            make.center.equalTo(self)
        }
    }
}
