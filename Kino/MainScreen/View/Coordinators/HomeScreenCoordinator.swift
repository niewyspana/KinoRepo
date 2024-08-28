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
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        mainViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "movieclapper"), tag: 0)
        
        let viewModel = MainScreenViewModel(coordinator: self)
        mainViewController.viewModel = viewModel
        
        let ticketViewCoordinator = TicketsViewController(nibName: "TicketsViewController", bundle: nil)
        ticketViewCoordinator.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "ticket"), tag: 1)
        
        let favViewController = FavouritesViewController(nibName: "FavouritesViewController", bundle: nil)
        favViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart.fill"), tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainViewController, ticketViewCoordinator, favViewController]
        
        navigationController.setViewControllers([tabBarController], animated: false)
        setupNavigationBarItems(for: tabBarController)
    }
    
    func goToDetailsScreen() {
        let movieDetailedInfo = MovieDetailedInfo(previewImage: UIImage(named: "trailer")!, title: "", imdbRating: "", rating: "", genres: [], language: "", duration: "", descriptionText: "", cast: [])
        
        let viewModel = DetailsViewModel(model: movieDetailedInfo)
        
        let detailsViewController = DetailsViewController()
        detailsViewController.viewModel = viewModel
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
    
    func goToSeeMore() {
        
    }
}
