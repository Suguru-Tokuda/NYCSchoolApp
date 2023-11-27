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
        let tabBarController = MainTabBarController()
        tabBarController.setCoordinator(mainCoordinator: self)
        self.navigationController.pushViewController(tabBarController, animated: false)
    }
    
    func goToDetailsView(school: NYCSchool, dataFetchErrorHandlder: ((Error?) -> ())? = nil, sheetCompletion: (() -> ())? = nil, sheetDismissed: (() -> ())? = nil) {
        let detailsVC = NYCSchoolDetailViewController()
        
        detailsVC.vm.getNYCScoreDataHandler = dataFetchErrorHandlder
        detailsVC.sheetDismissed = sheetDismissed

        Task {
            if let scoreData = await detailsVC.vm.getNYCScoreData(id: school.id) {
                await detailsVC.configure(school: school, scoreData: scoreData)
                DispatchQueue.main.async {
                    self.navigationController.pushViewController(detailsVC, animated: true)
                }
            }
        }
    }
    
    func presentNYCSchoolDetailsSheet(school: NYCSchool, dataFetchErrorHandlder: ((Error?) -> ())? = nil, sheetCompletion: (() -> ())? = nil, sheetDismissed: (() -> ())? = nil) {
        let detailsVC = NYCSchoolDetailViewController(isSheet: true)
        
        detailsVC.vm.getNYCScoreDataHandler = dataFetchErrorHandlder
        detailsVC.sheetDismissed = sheetDismissed

        Task {
            if let scoreData = await detailsVC.vm.getNYCScoreData(id: school.id) {
                await detailsVC.configure(school: school, scoreData: scoreData)
                DispatchQueue.main.async {
                    self.navigationController.present(detailsVC, animated: true, completion: sheetCompletion)
                }
            }
        }
    }
    
    func goToFilterScreen(sortKey: NYCSchoolSortKey, sortOrder: SortOrder, sortOptionApply: @escaping (((NYCSchoolSortKey, SortOrder)) -> ())) {
        let sortVC = SortViewController()
        sortVC.configure(sortKey: sortKey, sortOrder: sortOrder)
        sortVC.sortOptionApply = sortOptionApply
        navigationController.pushViewController(sortVC, animated: true)
    }
}
