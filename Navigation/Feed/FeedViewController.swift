//
//  FeedViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 13.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually // как будут распологаться вью внутри стека
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var firstPostButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitle("Показать пост", for: .normal)
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 0
        return button
    }()
    
    private lazy var SecondPostButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemGreen
        button.setTitle("Показать пост", for: .normal)
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
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
        self.setupButtonsStackView()
        
    }
    
    private func setupButtonsStackView() {
        self.view.addSubview(self.buttonsStackView)
        self.buttonsStackView.addArrangedSubview(firstPostButton)
        self.buttonsStackView.addArrangedSubview(SecondPostButton)
        
        NSLayoutConstraint.activate([
            self.buttonsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.buttonsStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.firstPostButton.heightAnchor.constraint(equalToConstant: 40),
            self.firstPostButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func showPost() {
        let showSelectedPost = PostViewController()
        self.navigationController?.pushViewController(showSelectedPost, animated: true)
        let myPost = Post(title: "Мой пост")
        showSelectedPost.navigationItem.title = myPost.title
    }
}
