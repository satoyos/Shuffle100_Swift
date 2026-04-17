//
//  HelpListScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/06/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

@MainActor
class HelpListScreenTest: XCTestCase {

  func test_viewModelInitialization_hasTwoSections() {
    // given
    let viewModel = HelpList.ViewModel()

    // then
    XCTAssertEqual(viewModel.sections.count, 2)
    XCTAssertEqual(viewModel.sections[0].name, "使い方")
    XCTAssertEqual(viewModel.sections[1].name, "その他")
  }

  func test_viewModelFirstSection_hasCorrectFirstItem() {
    // given
    let viewModel = HelpList.ViewModel()

    // when
    let firstDataSource = viewModel.sections[0].dataSources[0]

    // then
    XCTAssertEqual(firstDataSource.name, "設定できること")
    XCTAssertEqual(firstDataSource.type, .html)
    XCTAssertEqual(firstDataSource.fileName, "html/options")
  }
}
