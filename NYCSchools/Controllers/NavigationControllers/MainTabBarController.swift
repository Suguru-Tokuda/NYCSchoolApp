//
//  MainTabBarController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/14/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    weak var mainCoordinator: MainCoordinator?
    
    init(mainCoordinator: MainCoordinator? = nil) {
        super.init(nibName: "", bundle: nil)
        self.mainCoordinator = mainCoordinator

        self.viewControllers?.forEach { vc in
            if let vc = vc as? CustomNavigationController {
                vc.mainCoordinator = mainCoordinator
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let vc1 = CustomNavigationController(rootViewController: NYCListViewController())
        vc1.navigationBar.tintColor = .label
        vc1.identifier = "NYCListViewController"
        
        let vc2 = CustomNavigationController(rootViewController: NYCSchoolMapViewController())
        vc2.navigationBar.tintColor = .label
        vc2.identifier = "NYCSchoolMapViewController"
        
        vc1.tabBarItem.image = UIImage(systemName: "list.bullet")
        vc2.tabBarItem.image = UIImage(systemName: "map.fill")
        
        vc1.tabBarItem.title = "List"
        vc2.tabBarItem.title = "Map"
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        
        setViewControllers([vc1, vc2], animated: false)
    }
}
