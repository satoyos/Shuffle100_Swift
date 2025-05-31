//
//  NgramSection.swift
//  TrialButtonAnimation
//
//  Created by Yoshifumi Sato on 2025/05/11.
//

struct NgramSection {
  let title: String
  let firstChars: [FirstChar]
}

extension NgramSection: Identifiable {
  var id: String {
    title
  }
}

struct NgramSections {
  static let `default`: [NgramSection] = [
    .init(title: "一枚札",
          firstChars: [.justOne]),
    .init(title: "二枚札",
          firstChars: [.u, .tsu, .shi, .mo, .yu]),
    .init(title: "三枚札",
         firstChars: [.i, .chi, .hi, .ki]),
    .init(title: "四枚札",
          firstChars: [.ha, .ya, .yo, .ka]),
    .init(title: "五枚札",
          firstChars: [.mi]),
    .init(title: "六枚札",
          firstChars: [.ta, .ko]),
    .init(title: "七枚札",
          firstChars: [.o, .wa]),
    .init(title: "八枚札",
          firstChars: [.na]),
    .init(title: "十六枚札",
          firstChars: [.a]),
  ]
}
