//
//  ReciteSettingsScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/11.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension ReciteSettingsScreen: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! SettingTableCell        
        guard let source = sections[indexPath.section].dataSources[indexPath.row] as? SettingsCellDataSource else {
            assertionFailure("Couldn't get TableDataSource as SettingsCellDataSource")
            return cell
        }
        cell.configure(dataSource: source)
        if let switchView = cell.accessoryView as? UISwitch {
            switchView.addTarget(self, action: #selector(switchValueChanged) , for: .valueChanged)
        }
        return cell
    }
}

extension ReciteSettingsScreen {
    internal func setUpTableSources() {
        self.sections = [
            createInervalSection(),
            createVolumeSection(),
            createModeSection()
        ]
    }

//
//    ToDo: 以下の関数は Computed Propertyにできる
//
    
    private func createInervalSection() -> TableSection {
        var intervalSection = TableSection(title: A11y.intervalSectionTitle)
        intervalSection.dataSources = [
            SettingsCellDataSource(title: A11y.intervalCellTitle, accessoryType: .disclosureIndicator, secondaryText: String(format: "%.2F", settings.interval)),
            SettingsCellDataSource(title: A11y.kamiShimoIntervalCellTitle, accessoryType: .disclosureIndicator, secondaryText: String(format: "%.2F", settings.kamiShimoInterval))
        ]
        return intervalSection
    }
    
    private func createVolumeSection() -> TableSection {
        var volumeSection = TableSection(title: A11y.volumeSectionTitle)
        volumeSection.dataSources = [
            SettingsCellDataSource(title: A11y.volumeCellTitle, accessoryType: .disclosureIndicator, secondaryText: "\(Int(settings.volume * 100))" + "%"),
        ]
        return volumeSection
    }
    
    private func createModeSection() -> TableSection {
        var modeSection = TableSection(title: A11y.detailGameModeScttionTitle)
        modeSection.dataSources = [
            shortenJokaTableDataSource(),
            postMotermTableDataSource()
        ]
        return modeSection
    }
    
    private func postMotermTableDataSource() -> SettingsCellDataSource {
        var dataSource =             SettingsCellDataSource(title: A11y.postMortemCellTitle, accessoryType: .none, secondaryText: "感想戦では、同じ歌を同じ順序で読み上げます。", configType: .subtitleCell())
        dataSource.withSwitchOf = settings.postMortemEnabled
        dataSource.accessibilityLabel = A11y.postMortemA11yLabel
        return dataSource
    }
    
    private func shortenJokaTableDataSource() -> SettingsCellDataSource {
        var dataSource = SettingsCellDataSource(title: A11y.shortenJokaCellTitle, accessoryType: .none, secondaryText: "序歌は、下の句を1回だけ読み上げます。", configType: .subtitleCell())
        dataSource.withSwitchOf = settings.shortenJoka
        dataSource.accessibilityLabel = A11y.shortenJokaA11yLabel
        return dataSource
    }
}
