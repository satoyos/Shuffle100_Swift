//
//  SkipToWhatsNextProtocol.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/06/06.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

protocol SkipToWhatsNext {
    func skipToWhatsNextPage(totalPoemsNum: Int, mode: ReciteMode) -> WhatsNextpage
}

extension SkipToWhatsNext where Self: HomePage  {
    @discardableResult
    func skipToWhatsNextPage(totalPoemsNum: Int = 100, mode: ReciteMode = .beginner) -> WhatsNextpage {
        // check
        if !(mode == .beginner || mode == .hokkaido) {
            XCTFail("Reciting mode must be .beginner or .hokkaido")
        }
        // when
        let reciteModePage = gotoSelectModePage()
        reciteModePage
            .selectMode(mode)
            .backToTopButton.tap()
        // then
        XCTAssert(reciteModeIs(mode), "選んだモードになっている")
        // when
        let recitePage = gotoRecitePoemPage()
        // then
        XCTAssert(recitePage.jokaTitle.exists, "序歌の読み上げ画面に到達")
        // when
        recitePage.tapForwardButton()
        if mode == .beginner {
            // then
            XCTAssert(recitePage.isReciting(number: 1, side: .kami, total: totalPoemsNum))
            // when
            recitePage.tapForwardButton()
        }
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .shimo, total: totalPoemsNum))
        // when
        recitePage.tapForwardButton()
        // then
        let whatsNextPage = WhatsNextpage(app: app)
        XCTAssert(whatsNextPage.exists)
        // and
        return whatsNextPage
    }
}
