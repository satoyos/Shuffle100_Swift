//
//  HelpDetailView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import SwiftUI

struct HelpDetailView: View {
  let title: String
  let htmlFileName: String

  var body: some View {
    HelpWebView(htmlFileName: htmlFileName)
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  NavigationStack {
    HelpDetailView(title: "設定できること", htmlFileName: "html/options")
  }
}
