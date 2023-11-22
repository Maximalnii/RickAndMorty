//
//  LaunchScreenViewController.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 22.11.2023.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    private lazy var loadingComponentImageView: UIImageView = {
        let loadingComponentImageView = UIImageView()
        loadingComponentImageView.image = UIImage(named: "loadingComponent")
        loadingComponentImageView.translatesAutoresizingMaskIntoConstraints = false
        return loadingComponentImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: loadingComponentImageView.rotate)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.navigateToEpisodeViewController()
                }

    }
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(loadingComponentImageView)
    }
    
    private func animate() {
        
    }
    
    private func navigateToEpisodeViewController() {
        let destenationVC = EpisodeViewController()
        navigationController?.pushViewController(destenationVC, animated: true)
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 97),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 312),
            logoImageView.heightAnchor.constraint(equalToConstant: 104)
        ])
        
        NSLayoutConstraint.activate([
            loadingComponentImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingComponentImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingComponentImageView.widthAnchor.constraint(equalToConstant: 200),
            loadingComponentImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }

}

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

