//
//  PeopleViewController.swift
//  iLetter
//
//  Created by Дарья on 24.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    let users = Bundle.main.decode([LetterUser].self, from: "users.json")
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, LetterUser>!
    
    enum Section: Int, CaseIterable {
        case users
        func description(usersCount: Int) -> String {
            switch self {
            case .users:
                return "\(usersCount) people nearby"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .buttonWhite()
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
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        
        view.addSubview(collectionView)
    }
    
    
    private func reloadData() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, LetterUser>()
        snapshot.appendSections([.users])
        snapshot.appendItems(users, toSection: .users)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

}


// MARK: - Data Sourse

extension PeopleViewController{
    
    private func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, LetterUser>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            
            switch section{
            case .users:
                return self.configure(collectionView: collectionView, cellType: UserCell.self, with: user, for: indexPath)
            }
            
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header") }
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            
            let items = self.dataSource.snapshot().itemIdentifiers(inSection: .users)
            
            sectionHeader.configure(text: section.description(usersCount: items.count), textColor: .label, font: .systemFont(ofSize: 36, weight: .light))
            
            return sectionHeader
        }
    }
    
}

// MARK: - Setup layout

extension PeopleViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
        
            switch section {
            case .users:
                return self.createUsersSection()
            }
            
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    
    private func createUsersSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(15)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 15, bottom: 0, trailing: 15)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
    
}

//MARK: UISearchBarDelegate

extension PeopleViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


//MARK: SwiftUI
//Method for Canvas

import SwiftUI

struct PeopleVCProvider: PreviewProvider {
    
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)//  что привьюс будет показывать
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = MainTabBarController() // то что показывается в режиме кенвас
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PeopleVCProvider.ContainerView>) -> MainTabBarController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: PeopleVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PeopleVCProvider.ContainerView>) {
            
        }
    }
}


