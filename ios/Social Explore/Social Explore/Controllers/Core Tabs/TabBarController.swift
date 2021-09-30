//
//  TabBarViewController.swift
//  Social Explore
//
//  Created by Sterling Gamble on 8/26/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black

        let home = HomeViewController()
        home.title = "Home"
        let add = AddViewController()
        add.title = "Add"
        let profile = ProfileViewController()
        profile.title = "Profile"

//        add.navigationItem.largeTitleDisplayMode = .always
//        home.navigationItem.largeTitleDisplayMode = .always
//        profile.navigationItem.largeTitleDisplayMode = .always

        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: add)
        let nav3 = UINavigationController(rootViewController: profile)

//        nav1.navigationBar.prefersLargeTitles = true
//        nav2.navigationBar.prefersLargeTitles = true
//        nav3.navigationBar.prefersLargeTitles = true
        
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus.square"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle"), tag: 3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
        
    }

}
