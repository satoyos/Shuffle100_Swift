//
//  GameEndViiew.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/12/20.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

//protocol HasBackToHomeButton {
//    var exitGameButton: UIButton { get set }
//    
//    
//}
//


class GameEndViiew: UIView {
    let backToHomeButton = UIButton()
    var postMortemButton: UIButton! = nil
    let headerContainer = UIView()
    var headerTitle: String?
    var backToHomeButtonAction: ( ()->Void )?

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
    
    func initView(title: String, postMortemEnabled: Bool = false) {
        self.backgroundColor = backgroundColor()
        self.headerTitle = title
        backToHomeButton.setTitleColor(StandardColor.standardButtonColor, for: .normal)
        self.addSubview(backToHomeButton)
        layoutHeaderContainer()
        if postMortemEnabled {
            self.postMortemButton = UIButton()
        } else {
            layoutBackToHomeButtonCenter()
        }
        backToHomeButton.addTarget(self, action: #selector(backToHomeButtonTapped), for: .touchUpInside)
    }
    
    private func layoutBackToHomeButtonCenter() {
        backToHomeButton.setTitle("トップに戻る", for: .normal)
        backToHomeButton.sizeToFit()
        backToHomeButton.snp.makeConstraints{(make) -> Void in
            make.center.equalTo(self)
        }
    }
    
    private func layoutHeaderContainer() {
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
            $0.textColor = textColor()
        }
        headerContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{(make) -> Void in
            make.center.equalToSuperview()
        }
    }
    
    fileprivate func textColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return .black
        }
    }
    
    @objc func backToHomeButtonTapped() {
//        print("GameEndViewで定義されたdelegateメソッドが呼ばれた！")
        guard let action = backToHomeButtonAction else {
            print("No action is set to this button!")
            return
        }
        action()
    }
}
