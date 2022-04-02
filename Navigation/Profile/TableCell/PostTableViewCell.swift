//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Алексей Моторин on 20.03.2022.
//

import UIKit

protocol PostTableViewCellDelegate {
    func setLike(_ number : Int)
}

class PostTableViewCell: UITableViewCell {
    
    var post: Post?  {
        didSet{
            authorLabel.text = post?.author
            postImageView.image = UIImage(named: post?.image ?? "Error")
            descriptionLabel.text = post?.description
            likesLabel.text = "Likes: \(post?.likes ?? 0)"
            viewsCountLabel.text = "Views: \(post?.views ?? 0)"
        }
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
        likesLabel.isUserInteractionEnabled = true
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
    
    var delegate: PostTableViewCellDelegate?
    
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunc))
        tap.numberOfTapsRequired = 1
        likesLabel.addGestureRecognizer(tap)
        
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
    
    @objc private func tapFunc() {
        post?.likes += 1
        let like = post?.likes ?? 0
        self.delegate?.setLike(like)
    }
}

