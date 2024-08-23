//
//  AppDelegate.swift
//  Kino
//
//  Created by Viktoriya Polozova on 13/08/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions 
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = setupMainNavigationViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func setupMainNavigationViewController() -> UINavigationController {
        let movies = MainViewController(nibName: "MainViewController", bundle: nil)
        movies.viewModel = MainScreenViewModel()
        movies.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "movieclapper"), tag: 0)
        
        let ticket = TicketsViewController(nibName: "TicketsViewController", bundle: nil)
        ticket.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "ticket"), tag: 1)
        
        let fav = FavouritesViewController(nibName: "FavouritesViewController", bundle: nil)
        fav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart.fill"), tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [movies, ticket, fav]
        
        let navigationController = UINavigationController(rootViewController: tabBarController)
        
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
        
        return navigationController
    }
    
    @objc func leftButtonTapped() { }
    
    @objc func rightButtonTapped() { }
}
