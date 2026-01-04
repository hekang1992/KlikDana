//
//  CustomTabBarController.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
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

