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
import GoogleSignIn

class AuthService{
    
    static let shared = AuthService()
    private var auth = Auth.auth()
    
    
    func googleSignIn(user: GIDGoogleUser!, error: Error!, completion: @escaping (Result<User, Error>) -> Void){
        
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let authUser = user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: authUser.idToken, accessToken: authUser.accessToken)
        
        auth.signIn(with: credential) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void){
        
        guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard password!.lowercased() == confirmPassword!.lowercased() else {
            completion(.failure(AuthError.passwordsNotMatched))
            return
        }
        
        guard Validators.isSimpleEmail(email!) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        auth.createUser(withEmail: email!, password: password!) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void){
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        auth.signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
}
