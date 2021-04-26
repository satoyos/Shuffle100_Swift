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
    
    var noPoemSelectedAlert: XCUIElement {
        return app.alerts.staticTexts[A11y.noPoemSelected].firstMatch
    }
    
    enum A11y {
        static let title = "トップ"
        static let poems = "取り札を用意する歌"
        static let reciteMode = "読み上げモード"
        static let fakeMode = "空札を加える"
        static let singer = "読手"
        static let timer = "暗記時間タイマー"
        static let gameStart = "試合開始"
        static let noPoemSelected = "詩を選びましょう"
        static let beginner = "初心者"
        static let normal = "通常"
        static let nonStop = "ノンストップ"
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
    
    func gotoSelectSingerPage() -> SelectSingerPage {
        let cell = waitToHittable(for: singerCell, timeout: timeOutSec)
        cell.tap()
        return SelectSingerPage(app: app)
    }
    
    func numberOfSelecttedPoems(is number: Int) -> Bool {
        let text = "\(number)首"
        return poemsCell.staticTexts[text].exists
    }
    
    func dismissAlert() {
        app.alerts.buttons.firstMatch.tap()
    }
    
    func reciteModeIs(_ mode: ReciteMode) -> Bool {
        return reciteModeCell.staticTexts[labelForReciteMode(mode)].exists
    }
    
    private func labelForReciteMode(_ mode: ReciteMode) -> String {
        let label: String
        switch mode {
        case .normal:
            label = A11y.normal
        case .beginner:
            label = A11y.beginner
        case .nonstop:
            label = A11y.nonStop
        }
        return label
    }
}
