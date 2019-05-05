//
//  PoemPickerScreenTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/03/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class PoemPickerScreenTest: XCTestCase {

    var screen: PoemPickerViewController!
    
    override func setUp() {
        super.setUp()
        self.screen = PoemPickerViewController()
        screen.viewDidLoad()
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
    
    func test_selectedPoemCellIsNadeshiko() {
        XCTAssertEqual(firstCell().backgroundColor, UIColor(hex: "eebbcb"))
    }
    
    func test_unselectedPoemCellIsWhite() {
        // given
        var boolArray = allSelectedBools100()
        boolArray[0] = false
        let testSettings = Settings(bool100: Bool100(bools: boolArray))
        // when
        screen.settings = testSettings
        screen.tableView.reloadData()
        // then
        XCTAssertEqual(firstCell().backgroundColor, UIColor.white)        
    }
    
    func test_tagOfCellIsSet() {
        XCTAssertEqual(firstCell().tag, 1)
    }
    
    private func firstCell() -> UITableViewCell {
        return screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    }
    
    private func allSelectedBools100() -> [Bool] {
        return [Bool](repeating: true, count: 100)
    }
}
