//
//  EpisodeViewController.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 22.11.2023.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vcSetting()
        setupViews()
        setupConstraints()
        
    }
    
    private func vcSetting() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
    
    private func setupViews() {
    }
    
    private func setupConstraints() {
        
    }
}
