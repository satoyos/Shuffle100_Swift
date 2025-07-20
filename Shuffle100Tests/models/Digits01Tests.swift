//
//  Digits01Tests.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/06/21.
//

@testable import Shuffle100
import XCTest

final class Digits01Tests: XCTestCase {
  
  func testPoemNumbers() throws {
    // given
    let numbers2 = Digits01.two.poemNumbers
    // then
    XCTAssertEqual(numbers2, [2, 12, 22, 32, 42, 52, 62, 72, 82, 92])
    // given
    let numbers0 = Digits01.zero.poemNumbers
    // then
    XCTAssertEqual(numbers0, [10, 20, 30, 40, 50, 60, 70, 80, 90, 100])
    // size of poemNumbers is 10 in all cases
    Digits01.allCases.forEach { digit01 in
      XCTAssertEqual(digit01.poemNumbers.count, 10)
    }
  }
}
