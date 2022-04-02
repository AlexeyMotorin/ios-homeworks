//
//  PostViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 13.02.2022.
//

import UIKit

class FeedPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemOrange
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showInfo))
    }
    
    @objc private func showInfo() {
        let info = InfoViewController()
        self.navigationController?.present(info,
                                           animated: true,
                                           completion: nil)
    }
}
