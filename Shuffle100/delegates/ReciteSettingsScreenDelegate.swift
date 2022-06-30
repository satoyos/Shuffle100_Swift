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
        let cell = self.tableView(self.tableView, cellForRowAt: indexPath)
        guard let content = cell.contentConfiguration as? UIListContentConfiguration else { return }
        switch content.text {
        case A11y.intervalCellTitle:
            self.intervalSettingAction?()
        case A11y.kamiShimoIntervalCellTitle:
            self.kamiShimoIntervalSettingAction?()
        case A11y.volumeCellTitle:
            self.volumeSettingAction?()
        default:
            return
        }
    }
}

extension ReciteSettingsScreen {
    
    @objc func dismissButtonTapped(_ button: UIButton) {
        self.saveSettingsAction?()
        self.dismiss(animated: true)
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        switch sender.accessibilityLabel {
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
