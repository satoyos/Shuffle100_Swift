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

        // Content with equal spacing (1:1:1 ratio)
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

              // Joka Description Labels
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

            // Play Button
            RecitePlayButton(
              diameter: playButtonDiam,
              viewModel: viewModel.playButtonViewModel
            )
            .frame(height: playButtonDiam)

            // Space 2: Play Button to Lower Controls (1/3)
            Color.clear
              .frame(height: spaceHeight)

            // Lower Controls
            RecitePoemLowerControlsView(
              progressValue: viewModel.binding.progressValue,
              rewindAction: {
                viewModel.input.rewindButtonTapped.send()
              },
              forwardAction: {
                viewModel.input.forwardButtonTapped.send()
              },
              controlSize: skipButtonSize,
              playButtonWidth: playButtonDiam
            )
            .frame(width: lowerControlWidth, height: skipButtonSize)

            // Space 3: Lower Controls to Bottom (1/3)
            Color.clear
              .frame(height: spaceHeight)
          }
          .frame(width: contentGeometry.size.width, height: contentGeometry.size.height, alignment: .top)
        }
        .background(Color(.systemBackground))
      }
      .background(
        Color(StandardColor.barTintColor)
          .ignoresSafeArea()
      )
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