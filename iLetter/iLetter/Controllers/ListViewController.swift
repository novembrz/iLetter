//
//  ListViewController.swift
//  iLetter
//
//  Created by Дарья on 24.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

struct LetterChat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LetterChat, rhs: LetterChat) -> Bool {
        return lhs.id == rhs.id
    }
}

class ListViewController: UIViewController {
    
    enum Section: Int, CaseIterable{
        case waitingChat, activeChat
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, LetterChat>?
    
    let activeChats = Bundle.main.decode([LetterChat].self, from: "activeChats.json")
    let waitingChats = Bundle.main.decode([LetterChat].self, from: "waitingChats.json")
    
    
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
        
        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reuseId)
        collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.reuseId)
        
        view.addSubview(collectionView)
    }
    
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, LetterChat>()
        
        snapshot.appendSections([.waitingChat, .activeChat])
        
        snapshot.appendItems(waitingChats, toSection: .waitingChat)
        snapshot.appendItems(activeChats, toSection: .activeChat)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
}


// MARK: - Data Sourse

extension ListViewController{
    
    private func configure<T: SelfConfiguringCell>(cellType: T.Type, with value: LetterChat, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)") }
        cell.configure(with: value)
        
        return cell
    }
    
    private func createDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section, LetterChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unknown section kind")
        }
            
            switch section {
            case .activeChat:
                return self.configure(cellType: ActiveChatCell.self, with: chat, for: indexPath)
            case .waitingChat:
                return self.configure(cellType: WaitingChatCell.self, with: chat, for: indexPath)
            }
        })
    }
}

// MARK: - Setup layout

extension ListViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }
        
            switch section {
            case .activeChat:
                return self.createActiveChats()
            case .waitingChat:
                return self.createWaitingChats()
            }
            
        }
        
        return layout
    }
    
    
    private func createWaitingChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20 //отступы
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous // чтобы были горизонтал без падингов
        
        return section
    }
    
    
    private func createActiveChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        
        return section
        
    }
}

    
//MARK: UISearchBarDelegate

extension ListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
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


