//
//  FiveColorsScreen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/09/10.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class FiveColorsScreen: SettingsAttachedScreen, SelectedPoemsNumber {
    let blueButton = ColorOfFiveButton(.blue)
    let yellowButton = ColorOfFiveButton(.yellow)
    let greenButton = ColorOfFiveButton(.green)
    let pinkButton = ColorOfFiveButton(.pink)
    let orangeButton = ColorOfFiveButton(.orange)
    internal let sizes = SizeFactory.createSizeByDevice()
    let colorsDic = FiveColorsDataHolder.sharedDic
    internal var allColorButtons: [ColorOfFiveButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = StandardColor.backgroundColor
        navigationBarSetUp()
        setAllColorButtonsProperty()
        addColorButtonsAsSubviews()
        setActionForColorButtons()
        layoutButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBadge()
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
            path = "5colors/full_template.png"
        case .partial:
            path = "5colors/half_template.png"
        case .empry:
            path = "5colors/empty.png"
        }
        return path
    }
    
    private func navigationBarSetUp() {
        self.title = "五色百人一首"
        navigationItem.rightBarButtonItems = [
            selectedNumBadgeItem
        ]
    }

    private func addColorButtonsAsSubviews() {
        allColorButtons.forEach {
            view.addSubview($0)
        }
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
    
    private func setAllColorButtonsProperty() {
        allColorButtons = [blueButton, yellowButton, greenButton, pinkButton, orangeButton]
    }
    
    private func setActionForColorButtons() {
        allColorButtons.forEach { button in
            button.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        }
    }
}
