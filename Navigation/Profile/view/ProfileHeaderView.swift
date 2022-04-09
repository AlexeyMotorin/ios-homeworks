//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Алексей Моторин on 12.03.2022.
//

import UIKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    lazy var avatarImageView: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.image = UIImage(named: "photo@x2")
        avatarImage.layer.cornerRadius = 65
        avatarImage.layer.borderWidth = 3
        avatarImage.layer.masksToBounds = true
        avatarImage.isUserInteractionEnabled = true
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
        status.textColor = #colorLiteral(red: 0.1770116687, green: 0.1401267052, blue: 0.1381770968, alpha: 0.6206281043)
        status.numberOfLines = 0
        return status
    }()
    
    private lazy var statusTextField: UITextField = {
        let statusText = UITextField()
        statusText.translatesAutoresizingMaskIntoConstraints = false
        statusText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusText.textColor = .black
        statusText.backgroundColor = .white
        statusText.layer.borderColor = UIColor.black.cgColor
        statusText.layer.borderWidth = 1
        statusText.layer.cornerRadius = 12
        statusText.clearButtonMode = .always
        statusText.addTarget(self, action: #selector(ProfileHeaderView.statusTextChanged(_:)), for: .editingChanged)
        statusText.placeholder = "  Set your status..."
        statusText.delegate = self
        statusText.returnKeyType = UIReturnKeyType.go
        return statusText
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.setTitle("Set status", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileStackView: UIStackView = {
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
    
    private var statusText = "Waiting for something..."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.addSubview(self.setStatusButton)
        self.addSubview(self.profileStackView)
        self.addSubview(self.statusTextField)
        self.profileStackView.addArrangedSubview(self.avatarImageView)
        self.profileStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
        self.labelsStackView.addArrangedSubview(self.statusTextField)
        
        NSLayoutConstraint.activate([
            self.profileStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.profileStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.profileStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.setStatusButton.topAnchor.constraint(equalTo: self.profileStackView.bottomAnchor, constant: 16),
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.profileStackView.leadingAnchor),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.profileStackView.trailingAnchor),
            self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        ])
        
    }
    
    
    @objc func statusTextChanged(_ textField: UITextField) {
        self.statusLabel.text = textField.text
        if let text = textField.text {
            self.statusText = text
        }
    }
    
    @objc private func buttonPressed() {
        setStatusButton.showAnimation {
            guard self.statusTextField.text != "" else {
                self.statusTextField.shake()
                self.changeStatusTextField()
                self.statusLabel.text = "Waiting for something..."
                return
            }
            
            self.statusTextField.endEditing(true)
            self.checkStatus()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        statusTextField.endEditing(true)
        checkStatus()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        statusTextField.text = ""
    }
    
    private func checkStatus() {
        
        if self.statusLabel.text == "" {
            self.statusLabel.text = "Waiting for something..."
            changeStatusTextField()
            self.statusTextField.shake()
        }
        self.statusTextField.layer.borderColor = UIColor.black.cgColor
        self.statusTextField.backgroundColor = .white
    }
    
    private func changeStatusTextField() {
        self.statusTextField.layer.borderColor = UIColor.red.cgColor
        self.statusTextField.backgroundColor = .systemYellow
    }
    
}

