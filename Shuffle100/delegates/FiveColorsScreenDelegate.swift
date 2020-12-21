//
//  FiveColorsScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/10/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension FiveColorsScreen {
    @objc func colorButtonTapped(_ colorButton: ColorOfFiveButton) {
        guard let colorDic = colorsDic[colorButton.color] else { return }
        let ac = UIAlertController(
            title: "\(colorDic.name)色の20首をどうしますか？",
            message: nil,
            preferredStyle: .actionSheet)
        let selectJust20Action = UIAlertAction(title: "この20首だけを選ぶ", style: .default) { _ in
            self.selectJust20Of(color: colorDic.type)
        }
        let add20Action = UIAlertAction(title: "今選んでいる札に加える", style: .default) { _ in
            self.add20of(color: colorDic.type)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        ac.addAction(selectJust20Action)
        ac.addAction(add20Action)
        ac.addAction(cancelAction)
        if let pc = ac.popoverPresentationController {
            pc.sourceView = self.view
            pc.sourceRect = colorButton.frame
        }
        present(ac, animated: true)
    }
    
    func selectJust20Of(color: FiveColors) {
        guard let colorDic = colorsDic[color] else { return }
        var newState100 = SelectedState100()
        newState100.cancelAll()
        newState100.selectInNumbers(colorDic.poemNumbers)
        settings.state100 = newState100
        refreshImageOnButtons()
        updateBadgeItem()
    }
    
    func add20of(color: FiveColors) {
        guard let colorDic = colorsDic[color] else { return }
        settings.state100.selectInNumbers(colorDic.poemNumbers)
        refreshImageOnButtons()
        updateBadgeItem()
    }
}
