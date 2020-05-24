//
//  AppDelegate.swift
//  Movie Search
//
//  Created by Prajeesh Prabhakar on 4/27/19.
//  Copyright © 2019 Prajeesh Prabhakar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let movieSearchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieSearch") as? MovieSearchViewController {
            //Set navigation controller
            let navigationController = UINavigationController(rootViewController: movieSearchVC)
            movieSearchVC.navigationItem.title = "Movie Search"
            
            //Set window root view controller
            window = UIWindow()
            window?.makeKeyAndVisible()
            window?.rootViewController = navigationController
        }
        
        return true
    }
    
}

