//
//  CustomTableViewCell.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 30.11.2023.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    //MARK: - UI
    private lazy var titledLabel: UILabel = {
        let titledLabel = UILabel()
        titledLabel.font = UIFont.systemFont(ofSize: 16)
        titledLabel.translatesAutoresizingMaskIntoConstraints = false
        return titledLabel
    }()
    
    private lazy var meaningLabel: UILabel = {
        let meaningLabel = UILabel()
        meaningLabel.textColor = .meaninglabelColor
        meaningLabel.font = UIFont.systemFont(ofSize: 14)
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        return meaningLabel
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViwes()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupViwes() {
        selectionStyle = .none
        contentView.addSubview(titledLabel)
        contentView.addSubview(meaningLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titledLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            titledLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            meaningLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            meaningLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            meaningLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    //MARK: - Public methods
    func configure(with model: UserDataModel) {
        titledLabel.text = model.titleName
        meaningLabel.text = model.abailableInfo
    }
}
