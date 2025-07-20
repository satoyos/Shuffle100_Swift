//
//  Digits10Tests.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/07/05.
//

@testable import Shuffle100
import XCTest

final class Digits10Tests: XCTestCase {
    
  func testPoemNumbers() {
    // given
    let numbers1 = Digits10.one.poemNumbers
    let numbers5 = Digits10.five.poemNumbers
    let numbers0 = Digits10.zero.poemNumbers
    let numbers10 = Digits10.ten.poemNumbers
    // then
    XCTAssertEqual(numbers1, Array(10...19))
    XCTAssertEqual(numbers5, Array(50...59))
    XCTAssertEqual(numbers0, Array(1...9))
    XCTAssertEqual(numbers10, [100])
  }
}
