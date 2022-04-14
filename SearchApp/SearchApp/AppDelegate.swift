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
        
        let mainVC = ModelBuilder.createMainModule()
        let navBar = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navBar
        window?.makeKeyAndVisible()
        return true
    }
}

