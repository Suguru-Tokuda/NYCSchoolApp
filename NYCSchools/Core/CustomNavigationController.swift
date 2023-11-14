//
//  CustomNavigationController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import UIKit

class CustomNavigationController: UINavigationController {
    var isNewViewControllerBeingPushed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func contains(viewController: UIViewController) -> Bool {
        return self.viewControllers.map { $0.className }.contains(viewController.className)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !self.isNewViewControllerBeingPushed && !self.contains(viewController: viewController) {
            self.isNewViewControllerBeingPushed = true
            super.pushViewController(viewController, animated: animated)
        }
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.isNewViewControllerBeingPushed = false
    }
}
