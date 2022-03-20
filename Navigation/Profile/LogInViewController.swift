//
//  LogInViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 20.03.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
        }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        return image
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 0
        textField.placeholder = " Email or Phone"
        textField.returnKeyType = UIReturnKeyType.continue
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 0
        textField.isSecureTextEntry = true
        textField.placeholder = " Password"
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.go
        textField.delegate = self
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(named: "ColorSet")
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private var delegate: LogInViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = -100
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = 0.0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            showPrifileVC()
            textField.endEditing(true)
            return true
        }
        textField.endEditing(true)
        return true
    }
    
    private func setupNavigationBar() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(loginScrollView)
        self.loginScrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.logInButton)
        self.contentView.addSubview(self.logoImageView)
        self.contentView.addSubview(self.textFieldsStackView)
        self.textFieldsStackView.addArrangedSubview(self.loginTextField)
        self.textFieldsStackView.addArrangedSubview(self.passwordTextField)
        
        
        let topConstrainLoginScroll = self.loginScrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leftConstrainLoginScroll = self.loginScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let rightComstrainLoginScroll = self.loginScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomComstrainLoginScroll = self.loginScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.loginScrollView.topAnchor)
        let contentViewBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.loginScrollView.bottomAnchor)
        let contentViewCenterXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.loginScrollView.centerXAnchor)
        let contentViewWidthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.loginScrollView.widthAnchor)
        let contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalTo: self.loginScrollView.heightAnchor)
        
        let centerXAnchorLogoImageView = self.logoImageView.centerXAnchor.constraint(equalTo: self.loginScrollView.centerXAnchor)
        let topConstrainLogoImageView = self.logoImageView.topAnchor.constraint(equalTo: self.loginScrollView.topAnchor, constant: 120)
        
        let heightLogoImageView = self.logoImageView.heightAnchor.constraint(equalToConstant: 100)
        let widthLogoImageView = self.logoImageView.widthAnchor.constraint(equalToConstant: 100)
        
        let topConstrainStackView = self.textFieldsStackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 120)
        let leftConstrainStackView = self.textFieldsStackView.leadingAnchor.constraint(equalTo: self.loginScrollView.leadingAnchor, constant: 16)
        let heightStackView = self.textFieldsStackView.heightAnchor.constraint(equalToConstant: 100)
        let centerXAnchorStackView = self.textFieldsStackView.centerXAnchor.constraint(equalTo: self.loginScrollView.centerXAnchor)
        
        let topConstrainButton = self.logInButton.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 16)
        let leftConstrainButton = self.logInButton.leadingAnchor.constraint(equalTo: self.loginScrollView.leadingAnchor, constant: 16)
        let heightButton = self.logInButton.heightAnchor.constraint(equalToConstant: 50)
        let centerXAnchorButton = self.logInButton.centerXAnchor.constraint(equalTo: self.loginScrollView.centerXAnchor)
        
        NSLayoutConstraint.activate([
            topConstrainLoginScroll,
            leftConstrainLoginScroll,
            rightComstrainLoginScroll,
            bottomComstrainLoginScroll,
            
            contentViewTopConstraint,
            contentViewBottomConstraint,
            contentViewWidthConstraint,
            contentViewHeightConstraint,
            contentViewCenterXConstraint,
            
            centerXAnchorLogoImageView,
            topConstrainLogoImageView,
            heightLogoImageView,
            widthLogoImageView,
            
            topConstrainStackView,
            leftConstrainStackView,
            heightStackView,
            centerXAnchorStackView,
            
            topConstrainButton,
            leftConstrainButton,
            heightButton,
            centerXAnchorButton
        ])
    }
    
    @objc func buttonPressed() {
        
        logInButton.showAnimation {
            self.showPrifileVC()
            self.passwordTextField.resignFirstResponder()
          }
        
    }
    
    private func showPrifileVC() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
        navigationController?.navigationBar.isHidden = true
    }
    
}
