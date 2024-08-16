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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        func createNavController(for rootViewController: UIViewController, title: String, imageName: String) -> UINavigationController {
            rootViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: imageName), tag: 0)
            rootViewController.navigationItem.title = title
            rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.star"), style: .plain, target: self, action: #selector(leftButtonTapped))
            rootViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .plain, target: self, action: #selector(rightButtonTapped))
            return UINavigationController(rootViewController: rootViewController)
        }
        
        let movies = createNavController(for: MainViewController(nibName: "MainViewController", bundle: nil), title: "KinkiNO", imageName: "movieclapper")
        let tickets = createNavController(for: TicketsViewController(nibName: "TicketsViewController", bundle: nil), title: "Tickets", imageName: "ticket")
        let favourites = createNavController(for: FavouritesViewController(nibName: "FavouritesViewController", bundle: nil), title: "Favourites", imageName: "heart.fill")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [movies, tickets, favourites]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    @objc func leftButtonTapped() { }
    
    @objc func rightButtonTapped() { }
}
