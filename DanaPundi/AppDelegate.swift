//
//  AppDelegate.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
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
    
    @objc private func changeRootVc(noti: Notification) {
        let json = noti.userInfo
        let tabBar = CustomTabBarController()
        if SaveLoginInfo.isLoggedIn() {
            tabBar.selectedIndex = Int(json?["selectIndex"] as? String ?? "0") ?? 0
            window?.rootViewController = tabBar
        }else {
            window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        }
    }
    
}
