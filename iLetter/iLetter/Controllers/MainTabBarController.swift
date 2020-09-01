//
//  NavigationViewController.swift
//  iLetter
//
//  Created by Дарья on 24.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = #colorLiteral(red: 0.274399973, green: 0.7686067224, blue: 0.554736535, alpha: 1)
        let mediumConfig = UIImage.SymbolConfiguration(weight: .medium)
        
        let peopleVC = PeopleViewController()
        let listVC = ListViewController()
        
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: mediumConfig)!
        let listImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: mediumConfig)!

        
        viewControllers = [
            generateNavigationController(rootViewController: peopleVC, title: "People", image: peopleImage),
            generateNavigationController(rootViewController: listVC, title: "My list", image: listImage)
        ]
    }
    
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}
