//
//  AppCoordinator.swift
//  Kino
//
//  Created by Viktoriya Polozova on 21/08/2024.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    var parentCoordinator: (any CoordinatorProtocol)?
    
    var children: [any CoordinatorProtocol] = []
    
    var navigationController: UINavigationController
    
    var window: UIWindow?
    
    init(window: UIWindow?, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        
        let homeScreenCoordinator = HomeScreenCoordinator(navigationController: navigationController)
        homeScreenCoordinator.start()
        print("AppCoordinator started")
    }
}
