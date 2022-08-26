//
//  MainTabBar.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 24.08.2022.
//

import UIKit

class MainTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
        
        tabBar.tintColor = UIColor(named: "tint_pink")
        tabBar.barTintColor = .lightGray
        
        viewControllers = [
            generateViewController(rootViewController: searchVC, image: UIImage(named: "tabbar_search")!, title: "Search"), generateViewController(rootViewController: ViewController(), image: UIImage(named: "tabbar_library")!, title: "Library")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        navigationVC.navigationBar.barTintColor = .lightGray
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
}
