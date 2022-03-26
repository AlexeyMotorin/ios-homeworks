//
//  AnimationViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 23.03.2022.
//

import UIKit

class AnimationViewController: UIViewController {

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.alpha = 0
        view.isHidden = true
        view.backgroundColor = .white
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "photo@x2")
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.square.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal),
                                for: .normal)
        button.alpha = 0
        button.addTarget(self, action: #selector(closeButtonPassed), for: .touchUpInside)
        return button
    }()

    private var avatarImageTopConstraint: NSLayoutConstraint?
    private var avatarImageLeadingConstraint: NSLayoutConstraint?
    private var avatarImageHeightConstraint: NSLayoutConstraint?
    private var avatarImageWidthConstraint: NSLayoutConstraint?

    private var backgroundViewTopConstraint: NSLayoutConstraint?
    private var backgroundViewBottomConstraint: NSLayoutConstraint?
    private var backgroundViewLeadingConstraint: NSLayoutConstraint?
    private var backgroundViewTrailingConstraint: NSLayoutConstraint?

    private var isExpanded = false

    private let tapGestureRecogniser = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func setupView() {
        self.view.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 0.9146833609)
        self.view.addSubview(self.avatarImageView)
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.closeButton)
        self.view.bringSubviewToFront(self.avatarImageView)
        self.view.bringSubviewToFront(self.closeButton)
        
        self.avatarImageTopConstraint = self.avatarImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        self.avatarImageLeadingConstraint = self.avatarImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        self.avatarImageHeightConstraint = self.avatarImageView.heightAnchor.constraint(equalToConstant: 150)
        self.avatarImageWidthConstraint = self.avatarImageView.widthAnchor.constraint(equalToConstant: 150)
        
        self.backgroundViewTopConstraint = self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor)
        self.backgroundViewBottomConstraint = self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.backgroundViewLeadingConstraint = self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        self.backgroundViewTrailingConstraint = self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)

        NSLayoutConstraint.activate([
            self.avatarImageTopConstraint,
            self.avatarImageLeadingConstraint,
            self.avatarImageHeightConstraint,
            self.avatarImageWidthConstraint,
            self.backgroundViewTopConstraint,
            self.backgroundViewBottomConstraint,
            self.backgroundViewLeadingConstraint,
            self.backgroundViewTrailingConstraint,
            
            self.closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.closeButton.heightAnchor.constraint(equalToConstant: 50),
            self.closeButton.widthAnchor.constraint(equalToConstant: 50)
        ].compactMap({ $0 }))
    }

    private func setupGesture() {
        self.tapGestureRecogniser.numberOfTapsRequired = 1
        self.tapGestureRecogniser.addTarget(self, action: #selector(self.handleTapGesture(_:)))
        self.view.addGestureRecognizer(self.tapGestureRecogniser)
    }

    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecogniser === gestureRecognizer else { return }

        self.isExpanded.toggle()

        let avatarCenterYConstant = (view.safeAreaLayoutGuide.layoutFrame.size.height - UIScreen.main.bounds.width) / 2

        self.avatarImageTopConstraint?.constant = self.isExpanded ? avatarCenterYConstant : 20
        self.avatarImageLeadingConstraint?.constant = self.isExpanded ? 0 : 20
        self.avatarImageHeightConstraint?.constant = self.isExpanded ? UIScreen.main.bounds.width : 125
        self.avatarImageWidthConstraint?.constant = self.isExpanded ? UIScreen.main.bounds.width : 125

        if self.isExpanded {
            self.backgroundView.isHidden = false
            self.closeButton.isHidden = false
        }

        UIView.animate(withDuration: 0.3) {
            self.avatarImageView.layer.cornerRadius = self.isExpanded ? 0 : 62.5
            self.backgroundView.alpha = self.isExpanded ? 0.8 : 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.backgroundView.isHidden = !self.isExpanded
        }

        UIView.animate(withDuration: 0.3, delay: 0.2) {
            self.closeButton.alpha = self.isExpanded ? 1 : 0
        } completion: { _ in
            self.closeButton.isHidden = !self.isExpanded
        }
    }

    @objc func closeButtonPassed() {
        UIView.animate(withDuration: 0.3) {
            self.closeButton.isHidden = true
            self.backgroundView.alpha = 0
            self.avatarImageView.layer.cornerRadius = 62.5
            
            if self.isExpanded {
                self.avatarImageTopConstraint?.constant = 20
                self.avatarImageLeadingConstraint?.constant = 20
                self.avatarImageHeightConstraint?.constant = 125
                self.avatarImageWidthConstraint?.constant = 125
            }
            self.view.layoutIfNeeded()
        } 
    }
}

