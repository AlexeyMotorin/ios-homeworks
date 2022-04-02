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
    
    private lazy var labelAttention: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введено менее 6 символов пароля"
        label.textColor = .red
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private var delegate: LogInViewController?
    private var numberOfCharacters = 6
    
    private let login = "Login@mail.ru"
    private let password = "qwerty"
    
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
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            guard self.passwordTextField.text != "" else {return}
            guard self.passwordTextField.text?.count ?? 0 < numberOfCharacters else {
                self.labelAttention.isHidden = true
                return
            }
            self.labelAttention.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != "" else {
            textField.shake()
            return false
        }
        
        guard self.isValidEmail(self.loginTextField.text ?? "") else {
            self.falseEmailAlert()
            return true
        }
        
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
        self.contentView.addSubview(self.labelAttention)
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
            
            self.logInButton.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 25),
            self.logInButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.logInButton.heightAnchor.constraint(equalToConstant: 50),
            self.logInButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.labelAttention.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 5),
            self.labelAttention.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.labelAttention.heightAnchor.constraint(equalToConstant: 15),
            self.labelAttention.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])
    }
    
    @objc func buttonPressed() {
        logInButton.showAnimation {
            switch (self.loginTextField.text == "", self.passwordTextField.text == "") {
            case (true, false):
                self.loginTextField.shake()
                return
            case (false, true):
                self.passwordTextField.shake()
                return
            case (true, true):
                self.passwordTextField.shake()
                self.loginTextField.shake()
            case (false, false):
                guard self.isValidEmail(self.loginTextField.text ?? "") else {
                    self.falseEmailAlert()
                    return
                }
                self.loginTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
                self.showPrifileVC()
            }
        }
    }
        
    private func showPrifileVC() {
        guard self.loginTextField.text != "" else {
            self.loginTextField.shake()
            self.passwordTextField.shake()
            return
        }
        
        guard self.loginTextField.text == login && self.passwordTextField.text == password else {
            self.loginTextField.shake()
            self.passwordTextField.shake()
            let alert = UIAlertController(title: "Неверное имя пользователя или пароль",
                                          message: """
                                                    Повторите попытку

                                                    Login@mail.ru
                                                    qwerty"
                                                    """,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            self.present(alert,
                         animated: true)
            return
        }
        
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func falseEmailAlert() {
        let alert = UIAlertController(title: "Ошибка!",
                                      message: "Введите корректный email",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true)
    }
    
}


