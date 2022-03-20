//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Алексей Моторин on 12.03.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol {
    func didTapStatusButtton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}


class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.image = UIImage(named: "photo@x2")
        avatarImage.layer.cornerRadius = 65
        avatarImage.layer.borderWidth = 3
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.borderColor = UIColor.white.cgColor
        return avatarImage
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullName = UILabel()
        fullName.translatesAutoresizingMaskIntoConstraints = false
        fullName.text = "Моторин Алексей"
        fullName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return fullName
    }()
    
    private lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Waiting for something..."
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        status.numberOfLines = 0
        return status
    }()
    
    private lazy var statusTextField: UITextField = {
        let statusText = UITextField()
        statusText.translatesAutoresizingMaskIntoConstraints = false
        statusText.isHidden = true
        statusText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusText.textColor = .black
        statusText.backgroundColor = .white
        statusText.layer.borderColor = UIColor.black.cgColor
        statusText.layer.borderWidth = 1
        statusText.layer.cornerRadius = 12
        statusText.clearButtonMode = .always
        statusText.addTarget(self, action: #selector(ProfileHeaderView.statusTextChanged(_:)), for: .editingChanged)
        statusText.placeholder = " Enter something..."
        statusText.delegate = self
        statusText.returnKeyType = UIReturnKeyType.go
        return statusText
    }()
    
    private lazy var setStatusButton: UIButton = {
        let setStatus = UIButton()
        setStatus.translatesAutoresizingMaskIntoConstraints = false
        setStatus.backgroundColor = .systemBlue
        setStatus.layer.cornerRadius = 12
        setStatus.layer.shadowOffset.width = 4
        setStatus.layer.shadowOffset.height = 4
        setStatus.layer.shadowRadius = 4
        setStatus.layer.shadowColor = UIColor.black.cgColor
        setStatus.layer.shadowOpacity = 0.7
        setStatus.setTitle("Show Status", for: .normal)
        setStatus.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return setStatus
    }()
    
    
    private lazy var labelsAndImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var buttonTopConstrain: NSLayoutConstraint?
    
    var delegate: ProfileHeaderViewProtocol?
    
    private var statusText = "Waiting for something..."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        self.backgroundColor = .lightGray
        
        self.addSubview(self.setStatusButton)
        self.addSubview(self.labelsAndImageStackView)
        self.labelsAndImageStackView.addArrangedSubview(self.avatarImageView)
        self.labelsAndImageStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
        
        self.activationOfConstraintsWithoutTextFeld()
        
    }
    
    @objc private func buttonPressed() {
        self.setStatus()
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        self.statusLabel.text = textField.text
        if let text = textField.text {
            self.statusText = text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.setStatus()
        return true
    }
    
    private func setStatus() {
        if self.statusTextField.isHidden {
            self.addSubview(self.statusTextField)
            self.setStatusButton.setTitle("Set status", for: .normal)
            activationOfConstraintsWithTextFeld()
            statusTextField.endEditing(true)
        } else {
            self.setStatusButton.setTitle("Change status", for: .normal)
            activationOfConstraintsWithoutTextFeld()
            statusTextField.endEditing(true)
        }
        self.delegate?.didTapStatusButtton(textFieldIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
        statusLabel.text = self.statusText
        
        if statusLabel.text == "" {
            statusLabel.text = "Waiting for something..."
        }
    }
    
    private func activationOfConstraintsWithTextFeld() {
        self.buttonTopConstrain?.isActive = false
        
        let topConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.labelsAndImageStackView.bottomAnchor, constant: 10)
        let leadingConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
        let trailingConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.labelsAndImageStackView.trailingAnchor)
        let heightTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        self.buttonTopConstrain = self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 20)
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            heightTextFieldConstraint,
            self.buttonTopConstrain
        ].compactMap({ $0 }))
    }
    
    private func activationOfConstraintsWithoutTextFeld() {
        self.buttonTopConstrain?.isActive = false
        let topConstrainOflabelsAndImageStackView = self.labelsAndImageStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingConstrainOflabelsAndImageStackView = self.labelsAndImageStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstrainOflabelsAndImageStackView = self.labelsAndImageStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        
        self.buttonTopConstrain = self.setStatusButton.topAnchor.constraint(equalTo: self.labelsAndImageStackView.bottomAnchor, constant: 16)
        self.buttonTopConstrain?.priority = UILayoutPriority(rawValue: 999)
        
        let leadingConstrainOfSetStatusButton = self.setStatusButton.leadingAnchor.constraint(equalTo: self.labelsAndImageStackView.leadingAnchor)
        let trailingConstrainOfSetStatusButton = self.setStatusButton.trailingAnchor.constraint(equalTo: self.labelsAndImageStackView.trailingAnchor)
        let bottomConstrainOfSetStatusButton = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        let heightConstrainOfSetStatusButton = self.setStatusButton.heightAnchor.constraint(equalToConstant: 40)
        
        let imageViewAspectRatio = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        
        NSLayoutConstraint.activate([
            topConstrainOflabelsAndImageStackView,
            leadingConstrainOflabelsAndImageStackView,
            trailingConstrainOflabelsAndImageStackView,
            
            imageViewAspectRatio,
            
            buttonTopConstrain,
            leadingConstrainOfSetStatusButton,
            trailingConstrainOfSetStatusButton,
            bottomConstrainOfSetStatusButton,
            heightConstrainOfSetStatusButton
        ].compactMap({ $0 }))
    }
}
