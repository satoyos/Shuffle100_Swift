//
//  HomeScreenDataSourceFactory.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/02/24.
//  Copyright © 2019 里 佳史. All rights reserved.
//

// import UIKit
import Foundation

struct HomeScreenDataSourceFactory {
    static let reciteModeHolders = [
        ReciteModeHolder(mode: .normal, title: "通常"),
        ReciteModeHolder(mode: .beginner, title: "初心者"),
        ReciteModeHolder(mode: .nonstop, title: "ノンストップ"),
        ReciteModeHolder(mode: .hokkaido, title: "下の句かるた")
    ]
    
    static func settingsDataSource(for type: HomeCellType, settings: Settings) -> SettingsCellDataSource {
        var dataSource: SettingsCellDataSource!
        
        switch type {
        case .poems:
            dataSource = poemsDataSource(of: settings.state100.selectedNum)
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
        var dataSource = ButtonTypeCellDataSource(
            title: "試合開始",
            accessoryType: .none)
        dataSource.titleColor = .red
        dataSource.fontWeight = .bold
        dataSource.accessibilityLabel = "GameStartCell"
        return dataSource
    }
    
    static func memorizeTimerDataSource() -> ButtonTypeCellDataSource {
        var dataSource = ButtonTypeCellDataSource(
            title: "暗記時間タイマー",
            accessoryType: .disclosureIndicator)
        dataSource.accessibilityLabel = "memorizeTimer"
        return dataSource
    }
    
    private static func poemsDataSource(of selectedNum: Int) -> SettingsCellDataSource {
        SettingsCellDataSource(
            title: "取り札を用意する歌",
            accessoryType: .disclosureIndicator,
            secondaryText: "\(selectedNum)首")
    }
    
    private static func reciteModeDataSource(for reciteMode: ReciteMode) -> SettingsCellDataSource {
        SettingsCellDataSource(
            title: "読み上げモード",
            accessoryType: .disclosureIndicator,
            secondaryText: labelString(for: reciteMode))
    }
    
    private static func fakeModeDataSource(with switchOnFlg: Bool) -> SettingsCellDataSource {
        var dataSource = SettingsCellDataSource(
            title: "空札を加える",
            accessoryType: .none)
        dataSource.withSwitchOf = switchOnFlg
        return dataSource
    }
    
    private static func singerDataSource(with singerName: String) -> SettingsCellDataSource {
        SettingsCellDataSource(
            title: "読手",
            accessoryType: .disclosureIndicator,
            secondaryText: singerName)
    }
    
    private static func labelString(for mode: ReciteMode) -> String {
        var title = ""
        for holder in reciteModeHolders {
            if holder.mode == mode {
                title = holder.title
                break
            }
        }
        if title == "" {
            assertionFailure("ReciteMode \(mode) is not supported!")
        }
        return title
    }

}
