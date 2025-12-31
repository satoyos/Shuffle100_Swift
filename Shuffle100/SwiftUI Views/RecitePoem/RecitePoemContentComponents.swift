//
//  RecitePoemContentComponents.swift
//  Shuffle100
//
//  Created by Claude Code on 2025/12/29.
//

import SwiftUI

// MARK: - Content Components
extension RecitePoemView {

  // MARK: - Header

  var headerView: some View {
    RecitePoemHeaderView(
      title: viewModel.output.title,
      gearAction: {
        viewModel.input.gearButtonTapped.send()
      },
      exitAction: {
        viewModel.input.exitButtonTapped.send()
      }
    )
  }

  // MARK: - Joka Description

  var jokaDescriptionLabels: some View {
    VStack {
      if viewModel.output.showNormalJokaDesc {
        Text("試合開始の合図として読まれる歌です。")
          .font(.caption)
          .foregroundColor(.secondary)
          .padding()
          .transition(.opacity)
      }

      if viewModel.output.showShortJokaDesc {
        Text("序歌を途中から読み上げています。")
          .font(.caption)
          .foregroundColor(.secondary)
          .padding()
          .transition(.opacity)
      }
    }
  }

  // MARK: - Play Button

  func playButtonArea(diameter: Double) -> some View {
    RecitePlayButton(
      diameter: diameter,
      viewModel: viewModel.playButtonViewModel
    )
    .frame(height: diameter)
  }

  // MARK: - Lower Controls

  func lowerControlsArea(
    progressValue: Float,
    controlSize: Double,
    playButtonWidth: Double
  ) -> some View {
    RecitePoemLowerControlsView(
      progressValue: progressValue,
      rewindAction: {
        viewModel.input.rewindButtonTapped.send()
      },
      forwardAction: {
        viewModel.input.forwardButtonTapped.send()
      },
      controlSize: controlSize,
      playButtonWidth: playButtonWidth
    )
    .frame(width: playButtonWidth, height: controlSize)
  }

  // MARK: - Content Area

  func contentArea(geometry: GeometryProxy) -> some View {
    GeometryReader { contentGeometry in
      let playButtonDiam = playButtonDiameter(for: geometry)
      let skipButtonSize = controlButtonSize(for: geometry)
      // UIKit版の制約と同じロジック: 3つのスペースが残りの高さを均等に分割
      let spaceHeight = (contentGeometry.size.height - playButtonDiam - skipButtonSize) / 3
      let lowerControlWidth = playButtonDiam

      VStack(spacing: 0) {
        // Space 1: Header to Play Button (1/3)
        ZStack {
          Color.clear
            .frame(height: spaceHeight)

          jokaDescriptionLabels
        }

        // Play Button
        playButtonArea(diameter: playButtonDiam)

        // Space 2: Play Button to Lower Controls (1/3)
        Color.clear
          .frame(height: spaceHeight)

        // Lower Controls
        lowerControlsArea(
          progressValue: viewModel.binding.progressValue,
          controlSize: skipButtonSize,
          playButtonWidth: playButtonDiam
        )

        // Space 3: Lower Controls to Bottom (1/3)
        Color.clear
          .frame(height: spaceHeight)
      }
      .frame(
        width: contentGeometry.size.width,
        height: contentGeometry.size.height,
        alignment: .top
      )
    }
    .background(Color(.systemBackground))
  }
}
