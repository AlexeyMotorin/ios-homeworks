//
//  FullPhotoViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 31.03.2022.
//

import UIKit

class FullPhotoViewController: UIViewController {
    
    var photo: String? {
        didSet {
            guard let image = photo else { return }
            photoImageView.image = UIImage(named: image)
        }
    }
    
    private lazy var photoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            self.photoImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.photoImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.photoImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    
    
}
