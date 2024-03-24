//
//  WhatsNextScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

@testable import Shuffle100
import XCTest

class WhatsNextScreenTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() {
        // given
        let poemSupplier = PoemSupplier()
        let testPoem = poemSupplier.drawNextPoem()!
        let screen = WhatsNextScreen(currentPoem: testPoem)
        // when
        screen.loadViewIfNeeded()
        screen.view.layoutSubviews()
        // then
        XCTAssertEqual(screen.title, "次はどうする？")
        XCTAssertEqual(screen.view.subviews.count, 3)
        XCTAssertEqual(screen.refrainButton.title(for: .normal), "下の句をもう一度読む")
        XCTAssertEqual(screen.refrainButton.frame.size.width, screen.view.frame.size.width * 0.8)
        XCTAssertEqual(screen.torifudaButton.title(for: .normal), "取り札を見る")
        XCTAssertEqual(screen.goNextButton.title(for: .normal), "次の歌へ！")
    }

}
