//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Алексей Моторин on 23.03.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .black
        label.text = "Фотографии"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowView: UIImageView = {
        let arrow = UIImage(systemName: "arrow.right.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let arrowView = UIImageView()
        arrowView.image = arrow
        arrowView.clipsToBounds = true
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        return arrowView
    }()
    
    private lazy var photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var firstImageView: UIImageView = {
        let image = UIImage(named: "1")
        
        let imageCollectionView = UIImageView()
        imageCollectionView.image = image
        imageCollectionView.clipsToBounds = true
        imageCollectionView.contentMode = .scaleAspectFill
        imageCollectionView.layer.cornerRadius = 6
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return imageCollectionView
    }()
    private lazy var secondImageView: UIImageView = {
        let image = UIImage(named: "2")
        
        let imageCollectionView = UIImageView()
        imageCollectionView.image = image
        imageCollectionView.clipsToBounds = true
        imageCollectionView.contentMode = .scaleAspectFill
        imageCollectionView.layer.cornerRadius = 6
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return imageCollectionView
    }()
    private lazy var thirdImageView: UIImageView = {
        let image = UIImage(named: "3")
        
        let imageCollectionView = UIImageView()
        imageCollectionView.image = image
        imageCollectionView.clipsToBounds = true
        imageCollectionView.contentMode = .scaleAspectFill
        imageCollectionView.layer.cornerRadius = 6
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return imageCollectionView
    }()
    private lazy var fourImageView: UIImageView = {
        let image = UIImage(named: "4")
        
        let imageCollectionView = UIImageView()
        imageCollectionView.image = image
        imageCollectionView.clipsToBounds = true
        imageCollectionView.contentMode = .scaleAspectFill
        imageCollectionView.layer.cornerRadius = 6
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return imageCollectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.photosLabel)
        self.backView.addSubview(self.arrowView)
        self.backView.addSubview(self.photosStackView)
        self.photosStackView.addArrangedSubview(firstImageView)
        self.photosStackView.addArrangedSubview(secondImageView)
        self.photosStackView.addArrangedSubview(thirdImageView)
        self.photosStackView.addArrangedSubview(fourImageView)
        
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.photosLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 12.0),
            self.photosLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12.0),
            
            self.arrowView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12.0),
            self.arrowView.centerYAnchor.constraint(equalTo: self.photosLabel.centerYAnchor),
            self.arrowView.heightAnchor.constraint(equalTo: self.photosLabel.heightAnchor),
            self.arrowView.widthAnchor.constraint(equalTo: self.arrowView.heightAnchor, multiplier: 1.0),
            
            self.photosStackView.topAnchor.constraint(equalTo: self.photosLabel.bottomAnchor, constant: 12.0),
            self.photosStackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -12.0),
            self.photosStackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12.0),
            self.photosStackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12.0),
            
            self.firstImageView.heightAnchor.constraint(equalTo: self.firstImageView.widthAnchor, multiplier: 1.0)
        ])
        
    }
}
