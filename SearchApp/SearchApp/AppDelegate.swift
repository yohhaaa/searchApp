//
//  AppDelegate.swift
//  SearchApp
//
//  Created by Алан Ахмадуллин on 14.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let searchViewController = ModelBuilder.createMainModule()
        let navigationBar = UINavigationController(rootViewController: searchViewController)
        window?.rootViewController = navigationBar
        window?.makeKeyAndVisible()
        return true
    }
}

