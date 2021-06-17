//
//  ReciteSettingsScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/11.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension ReciteSettingsScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.intervalSettingAction?()
        case 1:
            self.kamiShimoIntervalSettingAction?()
        case 2:
            self.volumeSettingAction?()
        default:
            assertionFailure("他の選択肢は対応していません！")
        }
    }
    
    @objc func dismissButtonTapped(_ button: UIButton) {
        self.saveSettingsAction?()
        self.dismiss(animated: true)
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        switch sender.accessibilityLabel {
//        case "postMortemModeSwitch":
        case A11y.postMortemA11yLabel + "Switch":
            settings.postMortemEnabled = sender.isOn
        case A11y.shortenJokaA11yLabel + "Switch":
            settings.shortenJoka = sender.isOn
        default:
            assertionFailure("UISwitch of name [\(sender.accessibilityLabel ?? "")] is unknown!")
        }
        self.saveSettingsAction?()
    }
    
}
