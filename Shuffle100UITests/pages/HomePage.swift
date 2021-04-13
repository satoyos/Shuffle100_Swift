//
//  HomePage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/05.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class HomePage: PageObjectable, WaitInUITest {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars[A11y.title].firstMatch
    }
    
    var poemsCell: XCUIElement {
        return app.cells[A11y.poems].firstMatch
    }
    
    var reciteModeCell: XCUIElement {
        return app.cells[A11y.reciteMode].firstMatch
    }
    
    var fakeModeCell: XCUIElement {
        return app.cells[A11y.fakeMode].firstMatch
    }
    
    var singerCell: XCUIElement {
        return app.cells[A11y.singer].firstMatch
    }
    
    var timerCell: XCUIElement {
        return app.cells[A11y.timer].firstMatch
    }
    
    var gameStartCell: XCUIElement {
        return app.cells[A11y.gameStart].firstMatch
    }
    
    enum A11y {
        static let title = "トップ"
        static let poems = "取り札を用意する歌"
        static let reciteMode = "読み上げモード"
        static let fakeMode = "空札を加える"
        static let singer = "読手"
        static let timer = "暗記時間タイマー"
        static let gameStart = "試合開始"
    }
    
    func goToPoemPickerPage() -> PoemPickerPage {
        let cell = waitToHittable(for: poemsCell, timeout: timeOutSec)
        cell.tap()
        return PoemPickerPage(app: app)
    }
    
    func gotoRecitePoemPage() -> RecitePoemPage {
        let cell = waitToHittable(for: gameStartCell, timeout: timeOutSec)
        cell.tap()
        return RecitePoemPage(app: app)
    }
    
    func gotoSelectModePage() -> SelectModePage {
        let cell = waitToHittable(for: reciteModeCell, timeout: timeOutSec)
        cell.tap()
        return SelectModePage(app: app)
    }
}