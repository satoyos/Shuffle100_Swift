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
    
//    static func settingsDataSource(for type: HomeCellType, settings: GameSettings) -> HomeScreenDataSource {
    static func settingsDataSource(for type: HomeCellType, settings: Settings) -> HomeScreenDataSource {
        var dataSource: HomeScreenDataSource!
        
        switch type {
        case .poems:
            dataSource = poemsDataSource(settings.state100.selectedNum)
        case .reciteMode:
            dataSource = reciteModeDataSource(for: settings.reciteMode)
        case .fakeMode:
            dataSource = fakeModeDataSource(with: settings.fakeMode)
        case .singers:
            dataSource = singerDataSource()
        }
        dataSource.accessibilityLabel = type.rawValue
        return dataSource
    }
    
    static func startGameDataSource() -> HomeScreenDataSource {
        return HomeScreenDataSource(title: "試合開始", accessoryType: .none)
    }
    
    private static func poemsDataSource(_ selectedNum: Int) -> HomeScreenDataSource {
        return HomeScreenDataSource(title: "取り札を用意する歌", accessoryType: .disclosureIndicator, detailLabelText: "\(selectedNum)首")
    }
    
    private static func reciteModeDataSource(for reciteMode: ReciteMode) -> HomeScreenDataSource {
        return HomeScreenDataSource(title: "読み上げモード", accessoryType: .disclosureIndicator, detailLabelText: labelString(for: reciteMode)!)
        
    }
    
    private static func fakeModeDataSource(with switchOnFlg: Bool) -> HomeScreenDataSource {
        var dataSource = HomeScreenDataSource(title: "空札を加える", accessoryType: .none)
        dataSource.withSwitchOf = switchOnFlg
        return dataSource
    }
    
    private static func singerDataSource() -> HomeScreenDataSource {
        return HomeScreenDataSource(title: "読手", accessoryType: .disclosureIndicator)
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
