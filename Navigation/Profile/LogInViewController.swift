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
            if let kbdSize = (nc.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let yPosition = kbdSize.height - 150
                self.loginScrollView.contentOffset = CGPoint(x: 0, y: yPosition)
                
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
                self.loginScrollView.contentOffset = .zero
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
                
        NSLayoutConstraint.activate([
            self.loginScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loginScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loginScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loginScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.loginScrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.loginScrollView.bottomAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: self.loginScrollView.centerXAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.loginScrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.loginScrollView.heightAnchor),
            
            self.logoImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.logoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120),

            self.logoImageView.heightAnchor.constraint(equalToConstant: 100),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            self.textFieldsStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.textFieldsStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.textFieldsStackView.heightAnchor.constraint(equalToConstant: 100),
            self.textFieldsStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.logInButton.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 16),
            self.logInButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.logInButton.heightAnchor.constraint(equalToConstant: 50),
            self.logInButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    @objc func buttonPressed() {
        logInButton.showAnimation {
            self.loginTextField.resignFirstResponder()
            self.showPrifileVC()
            self.passwordTextField.resignFirstResponder()
            
        }
    }
        
    private func showPrifileVC() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
