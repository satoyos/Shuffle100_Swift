//
//  HomeScreenDelegates.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/12/22.
//  Copyright © 2018 里 佳史. All rights reserved.
//

import UIKit

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return [30, 20][section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                selectPoemAction?()
            case 1:
                selectModeAction?()
            case 3:
                selectSingerAction?()
            default:
                return
            }
        } else {
            startGameAction?()
        }
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        settings.fakeMode = sender.isOn
        self.saveSettingsAction?()
    }
    
    @objc func gearButtonTapped(sender: UIButton) {
        self.reciteSettingsAction?()
    }
}
