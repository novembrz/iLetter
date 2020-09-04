//
//  SignUpViewController.swift
//  iLetter
//
//  Created by Дарья on 23.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let helloLabel = UILabel(text: "Dasha! Hello!", font: .avenir26())
    
    let alreadyLabel = UILabel(text: "Already onboard?", font: .avenir20())
    let emailLabel = UILabel(text: "Email", font: .avenir20())
    let passwordLabel = UILabel(text: "Password", font: .avenir20())
    let confirmPasswordLabel = UILabel(text: "Confirm password", font: .avenir20())
    
    let emailTF = OneLineTextField(font: .avenir20())
    let passwordTF = OneLineTextField(font: .avenir20())
    let confirmPasswordTF = OneLineTextField(font: .avenir20())
    
    let signupButton = UIButton(title: "Sign up", backgroundColor: .buttonGreen(), titleColor: .white, isShadow: false)
    let loginButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.buttonGreen(), for: .normal)
        loginButton.titleLabel?.font = .avenir20()
        
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.signupButton.applyGradients(cornerRadius: 10)
    }
    
}


//MARK: Setup constraints

extension SignUpViewController{
    
    private func setupConstraints(){
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTF], axis: .vertical, spacing: 2)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 2)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTF], axis: .vertical, spacing: 2)
        
        signupButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loginButton.contentHorizontalAlignment = .leading //чтобы кнопка прилегала к лейблу
        
        let stackView = UIStackView(arrangedSubviews: [emailStackView, passwordStackView, confirmPasswordStackView, signupButton], axis: .vertical, spacing: 40)
        let buttonStackView = UIStackView(arrangedSubviews: [alreadyLabel, loginButton], axis: .horizontal, spacing: 10)
        buttonStackView.alignment = .firstBaseline //чтобы кнопка прилегала к лейблу
        
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(helloLabel)
        view.addSubview(stackView)
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 110),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 120),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}


//MARK: SwiftUI
//Method for Canvas

import SwiftUI

struct SignUpVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let signUpVC = SignUpViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) -> SignUpViewController {
            return signUpVC
        }
        
        func updateUIViewController(_ uiViewController: SignUpVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) {
            
        }
    }
}

