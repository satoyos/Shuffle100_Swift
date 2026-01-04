//
//  HelpRouter.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import SwiftUI

@MainActor
class HelpRouter: ObservableObject {
  @Published var path = NavigationPath()
  @Published var showReviewAlert = false

  func navigate(to route: HelpRoute) {
    path.append(route)
  }

  func pop() {
    guard !path.isEmpty else { return }
    path.removeLast()
  }

  func popToRoot() {
    path = NavigationPath()
  }

  func openAppStoreReview() {
    if let url = URL(string: "https://itunes.apple.com/us/app/itunes-u/id857819404?action=write-review") {
      UIApplication.shared.open(url)
    }
  }

  // ルートから遷移先ビューへの変換
  // HelpListViewから責務を移動し、Routerが遷移先ビューを知る
  @ViewBuilder
  func destination(for route: HelpRoute) -> some View {
    switch route {
    case .detail(let title, let fileName):
      HelpDetailView(title: title, htmlFileName: fileName)
    case .appStoreReview:
      EmptyView()
    }
  }
}
