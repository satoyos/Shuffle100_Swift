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
    func gotoFiveColorsPage() -> FiveColorsPage {
        let sheet = showSelectByGroupActionSheet()
        sheet.selectByColorButton.tap()
        return FiveColorsPage(app: app)
    }
    
    @discardableResult
    func saveCurrentPoemsByOverwritingExistingSet(name: String) -> Self {
        // when
        saveButton.tap()
        let sheet = SaveFudaSetActionSheet(app: app)
        let button = sheet.overwriteExistingSetButton
        button.tap()
        // then
        let overwriteDialog = OverwriteExistingSetDialog(app: app)
        XCTAssert(overwriteDialog.exists)
        // when
        overwriteDialog
            .selectOverwrittenSet(name: name)
            .confirmButton.tap()
        // then
        let dialog = OverwriteSetCompletedDialog(app: app)
        XCTAssert(dialog.exists)
        // when
        dialog.confirmButton.tap()
        // then
        XCTAssertFalse(dialog.exists, "確認ダイアログは消えている")
        // and
        return self
    }
    
    @discardableResult
    func add97FudaSetAsNewOne(setName: String) -> Self {
        self
            .tapCellOf_1_2_4()
            .saveCurrentPoemsAsNewSet(name: setName)
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
        saveCurrentPoemsAsNewSet(name: setName)
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
        saveCurrentPoemsAsNewSet(name: setName)
        return self
    }
    
    @discardableResult
    func add1jiKimariFudaSetAsNewOne(setName: String) -> Self {
        // when
        cancelAllButton.tap()
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
        saveCurrentPoemsAsNewSet(name: setName)
        return self
    }
    
    func tapCellOf_1_2_4() -> Self {
        return self
            .tapCellof(number: 1)
            .tapCellof(number: 2)
            .tapCellof(number: 4)
    }
}
