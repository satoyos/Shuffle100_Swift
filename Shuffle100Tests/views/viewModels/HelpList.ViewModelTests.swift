//
//  HelpList.ViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

@testable import Shuffle100
import XCTest

@MainActor
final class HelpListViewModelTests: XCTestCase {

  func test_initialization_hasTwoSections() {
    let viewModel = HelpList.ViewModel()
    XCTAssertEqual(viewModel.sections.count, 2)
  }

  func test_firstSectionName_isUsageInstructions() {
    let viewModel = HelpList.ViewModel()
    XCTAssertEqual(viewModel.sections[0].name, "使い方")
  }

  func test_secondSectionName_isOther() {
    let viewModel = HelpList.ViewModel()
    XCTAssertEqual(viewModel.sections[1].name, "その他")
  }

  func test_usageSectionHas10Items() {
    let viewModel = HelpList.ViewModel()
    let usageSection = viewModel.sections[0]
    XCTAssertEqual(usageSection.dataSources.count, 10)
  }

  func test_hokkaidoModeIsAtIndex5InUsageSection() {
    let viewModel = HelpList.ViewModel()
    let usageSection = viewModel.sections[0]
    XCTAssertEqual(usageSection.dataSources[5].name, "「下の句かるたモード」とは？")
    XCTAssertEqual(usageSection.dataSources[5].type, .html)
    XCTAssertEqual(usageSection.dataSources[5].fileName, "html/what_is_hokkaido_mode")
  }

  func test_otherSectionHasThreeItems() {
    let viewModel = HelpList.ViewModel()
    let otherSection = viewModel.sections[1]
    XCTAssertEqual(otherSection.dataSources.count, 3)
  }

  func test_otherSectionContainsAboutInaba() {
    let viewModel = HelpList.ViewModel()
    let otherSection = viewModel.sections[1]
    XCTAssertEqual(otherSection.dataSources[0].name, "「いなばくん」について")
    XCTAssertEqual(otherSection.dataSources[0].type, .html)
  }

  func test_otherSectionContainsReview() {
    let viewModel = HelpList.ViewModel()
    let otherSection = viewModel.sections[1]
    XCTAssertEqual(otherSection.dataSources[1].name, "このアプリを評価する")
    XCTAssertEqual(otherSection.dataSources[1].type, .review)
    XCTAssertNil(otherSection.dataSources[1].fileName)
  }

  func test_otherSectionContainsVersionWithDetail() {
    let viewModel = HelpList.ViewModel()
    let otherSection = viewModel.sections[1]
    XCTAssertEqual(otherSection.dataSources[2].name, "バージョン")
    XCTAssertEqual(otherSection.dataSources[2].type, .value1)
    XCTAssertNotNil(otherSection.dataSources[2].detail)
  }

  func test_allUsageSectionItemsHaveHTMLType() {
    let viewModel = HelpList.ViewModel()
    let usageSection = viewModel.sections[0]
    for dataSource in usageSection.dataSources {
      XCTAssertEqual(dataSource.type, .html)
      XCTAssertNotNil(dataSource.fileName)
    }
  }
}
