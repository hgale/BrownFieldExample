//
//  AppDelegate.swift
//  BrownFieldExample
//
//  Created by Harry Tormey on 6/17/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        // Pull All of the screens at launch time
        ReactNativeViewController.applicationDidLaunch()
        let mainViewController = HomeScreenViewController()
        window!.rootViewController = mainViewController
        window!.makeKeyAndVisible()
        return true
    }
}

