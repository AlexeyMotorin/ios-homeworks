//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Алексей Моторин on 01.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var textFieldStatus: UITextField!
    @IBOutlet weak var buttonStatus: UIButton!
    
    
    @IBOutlet weak var buttonTostackViewconstrain: NSLayoutConstraint!
    @IBOutlet weak var avatarButtonConstrain: NSLayoutConstraint!

    private var isExpanded = true
    private var statusText = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        self.backgroundColor = .lightGray
        let profileView = self.loadProfileHeaderView()
        self.addSubview(profileView)
        profileView.frame = self.bounds
        textFieldStatus.isHidden = true
        avatarSetup()
        buttonSetup()
        
    }
    
    private func loadProfileHeaderView() -> UIView {
        guard let view = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)?.first as? UIView else { return UIView() }
        return view
    }
    
    private func avatarSetup() {
        self.avatarImage.layer.cornerRadius = 90
        self.avatarImage.layer.borderWidth = 5
        self.avatarImage.layer.borderColor = UIColor.white.cgColor
    }
    
    private func buttonSetup() {
        self.buttonStatus.layer.cornerRadius = 4
        self.buttonStatus.layer.shadowOffset.width = 4
        self.buttonStatus.layer.shadowOffset.height = 4
        self.buttonStatus.layer.shadowRadius = 4
        self.buttonStatus.layer.shadowColor = UIColor.black.cgColor
        self.buttonStatus.layer.shadowOpacity = 0.7
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if isExpanded {
            self.avatarButtonConstrain.constant = 70
            self.buttonTostackViewconstrain.constant = 88
            self.textFieldStatus.isHidden = false
            self.buttonStatus.setTitle("Установить статус", for: .normal)
        } else {
            self.avatarButtonConstrain.constant = 16
            self.buttonTostackViewconstrain.constant = 34
            self.textFieldStatus.isHidden = true
            self.textFieldStatus.resignFirstResponder()
            self.statusLabel.text = statusText
        }
        
        if statusLabel.text == "" {
            statusLabel.text = "Waiting for something..."
        }
        
//        UIView.animate(withDuration: 2.0) {
//            self.setNeedsLayout()
//        } completion: { _ in
//            self.isExpanded.toggle()
//        }
        
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        } completion: { _ in
            self.isExpanded.toggle()
        }
        
    }
    
    
    @IBAction func statusTextChanged(_ sender: UITextField) {
        self.statusLabel.text = sender.text
        if let text = sender.text {
            statusText = text
        }
    }
    
    
}
