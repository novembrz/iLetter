//
//  UIViewController + Extension.swift
//  iLetter
//
//  Created by Дарья on 01.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)") }
        cell.configure(with: value)
        return cell
    }
    
    func createAlert(with title: String, message: String, completion: @escaping () -> Void = {} ){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
