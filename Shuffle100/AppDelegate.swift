//
//  AppDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/09/08.
//  Copyright © 2018年 里 佳史. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    disableConnectHardwareKeyboardOnSimulator()
    cleanUserDefualtIfUITesting()

    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  
  private func cleanUserDefualtIfUITesting() {
    if CommandLine.arguments.contains("--uitesting") {
      let userDefaults = UserDefaults.standard
      if let domain = Bundle.main.bundleIdentifier {
        userDefaults.removePersistentDomain(forName: domain)
      }
    }
  }
  
  private func disableConnectHardwareKeyboardOnSimulator() {
#if targetEnvironment(simulator)
    // Disable hardware keyboards.
    let setHardwareLayout = NSSelectorFromString("setHardwareLayout:")
    UITextInputMode.activeInputModes
    // Filter `UIKeyboardInputMode`s.
      .filter({ $0.responds(to: setHardwareLayout) })
      .forEach { $0.perform(setHardwareLayout, with: nil) }
#endif
  }
}
