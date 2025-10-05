//
//  RecitePoemSwiftUIView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/23.
//

import SwiftUI

struct RecitePoemSwiftUIView {
  let settings: Settings
  @ObservedObject private var viewModel: RecitePoemViewModel
  @Environment(\.isPresented) private var isPresented

  init(settings: Settings) {
    self.settings = settings
    self.viewModel = RecitePoemViewModel(settings: settings)
  }

  // Secondary initializer for external view model
  init(settings: Settings, viewModel: RecitePoemViewModel) {
    self.settings = settings
    self.viewModel = viewModel
  }
}

extension RecitePoemSwiftUIView: View {
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        // Header - Full width
        RecitePoemHeaderView(
          title: viewModel.output.title,
          gearAction: {
            viewModel.input.gearButtonTapped.send()
          },
          exitAction: {
            viewModel.input.exitButtonTapped.send()
          }
        )

        // Content with padding
        VStack(spacing: 0) {
          Spacer()

          // Joka Description Labels
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

          Spacer()

          // Play Button
          RecitePlayButton(
            diameter: playButtonDiameter(for: geometry),
            viewModel: viewModel.playButtonViewModel
          )

          Spacer()

          // Lower Controls
          RecitePoemLowerControlsView(
            progressValue: viewModel.binding.progressValue,
            rewindAction: {
              viewModel.input.rewindButtonTapped.send()
            },
            forwardAction: {
              viewModel.input.forwardButtonTapped.send()
            },
            controlSize: controlButtonSize(for: geometry)
          )

          Spacer()
        }
        .padding(.horizontal, 16)
      }
    }
    .navigationBarHidden(true)
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
      viewModel.input.appWillResignActive.send()
    }
  }

  private func playButtonDiameter(for geometry: GeometryProxy) -> Double {
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
      return geometry.size.width * 300 / 375
    case .pad:
      return geometry.size.width * 2 / 3
    default:
      return min(geometry.size.width, geometry.size.height) * 0.4
    }
  }

  private func controlButtonSize(for geometry: GeometryProxy) -> Double {
    min(geometry.size.width, geometry.size.height) * 0.12
  }
}


#Preview {
  RecitePoemSwiftUIView(settings: Settings())
}