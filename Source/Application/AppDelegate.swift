//
//  AppDelegate.swift
//  PerpTestTask
//
//  Created by Yurii Tsymbala on 1/17/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupView()
    return true
  }

  private func setupView() {
    let mainViewController = MainViewController(
      withViewModel: MainViewModel(downloadService: DownloadService()),
      withRouter: Router())
    let navigationControoler = UINavigationController(rootViewController: mainViewController)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationControoler
    window?.makeKeyAndVisible()
  }


}

