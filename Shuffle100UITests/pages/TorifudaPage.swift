//
//  TorifudaPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/06/25.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class TorifudaPage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }

    var pageTitle: XCUIElement {
        app.images[A11y.fudaView].firstMatch
    }
   
    var backToWhatsNextButton: XCUIElement {
        app.navigationBars.buttons[A11y.whatsNext].firstMatch
    }
    
    var backToPickerButton: XCUIElement {
        app.navigationBars.buttons[A11y.picker].firstMatch
    }
    
    var fullLinersView: XCUIElement {
        app.textViews[A11y.fullLiner].firstMatch
    }
    
    enum A11y {
        static let fudaView = "fudaView"
        static let whatsNext = "次はどうする？"
        static let picker = "歌を選ぶ"
        static let fullLiner = "fullLinersView"
    }
    
    func hasChar(_ char: Character) -> Bool {
        return app.staticTexts[String(char)].exists
    }
}
