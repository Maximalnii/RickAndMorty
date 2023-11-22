//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 22.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let launchScreenViewController = LaunchScreenViewController()
        let navController = UINavigationController(rootViewController: launchScreenViewController)
        
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
}
