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
    func skipToWhatsNextPage() -> WhatsNextpage
}

extension SkipToWhatsNext where Self: HomePage  {
    @discardableResult
    func skipToWhatsNextPage() -> WhatsNextpage {
        // when
        let reciteModePage = gotoSelectModePage()
        reciteModePage
            .selectMode(.beginner)
            .backToTopButton.tap()
        // then
        XCTAssert(reciteModeIs(.beginner), "初心者モードになっている")
        // when
        let recitePage = gotoRecitePoemPage()
        // then
        XCTAssert(recitePage.jokaTitle.exists, "序歌の読み上げ画面に到達")
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.appears(number: 1, side: .kami))
        // hwn
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.appears(number: 1, side: .shimo))
        // when
        recitePage.tapForwardButton()
        return WhatsNextpage(app: app)
    }
}
