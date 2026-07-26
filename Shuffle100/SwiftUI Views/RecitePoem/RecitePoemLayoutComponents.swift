//
//  RecitePoemLayoutComponents.swift
//  Shuffle100
//
//  Created by Claude Code on 2025/12/29.
//

import SwiftUI

struct RecitePoemLayoutMetrics {
  private static let compactWidthThreshold: CGFloat = 600
  private static let compactWidthRatio: CGFloat = 300 / 375
  private static let regularWidthRatio: CGFloat = 2 / 3
  private static let heightCapRatio: CGFloat = 0.8

  static func playButtonDiameter(in size: CGSize) -> CGFloat {
    guard size.width > 0, size.height > 0 else {
      return 0
    }

    let widthRatio = size.width < compactWidthThreshold ? compactWidthRatio : regularWidthRatio
    let widthBasedDiameter = size.width * widthRatio
    let heightCap = min(size.width, size.height) * heightCapRatio

    return min(widthBasedDiameter, heightCap)
  }
}

// MARK: - Layout Components
extension RecitePoemView {

  // MARK: - Size Calculations

  func playButtonDiameter(for geometry: GeometryProxy) -> Double {
    RecitePoemLayoutMetrics.playButtonDiameter(in: geometry.size)
  }

  func controlButtonSize(for geometry: GeometryProxy) -> Double {
    min(geometry.size.width, geometry.size.height) * 0.12
  }
}
