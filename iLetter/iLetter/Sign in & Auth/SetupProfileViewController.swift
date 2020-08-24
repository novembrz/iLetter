//
//  SetupProfileViewController.swift
//  iLetter
//
//  Created by Дарья on 24.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    let setupLabel = UILabel(text: "Set up profile", font: .avenir26())
    
    let avatarView = AddPhotoView()
    
    let nameLabel = UILabel(text: "Full name", font: .avenir20())
    let aboutLabel = UILabel(text: "About me", font: .avenir20())
    let sexLabel = UILabel(text: "Sex", font: .avenir20())
    
    let nameTF = OneLineTextField(font: .avenir20())
    let aboutTF = OneLineTextField(font: .avenir20())
    
    let lettersButton = UIButton(title: "Go to letters!", backgroundColor: .buttonGreen(), titleColor: .buttonWhite(), isShadow: false)
    let sexSegmented = UISegmentedControl(first: "Man", second: "Woman")

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupConstraints()
    }

}


//MARK: Set up Constraints

extension SetupProfileViewController{
    
    private func setupConstraints(){
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTF], axis: .vertical, spacing: 2)
        let aboutStackView = UIStackView(arrangedSubviews: [aboutLabel, aboutTF], axis: .vertical, spacing: 2)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmented], axis: .vertical, spacing: 20)
        
        let stackView = UIStackView(arrangedSubviews: [nameStackView, aboutStackView, sexStackView, lettersButton], axis: .vertical, spacing: 50)
        
        setupLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(setupLabel)
        view.addSubview(avatarView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            setupLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            setupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.topAnchor.constraint(equalTo: setupLabel.bottomAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            lettersButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
    }
}


//MARK: SwiftUI
//Method for Canvas

import SwiftUI

struct SetupProfileVCProvider: PreviewProvider {
    
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)//  что привьюс будет показывать
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SetupProfileViewController() // то что показывается в режиме кенвас
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) -> SetupProfileViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: SetupProfileVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) {
            
        }
    }
}

