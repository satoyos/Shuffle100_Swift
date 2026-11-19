//
//  nameNewFudaSetAlert.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/10.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class NameNewFudaSetAlert: AlertObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var cancelButton: XCUIElement {
        return app.alerts.buttons[A11y.cancel].firstMatch
    }
    
    var confirmButton: XCUIElement {
        return app.alerts.buttons[A11y.confirm].firstMatch
    }
    
    var title: XCUIElement {
        return app.alerts.staticTexts[A11y.title].firstMatch
    }
    
    var textField: XCUIElement {
        return app.alerts.textFields[A11y.textField].firstMatch
    }

    func enterNameAndConfirm(_ name: String, timeout: TimeInterval = 8) {
        let field = textField
        XCTAssertTrue(field.waitForExistence(timeout: timeout), "札セット名の入力欄が現れる")

        field.tap()
        field.typeText(name)

        let valuePredicate = NSPredicate(format: "value == %@", name)
        let valueExpectation = XCTNSPredicateExpectation(
            predicate: valuePredicate,
            object: field
        )
        XCTAssertEqual(
            XCTWaiter().wait(for: [valueExpectation], timeout: timeout),
            .completed,
            "札セット名の入力が完了する"
        )

        dismissSoftwareKeyboardIfPresent(timeout: timeout)

        let button = confirmButton
        XCTAssertTrue(
            waitForStableHittableFrame(of: button, timeout: timeout),
            "命名ダイアログの「決定」ボタンの位置が安定する"
        )
        button.tap()
    }

    private func dismissSoftwareKeyboardIfPresent(timeout: TimeInterval) {
        let keyboard = app.keyboards.firstMatch
        guard keyboard.exists else { return }

        let dismissButton = keyboard.buttons[A11y.dismissKeyboard].firstMatch
        guard dismissButton.exists, dismissButton.isHittable else {
            return
        }

        // An element tap treats the alert as an interruption and presses its
        // default button. Tap the same point through the application instead.
        let appFrame = app.frame
        let buttonFrame = dismissButton.frame
        let offset = CGVector(
            dx: (buttonFrame.midX - appFrame.minX) / appFrame.width,
            dy: (buttonFrame.midY - appFrame.minY) / appFrame.height
        )
        app.coordinate(withNormalizedOffset: offset).tap()

        XCTAssertTrue(
            keyboard.waitForNonExistence(timeout: timeout),
            "ソフトウェアキーボードが閉じる"
        )
    }

    private func waitForStableHittableFrame(
        of element: XCUIElement,
        timeout: TimeInterval
    ) -> Bool {
        var previousFrame: CGRect?
        var stableSince = Date()
        let stableDuration: TimeInterval = 0.5

        let predicate = NSPredicate { object, _ in
            guard let element = object as? XCUIElement,
                  element.exists,
                  element.isHittable else {
                previousFrame = nil
                stableSince = Date()
                return false
            }

            let currentFrame = element.frame
            if currentFrame != previousFrame {
                previousFrame = currentFrame
                stableSince = Date()
                return false
            }

            return Date().timeIntervalSince(stableSince) >= stableDuration
        }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
    
    enum A11y {
        static let title = "新しい札セットの名前"
        static let cancel = "キャンセル"
        static let confirm = "決定"
        static let textField = "札セットの名前"
        static let dismissKeyboard = "キーボードを非表示"
    }
}
