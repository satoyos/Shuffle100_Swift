//
//  AspectRatioRootLayoutTests.swift
//  Shuffle100Tests
//
//  Created by Codex on 2026/07/26.
//

@testable import Shuffle100
import XCTest

final class AspectRatioRootLayoutTests: XCTestCase {

  func test_usesLandscapeContainer_whenAllocatedSizeIsWiderThanTall() {
    let size = CGSize(width: 1024, height: 768)

    XCTAssertTrue(AspectRatioRootLayout.usesLandscapeContainer(for: size))
  }

  func test_doesNotUseLandscapeContainer_whenAllocatedSizeIsTallerThanWide() {
    let size = CGSize(width: 390, height: 844)

    XCTAssertFalse(AspectRatioRootLayout.usesLandscapeContainer(for: size))
  }

  func test_doesNotUseLandscapeContainer_whenAllocatedSizeIsSquare() {
    let size = CGSize(width: 600, height: 600)

    XCTAssertFalse(AspectRatioRootLayout.usesLandscapeContainer(for: size))
  }

  func test_contentWidth_isCappedByHeightRatioInLandscape() {
    let size = CGSize(width: 1024, height: 768)

    XCTAssertEqual(AspectRatioRootLayout.contentWidth(for: size), 576)
  }

  func test_contentWidth_usesFullWidthWhenNarrowerThanHeightRatio() {
    let size = CGSize(width: 500, height: 1000)

    XCTAssertEqual(AspectRatioRootLayout.contentWidth(for: size), 500)
  }
}
