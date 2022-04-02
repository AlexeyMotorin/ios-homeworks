//
//  PostViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 31.03.2022.
//

import UIKit

class PostViewController: UIViewController {

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
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .light)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .light)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    func viewSetup() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(authorLabel)
        self.view.addSubview(postImageView)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(likesLabel)
        self.view.addSubview(viewsCountLabel)

        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20),

            self.postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            self.postImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.postImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.postImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),

            self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),

            self.likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            self.likesLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.likesLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            self.viewsCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            self.viewsCountLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.viewsCountLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        ])
    }
    
}
