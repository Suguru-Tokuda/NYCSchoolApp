//
//  MainTabBarController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/14/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let vc1 = CustomNavigationController(rootViewController: NYCListViewController())
        let vc2 = CustomNavigationController(rootViewController: NYCHighSchoolMapViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "list.bullet")
        vc2.tabBarItem.image = UIImage(systemName: "map.fill")
        
        vc1.tabBarItem.title = "List"
        vc2.tabBarItem.title = "Map"
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        
        setViewControllers([vc1, vc2], animated: false)
    }
}
