 //
//  AuthDataSource.swift
//  listtarea
//
//  Created by Jean L2 on 3/10/23.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

final class AuthDataSource {
    
    func login(email: String, pass: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: pass) { authDataResult, error in
            
            if let realError = error {
                print("Ocurrio un error con Firesbase: \(realError.localizedDescription)")
                completionBlock(.failure(realError))
                return
            }
            
            let user = authDataResult?.user.email ?? "User no valido"
            completionBlock(.success(.init(email: user)))
        }
        
    }
    
    func register(email: String, pass: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
            Auth.auth().createUser(withEmail: email, password: pass) { authDataResult, error in
                
                if let realError = error {
                    print("Ocurrio un error con Firesbase: \(realError.localizedDescription)")
                    completionBlock(.failure(realError))
                    return
                }
                
                
                
                let user = authDataResult?.user.email ?? "User no valido"
                completionBlock(.success(.init(email: user)))
            }
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func getCurrentUser() -> User? {
        
        guard let realUser = Auth.auth().currentUser?.email else {
            return nil
        }
        
        return .init(email: realUser)
    }
    
}
