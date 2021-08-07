//
//  PoemPickerPageExtension.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/07.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

extension PoemPickerPage {
    @discardableResult
    func gotoFudaSetPage() -> FudaSetPage {
        // when
        let sheet = showSelectByGroupActionSheet()
        // then
        XCTAssert(sheet.selectBySetButton.exists)
        // when
        sheet.selectBySetButton.tap()
        // then
        let fudaSetPage = FudaSetPage(app: app)
        XCTAssert(fudaSetPage.exists, "作成済みの札セット一覧のページに到達")
        return FudaSetPage(app: app)
    }
    
    @discardableResult
    func add97FudaSetAsNewOne(setName: String) -> Self {
        self
            .tapCellOf_1_2_4()
            .saveCurrentPoemsAsSet(name: setName)
        return self
    }
    
    @discardableResult
    func add2maiFudaSetAsNewOne(setName: String) -> Self {
        // when
        cancelAllButton.tap()
        let ngramPage = gotoNgramPickerPage()
        // then
        XCTAssert(ngramPage.exists)
        // when
        ngramPage
            .tapCell(type: .u)
            .tapCell(type: .tsu)
            .tapCell(type: .shi)
            .tapCell(type: .mo)
            .tapCell(type: .yu)
            .backToPickerButton.tap()
        // then
        XCTAssert(self.exists)
        // and
        saveCurrentPoemsAsSet(name: setName)
        return self
    }
    
    @discardableResult
    func add93FudaSetAsNewOne(setName: String) -> Self {
        // when
        selectAllButton.tap()
        let ngramPage = gotoNgramPickerPage()
        // then
        XCTAssert(ngramPage.exists)
        // when
        ngramPage
            .tapCell(type: .justOne)
            .backToPickerButton.tap()
        // then
        XCTAssert(self.exists)
        // and
        saveCurrentPoemsAsSet(name: setName)
        return self
    }
    
    func tapCellOf_1_2_4() -> Self {
        return self
            .tapCellof(number: 1)
            .tapCellof(number: 2)
            .tapCellof(number: 4)
    }
}
