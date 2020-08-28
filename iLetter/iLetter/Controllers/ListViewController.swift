//
//  ListViewController.swift
//  iLetter
//
//  Created by Дарья on 24.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

struct LetterChat: Hashable {
    var username: String
    var userImage: UIImage
    var lastMessage: String
    var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LetterChat, rhs: LetterChat) -> Bool {
        return lhs.id == rhs.id
    }
}

class ListViewController: UIViewController {
    
    enum Section: Int, CaseIterable{
        case activeChat
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, LetterChat>?
    
    let activeChats: [LetterChat] = [LetterChat(username: "Драко Малфой", userImage: #imageLiteral(resourceName: "Малфой"), lastMessage: "Are you a mudblood?"), LetterChat(username: "Харли Квин", userImage: #imageLiteral(resourceName: "Харли"), lastMessage: "Где мой пудинг?"), LetterChat(username: "Морфеус", userImage: #imageLiteral(resourceName: "Морфиус"), lastMessage: "Red or blue?"), LetterChat(username: "Фаина Раневская", userImage: #imageLiteral(resourceName: "Раневская"), lastMessage: "Все сбудется, стоит только расхотеть")]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    
    private func setupSearchBar() {
        
        navigationController?.navigationBar.barTintColor = .buttonWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let search = UISearchController(searchResultsController: nil)
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        
        search.hidesNavigationBarDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
    }
    
    
    private func setupCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .buttonWhite()
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    private func createCompositionalLayout() -> UICollectionViewLayout{
        
        let layout = UICollectionViewCompositionalLayout{ (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(84))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
            
            return section
        }
        
        return layout
    }
    
    
    private func createDataSource(){ //создаем дату
        
        dataSource = UICollectionViewDiffableDataSource<Section, LetterChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, letter) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.row) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
                
            case .activeChat:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                cell.backgroundColor = .systemBlue
                return cell
            }
        })
    }
    
    
    private func reloadData(){
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, LetterChat>()
        dataSource?.apply(snapshot, animatingDifferences: true)
        snapshot.appendSections([.activeChat])
        snapshot.appendItems(activeChats, toSection: .activeChat)
    }
    
}



//MARK: UISearchBarDelegate

extension ListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


//MARK: UICollectionView Delegate & DataSource

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .blue
        
        return cell
    }
}


//MARK: SwiftUI
//Method for Canvas

import SwiftUI

struct ListVCProvider: PreviewProvider {
    
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)//  что привьюс будет показывать
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = MainTabBarController() // то что показывается в режиме кенвас
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) -> MainTabBarController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ListVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) {
            
        }
    }
}


