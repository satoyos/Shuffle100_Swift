//
//  FillTypeHandlable.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/04/20.
//

protocol FillTypeHandlable {
   static func fillType(of someNumbers: [Int],
                 in referenceNumbers: [Int]) -> FillType
}

extension FillTypeHandlable {
  static func fillType(of someNumbers: [Int],
                       in referenceNumbers: [Int]) -> FillType {
    comparePoemNumbers(selected: Set(someNumbers),
                       in: Set(referenceNumbers))
  }
}

fileprivate func comparePoemNumbers(selected: Set<Int>, in reference: Set<Int>) -> FillType {
  let intersection = selected.intersection(reference)
  if intersection.isEmpty {
    return .empty
  } else if intersection == reference {
    return .full
  } else {
    return .partial
  }
}
