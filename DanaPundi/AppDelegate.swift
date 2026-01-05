//
//  AppDelegate.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        config()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
}

extension AppDelegate {
    
    private func config() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        NotificationCenter.default.addObserver(self, selector: #selector(changeRootVc), name: NSNotification.Name("changeRootVc"), object: nil)
    }
    
    @objc private func changeRootVc() {
        if SaveLoginInfo.isLoggedIn() {
            window?.rootViewController = CustomTabBarController()
        }else {
            window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        }
    }
    
}
