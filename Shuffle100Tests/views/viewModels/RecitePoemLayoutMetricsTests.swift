//
//  RecitePoemLayoutMetricsTests.swift
//  Shuffle100Tests
//
//  Created by Codex on 2026/07/26.
//

@testable import Shuffle100
import XCTest

final class RecitePoemLayoutMetricsTests: XCTestCase {

  func test_playButtonDiameter_keepsCurrentCompactWidthRatio() {
    let size = CGSize(width: 375, height: 667)

    let diameter = RecitePoemLayoutMetrics.playButtonDiameter(in: size)

    XCTAssertEqual(diameter, 300)
  }

  func test_playButtonDiameter_keepsCurrentRegularWidthRatio() {
    let size = CGSize(width: 834, height: 1194)

    let diameter = RecitePoemLayoutMetrics.playButtonDiameter(in: size)

    XCTAssertEqual(diameter, 556)
  }

  func test_playButtonDiameter_isCappedByAllocatedShortSide() {
    let size = CGSize(width: 700, height: 300)

    let diameter = RecitePoemLayoutMetrics.playButtonDiameter(in: size)

    XCTAssertEqual(diameter, 240)
  }

  func test_playButtonDiameter_returnsZeroForInvalidSize() {
    let size = CGSize(width: 0, height: 667)

    let diameter = RecitePoemLayoutMetrics.playButtonDiameter(in: size)

    XCTAssertEqual(diameter, 0)
  }
}
