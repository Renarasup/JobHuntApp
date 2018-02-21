//
//  TabBarController.swift
//  Job Hunt
//
//  Created by Raphael on 2/18/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Setup Views
        let feedVC = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        feedVC.title = "Feed"
        feedVC.tabBarItem.image = #imageLiteral(resourceName: "Feed")
        
        let searchVC = UINavigationController(rootViewController:SearchController(collectionViewLayout: UICollectionViewFlowLayout()))
        searchVC.title = "Search"
        searchVC.tabBarItem.image = #imageLiteral(resourceName: "Search")
        
        let savedVC = UINavigationController(rootViewController:SavedController(collectionViewLayout: UICollectionViewFlowLayout()))
        savedVC.title = "Saved"
        savedVC.tabBarItem.image = #imageLiteral(resourceName: "Saved")
        
        tabBar.tintColor = #colorLiteral(red: 0.3607843137, green: 0.08235294118, blue: 0.8, alpha: 1)
        tabBar.isTranslucent = true
        tabBar.backgroundColor = UIColor.clear

        viewControllers = [feedVC, searchVC, savedVC]
        
    }
}
