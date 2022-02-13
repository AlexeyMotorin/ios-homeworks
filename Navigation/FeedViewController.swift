//
//  FeedViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 13.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private lazy var showPostButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemGreen
        button.setTitle("Показать пост", for: .normal)
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(showPostButton)
        self.activateConstraints()
        
    }

    private func activateConstraints() {
        self.showPostButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.showPostButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.showPostButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.showPostButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func showPost() {
        let showSelectedPost = PostViewController()
        self.navigationController?.pushViewController(showSelectedPost, animated: true)
        let myPost = Post(title: "Мой пост")
        showSelectedPost.navigationItem.title = myPost.title
    }
}
