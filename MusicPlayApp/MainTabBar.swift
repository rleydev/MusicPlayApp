//
//  MainTabBar.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 24.08.2022.
//

import UIKit
import SwiftUI

protocol MainTabBarDelegate: AnyObject {
    func minimizeTrackDetailedController()
    func maximizeTrackDetailedController(viewModel: SearchViewModel.Cell?)
}

class MainTabBar: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    private var bottomAnchorConstraint: NSLayoutConstraint!
    let trackDetailedView: TrackDetailedView = TrackDetailedView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor(named: "tint_pink")
        tabBar.barTintColor = .lightGray
        
        searchVC.tabBarDelegate = self
        
        var library = Library()
        library.tabBarDelegate = self
        let hostingViewController = UIHostingController(rootView: library)
        hostingViewController.tabBarItem.image = UIImage(named: "tabbar_library")
        hostingViewController.tabBarItem.title = "Library"
//        hostingViewController.view.backgroundColor = .lightGray
        
        viewControllers = [
            hostingViewController,
            generateViewController(rootViewController: searchVC, image: UIImage(named: "tabbar_search")!, title: "Search")
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
        trackDetailedView.backgroundColor = .lightGray
        trackDetailedView.translatesAutoresizingMaskIntoConstraints = false
        trackDetailedView.tabBarDelegate = self
        trackDetailedView.delegate = searchVC
        view.insertSubview(trackDetailedView, belowSubview: tabBar)
        
        // views AutoLayout
        
        minimizedTopAnchorConstraint = trackDetailedView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        maximizedTopAnchorConstraint = trackDetailedView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        bottomAnchorConstraint = trackDetailedView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)

        NSLayoutConstraint.activate([
            bottomAnchorConstraint,
            maximizedTopAnchorConstraint,
//            trackDetailedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trackDetailedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trackDetailedView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
//        trackDetailedView.previousTrackButton.titleLabel?.text = nil
//        trackDetailedView.nextTrackButton.titleLabel?.text = nil
//        trackDetailedView.playPauseButton.titleLabel?.text = nil

    }
}

extension MainTabBar: MainTabBarDelegate {
    
    func minimizeTrackDetailedController() {
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 1
            self.trackDetailedView.miniTrackView.alpha = 1
            self.trackDetailedView.maximizedStackView.alpha = 0
        }, completion: nil)
        
        trackDetailedView.trackImageView.alpha = 0

    }
    
    func maximizeTrackDetailedController(viewModel: SearchViewModel.Cell?) {
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 0
            self.trackDetailedView.miniTrackView.alpha = 0
            self.trackDetailedView.maximizedStackView.alpha = 1
        }, completion: nil)
        
        guard let viewModel = viewModel else { return }
        self.trackDetailedView.set(viewModel: viewModel)
        
        trackDetailedView.trackImageView.alpha = 1
    }
}
