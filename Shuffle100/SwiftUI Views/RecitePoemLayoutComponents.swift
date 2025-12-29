//
//  RecitePoemLayoutComponents.swift
//  Shuffle100
//
//  Created by Claude Code on 2025/12/29.
//

import SwiftUI

// MARK: - Layout Components
extension RecitePoemView {

  // MARK: - Size Calculations

  func playButtonDiameter(for geometry: GeometryProxy) -> Double {
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
      return geometry.size.width * 300 / 375
    case .pad:
      return geometry.size.width * 2 / 3
    default:
      return min(geometry.size.width, geometry.size.height) * 0.4
    }
  }

  func controlButtonSize(for geometry: GeometryProxy) -> Double {
    min(geometry.size.width, geometry.size.height) * 0.12
  }
}
