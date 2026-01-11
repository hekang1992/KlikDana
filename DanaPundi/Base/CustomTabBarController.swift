//
//  CustomTabBarController.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

import UIKit
import CoreLocation

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
        self.delegate = self
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.init(hexString: "#666666"),
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.init(hexString: "#000000"),
            .font: UIFont.systemFont(ofSize: 12, weight: .medium)
        ]
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        let bgView = UIView(frame: tabBar.bounds)
        bgView.backgroundColor = UIColor.clear
        bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(bgView, at: 0)
        
    }
    
    private func setupViewControllers() {
        let homeVc = createNavController(
            title: LanguageManager.localizedString(for: "Home"),
            image: UIImage(named: "home_nor_image") ?? UIImage(),
            selectedImage: UIImage(named: "home_sel_image") ?? UIImage(),
            rootViewController: HomeViewController()
        )
        
        let orderVc = createNavController(
            title: LanguageManager.localizedString(for: "Order"),
            image: UIImage(named: "list_nor_image") ?? UIImage(),
            selectedImage: UIImage(named: "list_sel_image") ?? UIImage(),
            rootViewController: OrderViewController()
        )
        
        let mineVc = createNavController(
            title: LanguageManager.localizedString(for: "Mine"),
            image: UIImage(named: "mine_nor_image") ?? UIImage(),
            selectedImage: UIImage(named: "mine_sel_image") ?? UIImage(),
            rootViewController: MineViewController()
        )
        
        viewControllers = [homeVc, orderVc, mineVc]
        
        selectedIndex = 0
    }
    
    private func createNavController(title: String, image: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> BaseNavigationController {
        let navController = BaseNavigationController(rootViewController: rootViewController)
        
        navController.tabBarItem = UITabBarItem(
            title: title,
            image: image.withRenderingMode(.alwaysOriginal),
            selectedImage: selectedImage.withRenderingMode(.alwaysOriginal)
        )
        
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        return navController
    }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let code = LanguageManager.currentLanguage
        if code == .en {
            return true
        }else {
            let status = CLLocationManager().authorizationStatus
            if status != .authorizedAlways && status != .authorizedWhenInUse  {
                self.showLocationDeniedAlert()
                return false
            }
        }
        return true
    }
    
    func showLocationDeniedAlert() {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(
                title: LanguageManager.localizedString(for: "Location Permission"),
                message: LanguageManager.localizedString(for: "NSLocationWhenInUseUsageDescription"),
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: LanguageManager.localizedString(for: "Cancel"), style: .cancel))
            
            alert.addAction(UIAlertAction(title: LanguageManager.localizedString(for: "Go to  settings"), style: .default) { _ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(url)
            })
            
            self.present(alert, animated: true)
        }
    }
    
}
