//
//  PoemPickerScreenTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/03/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest
@testable import BBBadgeBarButtonItem

class PoemPickerScreenTest: XCTestCase {

    var screen: PoemPickerViewController!
    
    override func setUp() {
        super.setUp()
        self.screen = PoemPickerViewController()
        screen.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_titleIsSelectPoemInJapanese() {
        XCTAssertEqual(screen.navigationItem.title, "歌を選ぶ")
    }

    func test_numberOfCellsIs100() {
        XCTAssertEqual(screen.tableView(screen.tableView, numberOfRowsInSection: 0), 100)
    }
    
    func test_tableSectionNumIs1() {
        XCTAssertEqual(screen.numberOfSections(in: screen.tableView), 1)
    }
    
    func test_1stCellShowsPoemNo1() {
        XCTAssertEqual(firstCell().textLabel?.text, Poem100.poems[0].strWithNumberAndLiner())
    }

    func test_verseFontIsMinchoAndBodySizeForDynamicType() {
        let firstCellLabel = firstCell().textLabel
        XCTAssertEqual(firstCellLabel?.font.fontName, "HiraMinProN-W6")
        XCTAssertEqual(firstCellLabel?.font.pointSize,                       UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize)
        XCTAssert((firstCellLabel?.adjustsFontForContentSizeCategory)!)
    }
    
    private func firstCellColorIsSelectedColor() {
        // then
        if #available(iOS 13.0, *) {
            let firstCellBackColor = firstCell().backgroundColor
            XCTAssertEqual(firstCellBackColor, StandardColor.selectedPoemBackColor)
        } else {
            XCTAssertEqual(firstCell().backgroundColor, Color.nadeshiko.UIColor)
        }
    }
    
    func test_selectedPoemCellIsNadeshiko() {
        firstCellColorIsSelectedColor()
    }
    
    private func firstCellColorIsUnselectedColor() {
        // then
        let firstCellBackColor = firstCell().backgroundColor
        XCTAssertEqual(firstCellBackColor, UIColor.systemBackground)
    }
    
    func test_unselectedPoemCellIsWhite() {
        // given
        var boolArray = Bool100.allTrueBoolArray()
        boolArray[0] = false
        let testSettings = Settings(bool100: Bool100(bools: boolArray))
        // when
        screen.settings = testSettings
        screen.tableView.reloadData()
        firstCellColorIsUnselectedColor()
    }
    
    func test_tappingSelctedPoem_makeItUnselected() {
        // given
        let testIndexPath = IndexPath(row: 0, section: 0)
        // when
        screen.tableView(screen.tableView, didSelectRowAt: testIndexPath)
        // then
        firstCellColorIsUnselectedColor()
        XCTAssertEqual(screen.selected_num, 99)
    }
    
    func test_tappingUnselectedPoem_makeItSelected() {
        // given
        let testBoolArray = Bool100.allFalseBoolArray()
        let testSetting = Settings(bool100: Bool100(bools: testBoolArray))
        screen.settings = testSetting
        screen.tableView.reloadData()
        let testIndex = IndexPath(row: 0, section: 0)
        // when
        screen.tableView(screen.tableView, didSelectRowAt: testIndex)
        // then
        firstCellColorIsSelectedColor()
        XCTAssertEqual(screen.selected_num, 1)
    }
    
    func test_tagOfCellIsSet() {
        XCTAssertEqual(firstCell().tag, 1)
    }
    
    func test_accessibilityLabelIsSet() {
        XCTAssertEqual(firstCell().accessibilityLabel, "001")
    }
    
    func test_badgeValueShowsSelectedNum() {
        guard let bbItem = screen.navigationItem.rightBarButtonItem as? BBBadgeBarButtonItem else {
            XCTAssert(false, "Could't get BBBadgeBarButtonItem")
            return
        }
        XCTAssertEqual(bbItem.badgeValue, "100首")
    }
    
    func test_tappingPoemChangesBadgeValue() {
        // given
        guard let btnWithBadge = screen.navigationItem.rightBarButtonItem as? BBBadgeBarButtonItem else {
            XCTAssert(false, "Could't get BBBadgeBarButtonItem")
            return
        }
        XCTAssertEqual(btnWithBadge.badgeValue, "100首")
        // when
        let testIndex = IndexPath(row: 0, section: 0)
        screen.tableView(screen.tableView, didSelectRowAt: testIndex)
        // then
        XCTAssertEqual(btnWithBadge.badgeValue, "99首")
        
    }
    
    func test_searchBarExists() {
        XCTAssertNotNil(screen.navigationItem.searchController)
    }
    
    private func firstCell() -> UITableViewCell {
        return screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    }
    
    func test_toolBarExists() {
        // given
        let picker = PoemPickerViewController()
        let _ = UINavigationController(rootViewController: picker)
        picker.loadViewIfNeeded()
        // when
        picker.viewDidAppear(false)
        // then
       XCTAssertFalse(picker.navigationController!.isToolbarHidden)
    }
    
    func test_toolBarHas3Buttons() {
        // given
        let picker = PoemPickerViewController()
        let _ = UINavigationController(rootViewController: picker)
        picker.loadViewIfNeeded()
        // when
        picker.viewDidAppear(false)
        // then
        let items = picker.navigationController?.toolbar.items
        let buttons = items?.filter{ $0.target != nil }
        XCTAssertEqual(buttons?.count, 3)
    }
}
