//
//  FiveColorsViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/09/10.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem

class FiveColorsViewController: SettingsAttachedViewController {
    let blueButton = ColorOfFiveButton(.blue)
    let yellowButton = ColorOfFiveButton(.yellow)
    let greenButton = ColorOfFiveButton(.green)
    let pinkButton = ColorOfFiveButton(.pink)
    let orangeButton = ColorOfFiveButton(.orange)
    internal let sizes = SizeFactory.createSizeByDevice()
    let colorsDic = FiveColorsDataHolder.sharedDic
    var badgeItem: BBBadgeBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "五色百人一首"
        view.backgroundColor = StandardColor.backgroundColor
        addColorButtonsAsSubviews()
        layoutButtons()
        self.badgeItem = dummyButtonItem()
        updateBadgeItem()
        navigationItem.rightBarButtonItem = badgeItem
    }
    
    // this method is not private for testability
    func imageFilePathFor(color: FiveColors) -> String {
        guard let colorDIc = colorsDic[color] else {
            assert(false, "No dic for color \(color)")
            return ""
        }
        let referenceSet = Set(colorDIc.poemNumbers)
        let selectedSet = Set(allSelectedNumbers)
        let resultStatus = comparePoemNumbers(selected: selectedSet, reference: referenceSet)
        var path = ""
        switch resultStatus {
        case .full:
            path = "5colors/full/\(colorDIc.file)"
        case .partial:
            path = "5colors/partial/\(colorDIc.file)"
        case .empry:
            path = "5colors/gray.png"
        }
        return path
    }

    internal func updateBadgeItem() {
        badgeItem.badgeValue = "\(selectedNum)首"
    }
    
    private func addColorButtonsAsSubviews() {
        view.addSubview(blueButton)
        view.addSubview(yellowButton)
        view.addSubview(greenButton)
        view.addSubview(pinkButton)
        view.addSubview(orangeButton)
    }
    
    private func dummyButtonItem() -> BBBadgeBarButtonItem {
        let button = UIButton(type: .custom).then {
            $0.setTitle(" ", for: .normal)
        }
        let buttonItem = BBBadgeBarButtonItem(customUIButton: button)!.then {
            $0.badgeOriginX = -50
            $0.badgeOriginY = 0
        }
        return buttonItem
    }
    
    private func comparePoemNumbers(selected: Set<Int>, reference: Set<Int>) -> PoemsSelectedState {
        let intersection = selected.intersection(reference)
        if intersection.isEmpty {
            return .empry
        } else if intersection == reference {
            return .full
        } else {
            return .partial
        }
    }
}
