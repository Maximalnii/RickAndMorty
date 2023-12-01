//
//  NameOfEpisodeView.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 27.11.2023.
//

import UIKit

final class NameOfEpisodeView: UIView {
    
    //MARK: - Constants
    private enum Constants {
        static let screenImage = "screenImage"
        static let likeImage = "likeImage"
    }
    
    //MARK: - UI
    private lazy var screenImageView: UIImageView = {
        let screenImageView = UIImageView()
        screenImageView.image = UIImage(named: Constants.screenImage)
        screenImageView.translatesAutoresizingMaskIntoConstraints = false
        return screenImageView
    }()
    
    private lazy var episodNameLabel: UILabel = {
        let episodNameLabel = UILabel()
        episodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return episodNameLabel
    }()
    
    private lazy var likeImageView: UIImageView = {
        let likeImageView = UIImageView()
        likeImageView.image = UIImage(named: Constants.likeImage)
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        return likeImageView
    }()
    
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        setupViwes()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Pulic methods
    func configureNameOfEpisodeView(with name: String, episodeName: String) {
        episodNameLabel.text = "\(name) | \(episodeName)"
    }
    
    //MARK: - Private methods
    private func setupViwes() {
        addSubview(screenImageView)
        addSubview(episodNameLabel)
        addSubview(likeImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            screenImageView.topAnchor.constraint(equalTo: topAnchor, constant: 22.72),
            screenImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21.92),
            screenImageView.widthAnchor.constraint(equalToConstant: 32.881),
            screenImageView.heightAnchor.constraint(equalToConstant: 34.08)
        ])
        
        NSLayoutConstraint.activate([
            episodNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28.4),
            episodNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65.76),
            episodNameLabel.trailingAnchor.constraint(equalTo: likeImageView.leadingAnchor, constant: -5),
            episodNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19.88)
        ])
        
        NSLayoutConstraint.activate([
            likeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            likeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeImageView.widthAnchor.constraint(equalToConstant: 40),
            likeImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}



