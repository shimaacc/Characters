//
//  AppDelegate.swift
//  Characters
//
//  Created by Shimaa Elcc on 22.10.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = AppCoordinator(
            window: window!)
        appCoordinator?.start()
        return true
    }
}

