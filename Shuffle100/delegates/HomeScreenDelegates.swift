//
//  HomeScreenDelegates.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/12/22.
//  Copyright © 2018 里 佳史. All rights reserved.
//

import UIKit

extension HomeScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return [30, 20][section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            execSettingsActions(on: tableView, at: indexPath)
        } else {
            execGameActions(on: tableView, at: indexPath)
        }
    }
    
    private func execGameActions(on tableVIew: UITableView, at indexPath: IndexPath) {
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        if settings.state100.selectedNum > 0 {
            if cell.accessibilityLabel == startGameReuseId {
                startGameAction?()
            } else {
                memorizeTimerAction?()
            }
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            alertZeroPoemsSelected()
        }
    }
    
    private func execSettingsActions(on tableView: UITableView, at indexPath: IndexPath) {
        let cellsNum = self.tableView(tableView, numberOfRowsInSection: 0)
        switch indexPath.row {
        case 0:
            selectPoemAction?()
        case 1:
            selectModeAction?()
        case cellsNum-1:
            selectSingerAction?()
        default:
            return
        }
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        settings.fakeMode = sender.isOn
        self.saveSettingsAction?()
    }
    
    @objc func gearButtonTapped(sender: UIButton) {
        self.reciteSettingsAction?()
    }
    
    @objc func helpButtonTapped(sender: UIButton) {
        self.helpActioh?()
    }
    
    private func alertZeroPoemsSelected() {
        let backAction = UIAlertAction(title: "戻る", style: .cancel)
        let ac = UIAlertController(title: "歌を選びましょう", message: "「取り札を用意する歌」で、試合に使う歌を選んでください", preferredStyle: .alert)
        ac.addAction(backAction)
        present(ac, animated: true)
    }
}
