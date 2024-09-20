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
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window, navigationController: navigationController)
        appCoordinator?.start()
        
        APIManager.fetchNowShowingMovies { result in
            
        }
        
        APIManager.fetchPopularMovies(page: 1) { result in
            
        }
        
        APIManager.fetchDetailsMovie(movieId: 5377540) { result in
            
            
        }
        APIManager.fetchCast(movieId: 5377540) { result in
            
            
        }
        
        return true
    }
    
}
