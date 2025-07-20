//
//  FillType.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/04/20.
//

import Foundation

enum FillType {
  case empty
  case partial
  case full
}

extension FillType {
  var fiveColorsImageName: String {
    switch self {
    case .empty:   "5ColorEmpty"
    case .partial: "5ColorHalf"
    case .full:    "5ColorFull"
    }
  }
}

extension FillType {
  var ngramImageName: String {
    switch self {
    case .empty:   "NgramEmpty"
    case .partial: "NgramHalf"
    case .full:    "NgramFull"
    }
  }
}

