//
//  GameEndViiew.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/12/20.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

protocol AllPoemsRecitedView {
    var backToHomeButton: UIButton { get set }
    var headerContainer: UIView { get set }
    var headerTitle: String? { get set }
    var backToHomeButtonAction: ( ()->Void )? { get set }
    
    func fixLayoutOn(baseView: UIView) -> Void
    mutating func initView(title: String) -> Void
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
//        backToHomeButton.addTarget(self, action: #selector(backToHomeButtonTapped), for: .touchUpInside)
        setTargetToButtons()
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
            $0.textColor = UIColor.label
        }
        headerContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{(make) -> Void in
            make.center.equalToSuperview()
        }
    }
}

class GameEndView: UIView, AllPoemsRecitedView {
    var backToHomeButton = UIButton()
//    var postMortemButton: UIButton! = nil
    var headerContainer = UIView()
    var headerTitle: String?
    var backToHomeButtonAction: ( ()->Void )?

//    func fixLayoutOn(baseView: UIView) {
//        self.snp.remakeConstraints{(make) -> Void in
//            make.top.equalTo(baseView.safeAreaInsets.top)
//            make.bottom.equalToSuperview()
//            make.width.equalToSuperview()
//            make.left.equalToSuperview()
//        }
//        baseView.layoutSubviews()
//    }

////    func initView(title: String, postMortemEnabled: Bool = false) {
//    func initView(title: String) {
//        self.backgroundColor = UIColor.systemBackground
//        self.headerTitle = title
//        backToHomeButton.setTitleColor(StandardColor.standardButtonColor, for: .normal)
//        self.addSubview(backToHomeButton)
//        layoutHeaderContainer()
////        if postMortemEnabled {
////            self.postMortemButton = UIButton()
////        } else {
//            layoutBackToHomeButtonCenter()
////        }
//        backToHomeButton.addTarget(self, action: #selector(backToHomeButtonTapped), for: .touchUpInside)
//    }
    
//    private func layoutBackToHomeButtonCenter() {
//        backToHomeButton.setTitle("トップに戻る", for: .normal)
//        backToHomeButton.sizeToFit()
//        backToHomeButton.snp.makeConstraints{(make) -> Void in
//            make.center.equalTo(self)
//        }
//    }
    
//    private func layoutHeaderContainer() {
//        self.addSubview(headerContainer)
//        headerContainer.backgroundColor = StandardColor.barTintColor
//        headerContainer.snp.makeConstraints{(make) -> Void in
//            make.width.equalToSuperview()
//            make.height.equalTo(40)
//            make.top.equalToSuperview()
//            make.left.equalToSuperview()
//        }
//        layoutHeaderTitle()
//    }
    
//    private func layoutHeaderTitle() {
//        let titleLabel = UILabel().then {
//            $0.text = headerTitle
//            $0.textAlignment = .center
//            $0.sizeToFit()
//            $0.backgroundColor = .clear
//            $0.textColor = UIColor.label
//        }
//        headerContainer.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints{(make) -> Void in
//            make.center.equalToSuperview()
//        }
//    }
    
    internal func setTargetToButtons() {
        backToHomeButton.addTarget(self, action: #selector(backToHomeButtonTapped), for: .touchUpInside)
    }
    
    @objc func backToHomeButtonTapped() {
//        print("GameEndViewで定義されたdelegateメソッドが呼ばれた！")
//        guard let action = backToHomeButtonAction else {
//            print("No action is set to this button!")
//            return
//        }
//        action()
        backToHomeButtonAction?()
    }
}
