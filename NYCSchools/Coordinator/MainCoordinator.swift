//
//  MainCoordinator.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/24/23.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()
    
    func startCoordinator() {
        let tabBarController = MainTabBarController(mainCoordinator: self)
        self.navigationController.pushViewController(tabBarController, animated: false)
    }
    
    func goToDetailsCreen(school: NYCSchool) {
        let detailsVC = NYCSchoolDetailViewController()

        Task {
            if let scoreData = await detailsVC.vm.getNYCScoreData(id: school.id) {
                await detailsVC.configure(school: school, scoreData: scoreData)
                DispatchQueue.main.async {
                    self.navigationController.pushViewController(detailsVC, animated: true)
                }
            }
        }
    }
}
