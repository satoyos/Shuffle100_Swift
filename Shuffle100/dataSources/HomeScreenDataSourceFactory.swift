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
    
    static func settingsDataSource(for type: HomeCellType, settings: GameSettings) -> DataSource {
        var dataSource: DataSource!
        
        switch type {
        case .poems:
            dataSource = poemsDataSource()
        case .reciteMode:
            dataSource = reciteModeDataSource(for: settings.reciteMode)
        case .fakeMode:
            dataSource = fakeModeDataSource()
        case .singers:
            dataSource = singerDataSource()
        }
        dataSource.gameSettings = settings
        dataSource.accessibilityLabel = type.rawValue
        return dataSource
    }
    
    static func startGameDataSource() -> DataSource {
        return DataSource(title: "試合開始", accessoryType: .none)
    }
    
    private static func poemsDataSource() -> DataSource {
        return DataSource(title: "取り札を用意する歌", accessoryType: .disclosureIndicator)
    }
    
    private static func reciteModeDataSource(for reciteMode: ReciteMode) -> DataSource {
        return DataSource(title: "読み上げモード", accessoryType: .disclosureIndicator, detailLabelText: labelString(for: reciteMode)!)
        
    }
    
    private static func fakeModeDataSource() -> DataSource {
        return DataSource(title: "空札を加える", accessoryType: .none, withSwitch: true)
    }
    
    private static func singerDataSource() -> DataSource {
        return DataSource(title: "読手", accessoryType: .disclosureIndicator)
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
