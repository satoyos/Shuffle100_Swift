//
//  FirstCharPoemNumbersTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/05/09.
//

@testable import Shuffle100
import XCTest

final class FirstCharTests: XCTestCase {
  func testCorrectNumbers() {
    FirstChar.allCases.forEach { char in
      if char == .justOne {
        XCTAssertEqual(char.poemNumbers, [18, 22, 57, 70, 77, 81, 87])

      } else {
        XCTAssertEqual(char.poemNumbers,
                          poemNumbersFor(char: char))
      }
    }
  }
  
  func poemNumbersFor(char: FirstChar) -> [Int] {
    guard char != .justOne else { return [] }
    return PoemSupplier.originalPoems
      .filter {
        $0.kimari_ji.first == Character(char.description)}
      .map(\.number)
  }
}
