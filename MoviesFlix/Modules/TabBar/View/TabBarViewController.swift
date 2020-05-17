//
//  TabBarViewController.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        let nav1 = UINavigationController()
        
        let movieListVC = MovieListRouter.createModule()
        movieListVC.tabBarItem.tag = 0
        movieListVC.tabBarItem.image = UIImage(named: "PlayNow")
        movieListVC.tabBarItem.title = "Now Playing"
        nav1.navigationBar.barTintColor = .themeColor
        nav1.viewControllers = [movieListVC]
        let nav2 = UINavigationController()
        let topRatedMoviesVC = TRMovieListRouter.createModule()
        topRatedMoviesVC.tabBarItem.tag = 1
        topRatedMoviesVC.tabBarItem.image = UIImage(named: "TopRate")
        topRatedMoviesVC.tabBarItem.title = "Top Rated"
        nav2.navigationBar.barTintColor = .themeColor
        nav2.viewControllers = [topRatedMoviesVC]
        let tabBarList = [nav1,nav2]
        self.tabBar.tintColor = .black
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .themeColor
        self.viewControllers = tabBarList
        
    }
}
