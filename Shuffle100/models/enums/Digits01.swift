//
//  Digits01.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/06/21.
//

enum Digits01: Int, Digits {
  case one   = 1
  case two   = 2
  case three = 3
  case four  = 4
  case five  = 5
  case six   = 6
  case seven = 7
  case eight = 8
  case nine  = 9
  case zero  = 0
}

extension Digits01 {
  var poemNumbers: [Int] {
    switch self {
    case .zero:
      return Array(1...10).map {$0 * 10}
    default:
      return Array(0...9)
        .map {$0 * 10 + self.rawValue}
    }
  }
}

extension Digits01 {
  static var description: String {
    "1の位の数で選ぶ"
  }
}

extension Digits01 {
  var buttonViewModel: DigitsButtonViewModel<Digits01> {
    Self._cache[self]!
  }
  static let _cache: [Digits01: DigitsButtonViewModel<Digits01>] =
      Dictionary(uniqueKeysWithValues:
        Digits01.allCases.map { ($0, .init(digit: $0)) })
}
