//
//  HelpWebView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import SwiftUI
import WebKit

struct HelpWebView: UIViewRepresentable {
  let htmlFileName: String

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    loadLocalHTML(fileName: htmlFileName, to: webView)
    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    // 更新不要
  }

  private func loadLocalHTML(fileName: String, to webView: WKWebView) {
    guard let path = Bundle.main.path(forResource: fileName, ofType: "html") else {
      print("HTML file not found: \(fileName)")
      return
    }
    let localHTMLUrl = URL(fileURLWithPath: path, isDirectory: false)
    webView.loadFileURL(localHTMLUrl, allowingReadAccessTo: localHTMLUrl)
  }
}

#Preview {
  HelpWebView(htmlFileName: "html/options")
}
