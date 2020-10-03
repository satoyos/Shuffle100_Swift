//
//  FiveColorsScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/10/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension FiveColorsViewController {
    @objc func colorButtonTapped(_ colorButton: ColorOfFiveButton) {
        selectJust20Of(color: colorButton.color)
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
