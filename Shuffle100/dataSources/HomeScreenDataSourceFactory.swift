//
//  HomeScreenDataSourceFactory.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/02/24.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct HomeScreenDataSourceFactory {
    static let reciteModeHolders = [
        ReciteModeHolder(mode: .normal, title: "通常"),
        ReciteModeHolder(mode: .beginner, title: "初心者"),
        ReciteModeHolder(mode: .nonstop, title: "ノンストップ")
    ]
    
    static func settingsDataSource(for type: HomeCellType, settings: Settings) -> SettingsCellDataSource {
        var dataSource: SettingsCellDataSource!
        
        switch type {
        case .poems:
            dataSource = poemsDataSource(settings.state100.selectedNum)
        case .reciteMode:
            dataSource = reciteModeDataSource(for: settings.reciteMode)
        case .fakeMode:
            dataSource = fakeModeDataSource(with: settings.fakeMode)
        case .singers:
            let singer = Singers.getSingerOfID(settings.singerID)!
            dataSource = singerDataSource(with: singer.name)
        }
        dataSource.accessibilityLabel = type.rawValue
        return dataSource
    }
    
    static func startGameDataSource() -> ButtonTypeCellDataSource {
        return ButtonTypeCellDataSource(title: "試合開始", accessoryType: .none)
    }
    
    static func memorizeTimerDataSource() -> ButtonTypeCellDataSource {
        var dataSource = ButtonTypeCellDataSource(title: "暗記時間タイマー", accessoryType: .disclosureIndicator)
        dataSource.accessibilityLabel = "memorizeTimer"
        return dataSource
    }
    
    private static func poemsDataSource(_ selectedNum: Int) -> SettingsCellDataSource {
        return SettingsCellDataSource(title: "取り札を用意する歌", accessoryType: .disclosureIndicator, secondaryText: "\(selectedNum)首")
    }
    
    private static func reciteModeDataSource(for reciteMode: ReciteMode) -> SettingsCellDataSource {
        return SettingsCellDataSource(title: "読み上げモード", accessoryType: .disclosureIndicator, secondaryText: labelString(for: reciteMode)!)
        
    }
    
    private static func fakeModeDataSource(with switchOnFlg: Bool) -> SettingsCellDataSource {
        var dataSource = SettingsCellDataSource(title: "空札を加える", accessoryType: .none)
        dataSource.withSwitchOf = switchOnFlg
        return dataSource
    }
    
    private static func singerDataSource(with singerName: String) -> SettingsCellDataSource {
        return SettingsCellDataSource(title: "読手", accessoryType: .disclosureIndicator, secondaryText: singerName)
    }
    
    private static func labelString(for mode: ReciteMode) -> String? {
        for i in 0..<(reciteModeHolders.count) {
            if reciteModeHolders[i].mode == mode {
                return reciteModeHolders[i].title
            }
        }
        fatalError("ReciteMode \(mode) is not supported!")
    }
}
