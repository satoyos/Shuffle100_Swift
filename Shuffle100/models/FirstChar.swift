//
//  FirstChar.swift
//  TrialButtonAnimation
//
//  Created by Yoshifumi Sato on 2025/05/09.
//

enum FirstChar {
  case justOne
  case u
  case tsu
  case shi
  case mo
  case yu
  case i
  case chi
  case hi
  case ki
  case ha
  case ya
  case yo
  case ka
  case mi
  case ta
  case ko
  case o
  case wa
  case na
  case a
}

extension FirstChar: CaseIterable {}

extension FirstChar: Identifiable {
  var id: Self {
    self
  }
}

extension FirstChar: CustomStringConvertible {
  var description: String {
    switch self {
    case .justOne: "一字決まり"
    case .u:   "う"
    case .tsu: "つ"
    case .shi: "し"
    case .mo:  "も"
    case .yu:  "ゆ"
    case .i:   "い"
    case .chi: "ち"
    case .hi:  "ひ"
    case .ki:  "き"
    case .ha:  "は"
    case .ya:  "や"
    case .yo:  "よ"
    case .ka:  "か"
    case .mi:  "み"
    case .ta:  "た"
    case .ko:  "こ"
    case .o:   "お"
    case .wa:  "わ"
    case .na:  "な"
    case .a:   "あ"
    }
  }
}

extension FirstChar {
  var title: String {
    switch self {
    case .justOne: "一字決まりの歌"
    default: "「\(description)」で始まる歌"
    }
  }
}

extension FirstChar {
  var poemNumbers: [Int] {
    switch self {
    case .justOne: [18, 22, 57, 70, 77, 81, 87]
    case .u:       [65, 74]
    case .tsu:     [13, 23]
    case .shi:     [37, 40]
    case .mo:      [66, 100]
    case .yu:      [46, 71]
    case .i:       [21, 61, 63]
    case .chi:     [17, 42, 75]
    case .hi:      [33, 35, 99]
    case .ki:      [15, 50, 91]
    case .ha:      [ 2,  9, 67, 96]
    case .ya:      [28, 32, 47, 59]
    case .yo:      [62, 83, 85, 93]
    case .ka:      [ 6, 48, 51, 98]
    case .mi:      [14, 27, 49, 90, 94]
    case .ta:      [ 4, 16, 34, 55, 73, 89]
    case .ko:      [10, 24, 29, 41, 68, 97]
    case .o:       [ 5, 26, 44, 60, 72, 82, 95]
    case .wa:      [ 8, 11, 20, 38, 54, 76, 92]
    case .na:      [19, 25, 36, 53, 80, 84, 86, 88]
    case .a:       [ 1,  3,  7, 12,
                    30, 31, 39, 43,
                    45, 52, 56, 58,
                    64, 69, 78, 79]
    }
  }
}
