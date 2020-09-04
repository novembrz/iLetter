//
//  ProfileViewController.swift
//  iLetter
//
//  Created by Дарья on 03.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Малфой"), contentMode: .scaleAspectFill)
    let containerView = UIView()
    let nameLabel = UILabel(text: "Draco Malfoy", font: .systemFont(ofSize: 30, weight: .light))
    let aboutMeLabel = UILabel(text: "Slytherin, aristocrat and simply handsome", font: .systemFont(ofSize: 16, weight: .light))
    let messageTextField = MessageTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        constomizeElements()
        setupConstraints()
    }
    
    private func constomizeElements(){
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        aboutMeLabel.numberOfLines = 0
        containerView.backgroundColor = .buttonWhite()
        containerView.layer.cornerRadius = 30
        
        if let button = messageTextField.rightView as? UIButton{
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }

    }
    
    @objc private func sendMessage() {
        print(#function)
    }

}

// MARK: - Setup constraints

extension ProfileViewController {
    private func setupConstraints(){
        
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageTextField)
        containerView.addSubview(aboutMeLabel)
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            messageTextField.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 18),
            messageTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            messageTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            messageTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        
    }
}

// MARK: - SwiftUI

import SwiftUI

struct ProfileProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = ProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileProvider.ContainerView>) -> ProfileViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ProfileProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfileProvider.ContainerView>) {
            
        }
    }
}
