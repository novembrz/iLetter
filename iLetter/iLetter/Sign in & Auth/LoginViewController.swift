//
//  LoginViewController.swift
//  iLetter
//
//  Created by Дарья on 23.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Welcome Back!", font: .avenir26())
    let googleLabel = UILabel(text: "Login with", font: .avenir20())
    let orLabel = UILabel(text: "or", font: .avenir20())
    let emailLabel = UILabel(text: "Email", font: .avenir20())
    let passwordLabel = UILabel(text: "Password", font: .avenir20())
    let needLabel = UILabel(text: "Need an account?", font: .avenir20())
    
    let emailTF = OneLineTextField(font: .avenir20())
    let passwordTF = OneLineTextField(font: .avenir20())
    
    let googleButton = UIButton(title: "Google", backgroundColor: .white, titleColor: .black, isShadow: true)
    let loginButton = UIButton(title: "Login", backgroundColor: .buttonDark(), titleColor: .white, isShadow: false)
    let signupButton = UIButton()
    
    weak var delegate: AuthNavigatingDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        googleButton.setGoogleIcon()
        
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.setTitleColor(.buttonGreen(), for: .normal)
        signupButton.titleLabel?.font = .avenir20()
        
        setupConstraints()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func loginButtonTapped() {
        AuthService.shared.login(email: emailTF.text, password: passwordTF.text) { (result) in
            switch result{
            case .success(_):
                self.createAlert(with: "Successful!", message: "You are sign in!")
                
            case .failure(let error):
                self.createAlert(with: "Error!", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func signupButtonTapped(){
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
    
}


//MARK: Setup constraints

extension LoginViewController {
    
    private func setupConstraints(){
        
        let buttonView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = UIStackView(arrangedSubviews: [emailLabel, emailTF], axis: .vertical, spacing: 2)
        let passwordView = UIStackView(arrangedSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 2)
        
        let stackView = UIStackView(arrangedSubviews: [buttonView, orLabel, emailView, passwordView, loginButton], axis: .vertical, spacing: 50)
        
        signupButton.contentHorizontalAlignment = .leading //чтобы кнопка прилегала к лейблу
        let signupView = UIStackView(arrangedSubviews: [needLabel, signupButton], axis: .horizontal, spacing: 10)
        signupView.alignment = .firstBaseline //чтобы кнопка прилегала к лейблу
        
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        signupView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(signupView)
        
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 75),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            signupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            signupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
    
}

//MARK: SwiftUI
//Method for Canvas

import SwiftUI

struct LoginVCProvider: PreviewProvider {
    
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)//  что привьюс будет показывать
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = LoginViewController() // то что показывается в режиме кенвас
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) -> LoginViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: LoginVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) {
            
        }
    }
}



