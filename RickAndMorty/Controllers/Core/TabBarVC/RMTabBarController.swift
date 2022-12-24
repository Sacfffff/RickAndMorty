//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class RMTabBarController: UITabBarController {
    
    private var arrayOfViewControllers : [UIViewController] {
        return [RMCharacterViewController(), RMLocationViewController(),  RMEpisodeViewController(), RMSettingsViewController()]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    private func setupTabs() {
        
        var navigationControllers : [UINavigationController] = []
        let tabBarViewControllers : [TabBarViewControllers] = TabBarViewControllers.allCases
        for (index, controller) in  arrayOfViewControllers.enumerated() {
            controller.navigationItem.largeTitleDisplayMode = .automatic
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.navigationBar.tintColor = .label
            navigationController.tabBarItem = UITabBarItem(title: tabBarViewControllers[index].title, image: tabBarViewControllers[index].image, tag: index)
           navigationController.navigationBar.prefersLargeTitles = true
            navigationControllers.append(navigationController)
        }
        setViewControllers(navigationControllers, animated: false)
    }


}

