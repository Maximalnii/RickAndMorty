//
//  TabBarController.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 26.11.2023.
//

import UIKit

//MARK: - Final class
final class TabBarController: UITabBarController {
    
    //MARK: - Constants
    private enum Constants {
        static let episodes = "episodes"
        static let favourites = "favourites"
    }
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: - Private methods
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: EpisodeViewController(),
                image: UIImage(
                    named: Constants.episodes
                )
            ),
            generateVC(
                viewController: FavouritesViewController(),
                image: UIImage(
                    named: Constants.favourites
                )
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
}
