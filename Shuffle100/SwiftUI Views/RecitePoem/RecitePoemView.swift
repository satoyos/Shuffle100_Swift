//
//  RecitePoemView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/23.
//

import SwiftUI

struct RecitePoemView {
  let settings: Settings
  @ObservedObject var viewModel: RecitePoemViewModel
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

extension RecitePoemView: View {
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        headerView
        contentArea(geometry: geometry)
      }
      .background(
        Color(StandardColor.barTintColor)
          .ignoresSafeArea()
      )
    }
    .navigationBarHidden(true)
    .modifier(AppLifecycleModifier(viewModel: viewModel))
    .background(exitAlert)
    .background(postMortemDialog)
  }
}

// MARK: - Supporting View Modifier
private struct AppLifecycleModifier: ViewModifier {
  @ObservedObject var viewModel: RecitePoemViewModel

  func body(content: Content) -> some View {
    content
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
        viewModel.input.appWillResignActive.send()
      }
  }
}


#Preview {
  RecitePoemView(settings: Settings())
}
