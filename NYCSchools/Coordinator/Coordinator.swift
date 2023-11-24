//
//  Coordinator.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/24/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get }
    var navigationController: UINavigationController { get set }
    func startCoordinator()
}
