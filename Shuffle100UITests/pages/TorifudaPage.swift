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
        return app.images[A11y.fudaView].firstMatch
    }
   
    var backToWhatsNextButton: XCUIElement {
        return app.navigationBars.buttons[A11y.whatsNext].firstMatch
    }
    
    enum A11y {
        static let fudaView = "fudaView"
        static let whatsNext = "次はどうする？"
    }
    
    func hasChar(_ char: Character) -> Bool {
        return app.staticTexts[String(char)].exists
    }
}
