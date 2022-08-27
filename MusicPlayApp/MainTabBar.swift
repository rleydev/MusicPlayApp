//
//  MainTabBar.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 24.08.2022.
//

import UIKit

protocol MainTabBarDelegate: AnyObject {
    func minimizeTrackDetailedController()
}

class MainTabBar: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    private var bottomAnchorConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor(named: "tint_pink")
        tabBar.barTintColor = .lightGray
        
        viewControllers = [
            generateViewController(rootViewController: searchVC, image: UIImage(named: "tabbar_search")!, title: "Search"), generateViewController(rootViewController: ViewController(), image: UIImage(named: "tabbar_library")!, title: "Library")
        ]
        
        setUpTrackDetailedView()
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
    
    private func setUpTrackDetailedView() {
        let trackDetailedView: TrackDetailedView = TrackDetailedView.loadFromNib()
        trackDetailedView.backgroundColor = .lightGray
        trackDetailedView.translatesAutoresizingMaskIntoConstraints = false
        trackDetailedView.tabBarDelegate = self
        trackDetailedView.delegate = searchVC
        view.insertSubview(trackDetailedView, belowSubview: tabBar)
        
        // views AutoLayout
        
        minimizedTopAnchorConstraint = trackDetailedView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        maximizedTopAnchorConstraint = trackDetailedView.topAnchor.constraint(equalTo: view.topAnchor)
        bottomAnchorConstraint = trackDetailedView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)

        NSLayoutConstraint.activate([
            bottomAnchorConstraint,
            maximizedTopAnchorConstraint,
//            trackDetailedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trackDetailedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trackDetailedView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension MainTabBar: MainTabBarDelegate {
    
    func minimizeTrackDetailedController() {
        maximizedTopAnchorConstraint.isActive = false
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

    }
   
}
