//
//  PostMortemEnabledGameEndView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/03/02.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import UIKit

final class PostMortemEnabledGameEndView: UIView, AllPoemsRecitedView {
    var backToHomeButton = UIButton()
    var postMortemButton = UIButton()
    var headerContainer = UIView()
    var headerTitle: String?
    var backToHomeButtonAction: (() -> Void)?
    var gotoPostMortemAction: (() -> Void)?
    
    func initView(title: String) {
        self.backgroundColor = UIColor.systemBackground
        self.headerTitle = title
        backToHomeButton.setTitleColor(StandardColor.standardButtonColor, for: .normal)
        postMortemButton.setTitleColor(StandardColor.standardButtonColor, for: .normal)
        self.addSubview(backToHomeButton)
        self.addSubview(postMortemButton)
        layoutHeaderContainer()
//        layoutBackToHomeButtonCenter()
        layoutButtons()
        setTargetToButtons()
    }
    
    func setTargetToButtons() {
        backToHomeButton.addTarget(self, action: #selector(backToHomeButtonTapped), for: .touchUpInside)
        postMortemButton.addTarget(self, action: #selector(postMortemButtonTapped), for: .touchUpInside)
    }
    
    private func layoutButtons() {
        backToHomeButton.setTitle("トップに戻る", for: .normal)
        backToHomeButton.sizeToFit()
        let margin = backToHomeButton.frame.height * 2
        backToHomeButton.snp.makeConstraints{(make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-1 * margin)
        }
        postMortemButton.setTitle("感想戦を始める", for: .normal)
        postMortemButton.sizeToFit()
        postMortemButton.snp.makeConstraints{(make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(margin)
        }
    }
    
    @objc func backToHomeButtonTapped() {
        backToHomeButtonAction?()
    }
    
    @objc func postMortemButtonTapped() {
        gotoPostMortemAction?()
    }
    

}
