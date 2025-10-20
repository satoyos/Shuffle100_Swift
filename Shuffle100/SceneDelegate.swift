//
//  SceneDelegate.swift
//  Shuffle100
//
//  Created by Claude on 2025/10/18.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AppWindow {

  var window: UIWindow?
  var coordinator: MainCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    if #available(iOS 15.0, *) {
      setScrollEdgeAppearnceForNavigationBar()
    }

    let navController = UINavigationController()
    coordinator = MainCoordinator(navigationController: navController)
    coordinator?.start()

    self.window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()

    if CommandLine.arguments.contains("--uitesting") {
      let window = keyWindow
      window.layer.speed = 5
    }
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }

  private func setScrollEdgeAppearnceForNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = StandardColor.barTintColor
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().standardAppearance = appearance
  }
}
