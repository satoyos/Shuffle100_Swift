//
//  HelpListView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import SwiftUI

struct HelpListView: View {
  @ObservedObject var viewModel: HelpList.ViewModel
  @StateObject private var router = HelpRouter()

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        ForEach(viewModel.sections.indices, id: \.self) { sectionIndex in
          Section(header: Text(viewModel.sections[sectionIndex].name)) {
            ForEach(viewModel.sections[sectionIndex].dataSources.indices, id: \.self) { rowIndex in
              helpListRow(for: viewModel.sections[sectionIndex].dataSources[rowIndex])
            }
          }
        }
      }
      .listStyle(.insetGrouped)
      .navigationTitle("ヘルプ")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewModel.dismissAction?()
          } label: {
            Image(systemName: "xmark")
          }
          .accessibilityLabel("閉じる")
        }
      }
      .toolbarBackground(Color(uiColor: StandardColor.barTintColor), for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .navigationDestination(for: HelpRoute.self) { route in
        router.destination(for: route)  // Routerに委譲
      }
      .alert("このアプリを評価するために、App Storeアプリを立ち上げますか？", isPresented: $router.showReviewAlert) {
        Button("やめておく", role: .cancel) {}
        Button("立ち上げる") {
          router.openAppStoreReview()
        }
      }
    }
  }

  @ViewBuilder
  private func helpListRow(for dataSource: HelpListDataSource) -> some View {
    switch dataSource.type {
    case .html:
      NavigationLink(value: HelpRoute.detail(
        title: dataSource.name,
        fileName: dataSource.fileName!
      )) {
        Text(dataSource.name)
      }
    case .review:
      Button(dataSource.name) {
        router.showReviewAlert = true
      }
      .foregroundColor(.primary)
    case .value1:
      HStack {
        Text(dataSource.name)
        Spacer()
        Text(dataSource.detail ?? "")
          .foregroundColor(.secondary)
      }
    }
  }
}

#Preview {
  HelpListView(viewModel: HelpList.ViewModel())
}
