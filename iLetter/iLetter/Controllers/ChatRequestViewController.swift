//
//  ChatRequestViewController.swift
//  iLetter
//
//  Created by Дарья on 04.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class ChatRequestViewController: UIViewController {
    
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Зоя"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Zoe Kravitz", font: .systemFont(ofSize: 30, weight: .light))
    let aboutLabel = UILabel(text: "You have the opportunity to start a new chat", font: .systemFont(ofSize: 16, weight: .light))
    let acceptButton = UIButton(title: "ACCEPT", font: .laoSangamMN20(), backgroundColor: .black, titleColor: .white, cornerRadius: 30, isShadow: false)
    let denyButton = UIButton(title: "Deny", font: .laoSangamMN20(), backgroundColor: .buttonWhite(), titleColor: #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1), cornerRadius: 10, isShadow: false)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .buttonWhite()
        setupConstraints()
        constomizeElements()
    }
    
    private func constomizeElements(){
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        
        denyButton.layer.borderWidth = 1.2
        denyButton.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1)
        
        containerView.backgroundColor = .buttonWhite()
        containerView.layer.cornerRadius = 30
        
        aboutLabel.numberOfLines = 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.acceptButton.applyGradients(cornerRadius: 10)
    }
    

}

// MARK: - Setup constraints

extension ChatRequestViewController {
    private func setupConstraints(){
        
        let stackView = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 7)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(stackView)

        
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
            aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            aboutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
    }
}

// MARK: - SwiftUI

import SwiftUI

struct ChatRequestProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = ChatRequestViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ChatRequestProvider.ContainerView>) -> ChatRequestViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ChatRequestProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ChatRequestProvider.ContainerView>) {
            
        }
    }
}
