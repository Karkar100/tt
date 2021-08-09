//
//  AppDelegate.swift
//  tt
//
//  Created by Diana Princess on 02.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = ViewController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nv = UINavigationController(rootViewController: vc)
        nv.view.backgroundColor = .green
        self.window?.rootViewController = nv
        window?.makeKeyAndVisible()
        
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle






}

