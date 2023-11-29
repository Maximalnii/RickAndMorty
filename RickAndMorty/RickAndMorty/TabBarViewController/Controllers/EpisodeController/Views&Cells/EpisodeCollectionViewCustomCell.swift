//
//  EpisodeCollectionViewCustomCell.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 26.11.2023.
//

import Foundation
import UIKit

final class EpisodeCollectionViewCustomCell: UICollectionViewCell {
    
    //MARK: - Constants
    
    private enum Constants {
       
    }
    
    //MARK: - UI
    private lazy var episodeImageView: UIImageView = {
        let episodeImageView = UIImageView()
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        return episodeImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel  
    }()
    
    private lazy var nameOfEpisodeView: NameOfEpisodeView = {
        let nameOfEpisodeView = NameOfEpisodeView()
        nameOfEpisodeView.layer.cornerRadius = 16
        nameOfEpisodeView.layer.masksToBounds = true
        nameOfEpisodeView.backgroundColor = .nameOfEpisodeColor
        nameOfEpisodeView.translatesAutoresizingMaskIntoConstraints = false
        return nameOfEpisodeView
    }()
    
    //MARK: - PublicProperty
    private var detailInfo: Character?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViwes()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: DetailedInformation) {
        nameOfEpisodeView.configureNameOfEpisodeView(with: model.name, episodeName: model.episode)
        
        fetchDetailInfo(with: model.characters)
    }
    
    private func fetchDetailInfo(with characters: [String]) {
        let link = characters.randomElement()
        guard let link else { return }
        
        gettingDataCharacter(with: link) { [weak self] result in
            switch result {
            case .success(let model):
                self?.detailInfo = model
                DispatchQueue.main.async {
                    self?.nameLabel.text = model.name
                }
                self?.episodeImageView.downloaded(from: model.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func gettingDataCharacter(with url: String, completion: @escaping(Result<Character, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {data, response, error in
            guard let data = data else { return }
            do {
                let characterArray = try JSONDecoder().decode(Character.self, from: data)
                completion(.success(characterArray))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    //MARK: - Private methods
    private func setupViwes() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowOffset = .init(width: 5, height: 5)
        contentView.layer.shadowColor = UIColor.black.cgColor
        
        contentView.addSubview(episodeImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameOfEpisodeView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            episodeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            episodeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            episodeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            episodeImageView.heightAnchor.constraint(equalToConstant: 232)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: episodeImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameOfEpisodeView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            nameOfEpisodeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameOfEpisodeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameOfEpisodeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
