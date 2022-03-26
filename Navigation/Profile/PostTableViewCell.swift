//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Алексей Моторин on 20.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        let author: String
        let description: String
        let image: String
        let likes: Int
        let views: Int
    }
    
    private let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        return authorLabel
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private let likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .light)
        likesLabel.textColor = .black
        likesLabel.numberOfLines = 1
        likesLabel.textAlignment = .left
        return likesLabel
    }()
    
    private let viewsCountLabel: UILabel = {
        let viewsCountLabel = UILabel()
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsCountLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .light)
        viewsCountLabel.textColor = .black
        viewsCountLabel.numberOfLines = 1
        viewsCountLabel.textAlignment = .right
        return viewsCountLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewSetup()
    }
    
    func viewSetup() {
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(postImageView)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(likesLabel)
        self.contentView.addSubview(viewsCountLabel)
        
        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 20),
   
            self.postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            self.postImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.postImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.75),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -16),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 16),
            
            self.likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            self.likesLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.likesLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.likesLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            
            self.viewsCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            self.viewsCountLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.viewsCountLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.viewsCountLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
}

extension PostTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        
        self.authorLabel.text = viewModel.author
        self.descriptionLabel.text = viewModel.description
        self.postImageView.image = UIImage(named: viewModel.image)
        self.likesLabel.text = "Likes: \(String(viewModel.likes))"
        self.viewsCountLabel.text = "Views: \(String(viewModel.views))"
        
    }
}
