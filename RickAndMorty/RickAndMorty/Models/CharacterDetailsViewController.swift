//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 29.11.2023.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
    //MARK:- Constants
    private enum Constants {
        static let informations = "Informations"
        static let cell = "Cell"
        static let gender = "Gender"
        static let status = "Status"
        static let species = "Species"
        static let origin = "Origin"
        static let type = "Type"
        static let location = "Location"
        static let buttonImage = "buttonImage"
        static let goBackLabelText = "GO BACK"
        static let leftBarButtonImage = "leftBarButtonImage"
        static let rightBarButtonImage = "rightBarButtonImage"
    }
    
    //MARK:- UI
    private lazy var characterImageView: UIImageView = {
        let characterImageView = UIImageView()
        characterImageView.layer.cornerRadius = 75
        characterImageView.layer.masksToBounds = true
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        return characterImageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let characterNameLabel = UILabel()
        characterNameLabel.font = UIFont.systemFont(ofSize: 32)
        characterNameLabel.textAlignment = .center
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return characterNameLabel
    }()
    
    private lazy var informationsLabel: UILabel = {
        let informationsLabel = UILabel()
        informationsLabel.text = Constants.informations
        informationsLabel.font = UIFont.systemFont(ofSize: 20)
        informationsLabel.textColor = .informationsColor
        informationsLabel.translatesAutoresizingMaskIntoConstraints = false
        return informationsLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: Constants.cell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var cameraButton: UIButton = {
        let cameraButton = UIButton()
        cameraButton.setBackgroundImage(UIImage(named: Constants.buttonImage), for: .normal)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        return cameraButton
    }()
    
    private lazy var goBackLabel: UILabel = {
        let goBackLabel = UILabel()
        goBackLabel.text = Constants.goBackLabelText
        goBackLabel.font = UIFont.systemFont(ofSize: 18)
        goBackLabel.translatesAutoresizingMaskIntoConstraints = false
        return goBackLabel
    }()
    
    //MARK:- Private property
    private let character: Character
    
    //MARK:- Init
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        leftBarButtonImageSetup()
        rightBarButtonImageSetup()
        setupViews()
        setupConstraints()
        prepareData(with: character)
    }
    //MARK:- Private property
    private var userData: [UserDataModel] = []
    
    //MARK:- Private methods
    private func prepareData(with character: Character) {
        characterImageView.downloaded(from: character.image)
        characterNameLabel.text = character.name
        userData = [
            .init(titleName: Constants.gender, abailableInfo: character.gender),
            .init(titleName: Constants.status, abailableInfo: character.status),
            .init(titleName: Constants.species, abailableInfo: character.species),
            .init(titleName: Constants.origin, abailableInfo: character.origin.name),
            .init(titleName: Constants.type, abailableInfo: character.type),
            .init(titleName: Constants.location, abailableInfo: character.location.name)
        ]
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(characterImageView)
        view.addSubview(characterNameLabel)
        view.addSubview(informationsLabel)
        view.addSubview(tableView)
        view.addSubview(cameraButton)
        view.addSubview(goBackLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 147),
            characterImageView.heightAnchor.constraint(equalToConstant: 148)
        ])
        
        NSLayoutConstraint.activate([
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor,constant: 47.59),
            characterNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            informationsLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 18),
            informationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: informationsLabel.bottomAnchor,constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.heightAnchor.constraint(equalToConstant: 394)
        ])
        
        NSLayoutConstraint.activate([
            cameraButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 182),
            cameraButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -67),
            cameraButton.widthAnchor.constraint(equalToConstant: 32),
            cameraButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            goBackLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            goBackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 74)
        ])
    }
    
    private func leftBarButtonImageSetup() {
        var image = UIImage(named: Constants.leftBarButtonImage)
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: .some(#selector(back)))
    }
    
    private func rightBarButtonImageSetup() {
        var image = UIImage(named: Constants.rightBarButtonImage)
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: nil, action: nil)
    }
    
    // Public fuc
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK:- Extension
extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath) as? CustomTableViewCell {
            let detailInfo = userData[indexPath.row]
            cell.configure(with: detailInfo)
            return cell
        }
        return UITableViewCell()
    }
}
