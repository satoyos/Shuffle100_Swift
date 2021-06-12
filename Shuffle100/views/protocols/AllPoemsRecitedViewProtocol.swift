//
//  AllPoemsRecitedViewProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/03/02.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import UIKit

protocol AllPoemsRecitedView {
    var backToHomeButton: UIButton { get set }
    var headerContainer: UIView { get set }
    var headerTitle: String? { get set }
    var backToHomeButtonAction: ( ()->Void )? { get set }
    
    func fixLayoutOn(baseView: UIView) -> Void
    mutating func initView(title: String) -> Void
    func layoutHeaderContainer()
    func setTargetToButtons() -> Void
    func backToHomeButtonTapped() -> Void
}

extension AllPoemsRecitedView where Self: UIView {
    func fixLayoutOn(baseView: UIView) {
        self.snp.remakeConstraints{(make) -> Void in
            make.top.equalTo(baseView.safeAreaInsets.top)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.left.equalToSuperview()
        }
        baseView.layoutSubviews()
    }
    
    mutating func initView(title: String) {
        self.backgroundColor = UIColor.systemBackground
        self.headerTitle = title
        backToHomeButton.setTitleColor(StandardColor.standardButtonColor, for: .normal)
        self.addSubview(backToHomeButton)
        layoutHeaderContainer()
        layoutBackToHomeButtonCenter()
        setTargetToButtons()
    }
    
    private func layoutBackToHomeButtonCenter() {
        backToHomeButton.setTitle("トップに戻る", for: .normal)
        backToHomeButton.sizeToFit()
        backToHomeButton.snp.makeConstraints{(make) -> Void in
            make.center.equalTo(self)
        }
    }
    
    func layoutHeaderContainer() {
        self.addSubview(headerContainer)
        headerContainer.backgroundColor = StandardColor.barTintColor
        headerContainer.snp.makeConstraints{(make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        layoutHeaderTitle()
    }
    
    private func layoutHeaderTitle() {
        let titleLabel = UILabel().then {
            $0.text = headerTitle
            $0.textAlignment = .center
            $0.sizeToFit()
            $0.backgroundColor = .clear
            $0.textColor = UIColor.label
        }
        headerContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{(make) -> Void in
            make.center.equalToSuperview()
        }
    }
}
