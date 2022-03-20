//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 13.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.register(PostTableViewCell.self,
                           forCellReuseIdentifier: "ArticleCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        return tableView
    }()
    
    
    let posts = [
        Post(author: "Motorin A.", description: "Мат в один ход, ход белых...", image: "OneMoveWhite", likes: 100, views: 100),
        Post(author: "Motorin A.", description: "Мат в два хода, ход белых", image: "twoMovesWhite", likes: 989, views: 1070),
        Post(author: "Motorin A.", description: "Снова задача на мат в два хода, ход белых...", image: "twoMoves2White", likes: 100, views: 100),
        Post(author: "Motorin A.", description: "Простенькая задача на мат в три хода, ход белых... еще мне надо кое что проверить, а именно: если будет много текста то label будет увеличиваться, а не появится вдруг что-то типа ... надеюсь все работает", image: "twoMovesWhite", likes: 567, views: 678)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Профиль"
        self.view.backgroundColor = .white
        
        self.view.addSubview(profileTableView)
        let topConst = self.profileTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor) // Верх
        let leadingConstr = self.profileTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor) // Лево
        let trailingConst = self.profileTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor) // Право
        let bottom = self.profileTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([topConst, leadingConstr, trailingConst, bottom])
        
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = ProfileHeaderView()
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        215
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
        
        let article = posts[indexPath.row]
        let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                    description: article.description,
                                                    image: article.image,
                                                    likes: article.likes,
                                                    views: article.views)
        cell.setup(with: viewModel)
        return cell
    }
    
}

