//
//  WhatsNextPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/06/06.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class WhatsNextpage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.staticTexts[A11y.title].firstMatch
    }
    
    var gearButton: XCUIElement {
        return app.buttons[A11y.gear].firstMatch
    }
    
    var exitButton: XCUIElement {
        return app.buttons[A11y.exit].firstMatch
    }
    
    enum A11y {
        static let title = "次はどうする？"
        static let gear = "gear"
        static let exit = "exit"
    }
    
    func gotoReciteSettingsPage() -> ReciteSettingsPage {
        gearButton.tap()
        return ReciteSettingsPage(app: app)
    }
    
    func popUpExitGameAlert() -> ExitGameAlert {
        exitButton.tap()
        return ExitGameAlert(app: app)
    }
}
