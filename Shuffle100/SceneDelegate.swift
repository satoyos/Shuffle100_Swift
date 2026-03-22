//
//  SceneDelegate.swift
//  Shuffle100
//
//  Created by Claude on 2025/10/18.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AppWindow {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let store = StoreManager()
    let router = AppRouter(store: store)

    let rootView = AppRootView()
      .environmentObject(router)

    let hostController = UIHostingController(rootView: rootView)

    self.window = UIWindow(windowScene: windowScene)
    let container = AspectRatioContainerViewController(child: hostController)
    window?.rootViewController = container
    window?.makeKeyAndVisible()

    if CommandLine.arguments.contains("--uitesting") {
      let window = keyWindow
      window.layer.speed = 5
    }
  }

  func sceneDidDisconnect(_ scene: UIScene) {}
  func sceneDidBecomeActive(_ scene: UIScene) {}
  func sceneWillResignActive(_ scene: UIScene) {}
  func sceneWillEnterForeground(_ scene: UIScene) {}
  func sceneDidEnterBackground(_ scene: UIScene) {}
}
