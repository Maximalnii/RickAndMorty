//
//  EpisodeViewController.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 22.11.2023.
//

import UIKit

//MARK: - Final class

final class EpisodeViewController: UIViewController {
    
    //MARK: - Constants
    private enum Constants {
        static let logo = "logo"
        static let searchBarPlaceholder = "Name or episode"
        static let cell = "Cell"
        static let mainUrl = "https://rickandmortyapi.com/api/episode"
    }
    
    //MARK: - UI
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: Constants.logo)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.cornerRadius = 50
        searchBar.returnKeyType = .done
        searchBar.placeholder = Constants.searchBarPlaceholder
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var episodeCollectionView: UICollectionView = {
        let categiryLayout = UICollectionViewFlowLayout()
        categiryLayout.scrollDirection = .vertical
        categiryLayout.minimumLineSpacing = 40
        let episodeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categiryLayout)
        episodeCollectionView.register(EpisodeCollectionViewCustomCell.self, forCellWithReuseIdentifier: Constants.cell)
        episodeCollectionView.backgroundColor = .clear
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
        episodeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return episodeCollectionView
    }()
    
    //MARK: - PrivateProperty
    private var episodesModel: Episodes? {
        didSet {
            DispatchQueue.main.async {
                self.episodeCollectionView.reloadData()
            }
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fetchEpisodes()
    }
    
    //MARK: - Private methods
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        view.addSubview(searchBar)
        view.addSubview(episodeCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            logoImageView.heightAnchor.constraint(equalToConstant: 104)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 56),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchBar.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            episodeCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            episodeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            episodeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            episodeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100)
        ])
    }
    
    private func gettingData(URL url: String, completion: @escaping(Result<Episodes, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {data, response, error in
            guard let data = data else { return }
            do {
                let episodesArray = try JSONDecoder().decode(Episodes.self, from: data)
                completion(.success(episodesArray))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    private func fetchEpisodes() {
        gettingData(URL: Constants.mainUrl) { [weak self] result in
            switch result {
            case .success(let model):
                self?.episodesModel = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - UICollectionViewDelegate
extension EpisodeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.episodesModel?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cell, for: indexPath) as? EpisodeCollectionViewCustomCell,
        let episodes = episodesModel?.results else { return UICollectionViewCell() }
        let episode = episodes[indexPath.item]
        cell.configure(with: episode)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 357)
    }
}



