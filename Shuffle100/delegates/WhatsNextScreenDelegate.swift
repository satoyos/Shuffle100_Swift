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
        assert(true,"取り札ボタンが押された！")
        let shimoStr = currentPoem.in_hiragana.shimo
        var title = "\(currentPoem.number)."
        for partStr in currentPoem.liner {
            title += " \(partStr)"
        }
        let screen = FudaViewController(shimoString: shimoStr, title: title)
        let nav = UINavigationController(rootViewController: screen)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.barTintColor = StandardColor.barTintColor
        present(nav, animated: true)
    }
    
    @objc func refrainButtonTapped() {
        assert(true, "読み直しボタンが押された！")
        dismiss(animated: true)
        refrainAction?()
    }
    
    @objc func goNextButtonTapped() {
        print("次の歌に進むボタンが押された！")
    }
}
