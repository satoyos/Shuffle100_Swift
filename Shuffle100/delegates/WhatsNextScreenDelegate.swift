//
//  WhatsNextScreenDelegate.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/04/30.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit

extension WhatsNextViewController {

    @objc func gearButtonTapped() {
        print("歯車ボタンが押された！")
    }
    
    @objc func exitButtonTapped() {
        print("Exitボタンが押された！")
    }
    
    @objc func torifudaButtonTapped() {
        print("取り札ボタンが押された！")
        let screen = FudaViewController(shimoString: "はなそむかしのかににおひける", title: "35. 人はいさ 心もしらず")
        let nav = UINavigationController(rootViewController: screen)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.barTintColor = StandardColor.barTintColor
        present(nav, animated: true)
    }
    
    @objc func refrainButtonTapped() {
        print("読み直しボタンが押された！")
    }
    
    @objc func goNextButtonTapped() {
        print("次の歌に進むボタンが押された！")
    }
}
