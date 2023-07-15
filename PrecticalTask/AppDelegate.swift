//
//  AppDelegate.swift
//  PrecticalTask
//
//  Created by Abhay Pansora on 15/07/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let VC = HomeVC(nibName: "HomeVC", bundle: nil)
        self.navigationController = UINavigationController(rootViewController: VC)
        self.window?.rootViewController = appDelegate.navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}

