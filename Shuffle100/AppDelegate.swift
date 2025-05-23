//
//  AppDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/09/08.
//  Copyright © 2018年 里 佳史. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppWindow {
  
  var window: UIWindow?
  var coordinator: MainCoordinator?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    disableConnectHardwareKeyboardOnSimulator()
    cleanUserDefualtIfUITesting()
    if #available(iOS 15.0, *) {
      setScrollEdgeAppearnceForNavigationBar()
    }
    
    let navController = UINavigationController()
    coordinator = MainCoordinator(navigationController: navController)
    coordinator?.start()
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    
    if CommandLine.arguments.contains("--uitesting") {
      let window = keyWindow
      window.layer.speed = 5
    }
    
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
  
  private func setScrollEdgeAppearnceForNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = StandardColor.barTintColor
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().standardAppearance = appearance
  }
}
