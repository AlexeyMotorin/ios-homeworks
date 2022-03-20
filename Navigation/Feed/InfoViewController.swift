//
//  InfoViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 13.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var showAlertButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemGreen
        button.setTitle("Показать alert", for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(showAlertButton)
        activateConstraints()
    }
    
    private func activateConstraints() {
        self.showAlertButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.showAlertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.showAlertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.showAlertButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func showAlert() {
        let alert = UIAlertController(title: "Предупреждение",
                                      message: "Какое-то важное сообщение!",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Важное сообщение 1"),
                                      style: .default,
                                      handler: { _ in
                                                print("нажал ОК")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Отмена", comment: "Важное сообщение 2"),
                                      style: .cancel, handler: { _ in
                                                                print("нажал отмена")
        }))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}
