//
//  AuthViewController.swift
//  iLetter
//
//  Created by Дарья on 04.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit
import GoogleSignIn

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)
    
    let socialLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign up with")
    let alreadyOnboardLabel = UILabel(text: "Alerady onboard?")
    
    let googleButton = UIButton(title: "Google", backgroundColor: .white, titleColor: .black, isShadow: true)
    let facebookButton = UIButton(title: "Facebook", backgroundColor: .white, titleColor: .black, isShadow: true)
    let emailButton = UIButton(title: "Email", backgroundColor: .buttonDark(), titleColor: .white, isShadow: false)
    let loginButton = UIButton(title: "Login", backgroundColor: .white, titleColor: .buttonGreen(), isShadow: true)
    
        
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginVC.delegate = self
        signUpVC.delegate = self
        
        GIDSignIn.sharedInstance()?.delegate = self
        

        googleButton.setGoogleIcon()
        view.backgroundColor = .white
        setupConstraints()
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
    }
    
    @objc private func emailButtonTapped() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTapped() {
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc private func googleButtonTapped() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }

}

// MARK: - Setup constraints

extension AuthViewController {
    
    private func setupConstraints() {
        
        socialLabel.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let socialStackView = UIStackView(arrangedSubviews: [googleButton, facebookButton], axis: .horizontal, spacing: 7)
        socialStackView.translatesAutoresizingMaskIntoConstraints = false
        socialStackView.distribution = .fillEqually
        
        let socialView = UIStackView(arrangedSubviews: [socialLabel, socialStackView], axis: .vertical, spacing: 20)
        
        
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: alreadyOnboardLabel, button: loginButton)
    
        let stackView = UIStackView(arrangedSubviews: [socialView, emailView, loginView], axis: .vertical, spacing: 50)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            googleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - AuthNavigatingDelegate

extension AuthViewController: AuthNavigatingDelegate{
    func toSignUpVC() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
}


// MARK: - Google SignInDelegate

extension AuthViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        AuthService.shared.googleSignIn(user: user, error: error) { (result) in
            switch result{
            case .success(_):
                self.createAlert(with: "Successful!", message: "You are registered!") {
                    let mainTBC = MainTabBarController()
                    mainTBC.modalPresentationStyle = .fullScreen
                    self.present(mainTBC, animated: true, completion: nil)
                }
                
            case .failure(let error):
                self.createAlert(with: "Error!", message: error.localizedDescription)
            }
        }
    }
}


// MARK: - FB LoginButtonDelegate




// MARK: - SwiftUI

import SwiftUI

struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AuthVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) {
            
        }
    }
}
