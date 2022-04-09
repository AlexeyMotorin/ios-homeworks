//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Алексей Моторин on 23.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    lazy var photoGalleryImages: UIImageView = {
        let photoGalleryImages = UIImageView()
        photoGalleryImages.clipsToBounds = true
        photoGalleryImages.translatesAutoresizingMaskIntoConstraints = false
        return photoGalleryImages
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.photoGalleryImages)
        
        NSLayoutConstraint.activate([
            self.photoGalleryImages.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.photoGalleryImages.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.photoGalleryImages.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            self.photoGalleryImages.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



