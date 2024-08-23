//
//  HomeScreenCoordinator.swift
//  Kino
//
//  Created by Viktoriya Polozova on 21/08/2024.
//

import UIKit

class HomeScreenCoordinator: CoordinatorProtocol {
    var parentCoordinator: (any CoordinatorProtocol)?
    
    var children: [any CoordinatorProtocol] = []
    
    internal var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        mainViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "movieclapper"), tag: 0)
        
        var viewModel = MainScreenViewModel(coordinator: self)
        mainViewController.viewModel = viewModel
        
        let ticket = TicketsViewController(nibName: "TicketsViewController", bundle: nil)
        ticket.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "ticket"), tag: 1)
        
        let fav = FavouritesViewController(nibName: "FavouritesViewController", bundle: nil)
        fav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart.fill"), tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainViewController, ticket, fav]
        
        navigationController.setViewControllers([tabBarController], animated: false)
        
        setupNavigationBarItems(for: tabBarController)
    }
    
    func goToDetailsScreen() {
        let detailsViewController = DetailsViewController()
        navigationController.pushViewController(detailsViewController, animated: true)
    }
    
    private func setupNavigationBarItems(for tabBarController: UITabBarController) {
        let listBarButton = UIBarButtonItem(image: UIImage(systemName: "list.star"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftButtonTapped))
        
        tabBarController.navigationItem.leftBarButtonItem = listBarButton
        
        let bellBarButton = UIBarButtonItem(image: UIImage(systemName: "bell.badge"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(rightButtonTapped))
        
        tabBarController.navigationItem.rightBarButtonItem = bellBarButton
        tabBarController.navigationItem.title = "KinkiNo"
        print("HomeScreen started")
    }
    
    @objc private func leftButtonTapped() { }
    @objc private func rightButtonTapped() { }
}
