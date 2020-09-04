//
//  AuthService.swift
//  iLetter
//
//  Created by Дарья on 04.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AuthService{
    
    static let shared = AuthService()
    private var auth = Auth.auth()
    
    func register(email: String?, password: String?, confirfPassword: String?, completion: @escaping (Result<User, Error>) -> Void){
        auth.createUser(withEmail: email!, password: password!) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void){
        auth.signIn(withEmail: email!, password: password!) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
}
