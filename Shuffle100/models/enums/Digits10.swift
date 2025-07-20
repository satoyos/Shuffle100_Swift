//
//  Digits10.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/07/05.
//


enum Digits10: Int, Digits {
  case zero  = 0
  case one   = 1
  case two   = 2
  case three = 3
  case four  = 4
  case five  = 5
  case six   = 6
  case seven = 7
  case eight = 8
  case nine  = 9
  case ten   = 10
}

extension Digits10 {
  var poemNumbers: [Int] {
    switch self {
    case .zero: return Array(1...9)
    case .ten:  return [100]
    default:
      return Array(0...9)
        .map { self.rawValue * 10 + $0 }
    }
  }
}

extension Digits10 {
  static var description: String {
    "10の位の数で選ぶ"
  }
}

extension Digits10 {
  static let _cache: [Digits10: DigitsButtonViewModel<Digits10>] =
      Dictionary(uniqueKeysWithValues:
        Digits10.allCases.map { ($0, .init(digit: $0)) })
  var buttonViewModel: DigitsButtonViewModel<Digits10> {
    Self._cache[self]!
  }
}
