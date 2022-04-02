//
//  FullPhotoView.swift
//  Navigation
//
//  Created by Алексей Моторин on 33.03.2022.
//

import UIKit

class FullPhotoView: UIView {
    
    lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.square.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal),
                        for: .normal)
        button.addTarget(self, action: #selector(closeButtonPassed), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.backgroundColor = .white
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func set(image: String) {
        photoView.image = UIImage(named: image)
    }
    
    private func setupView() {
        self.addSubview(closeButton)
        self.addSubview(photoView)
        
        NSLayoutConstraint.activate([
            self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.closeButton.heightAnchor.constraint(equalToConstant: 50),
            self.closeButton.widthAnchor.constraint(equalToConstant: 50),
            
            self.photoView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            self.photoView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.photoView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.photoView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func closeButtonPassed() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
    }
}
