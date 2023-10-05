//
//  AuthRepository.swift
//  listtarea
//
//  Created by Jean L2 on 3/10/23.
//

import Foundation

final class AuthRepository {
    
    private let conexion: AuthDataSource
    
    init(conexion: AuthDataSource = AuthDataSource()) {
        self.conexion = conexion
    }
    
    func login(email: String, pass: String, completionBlock: @escaping (Result<User,Error>) -> Void) {
        conexion.login(email: email, pass: pass, completionBlock: completionBlock)
    }
    
    func register(email: String, pass: String, completionBlock: @escaping (Result<User,Error>) -> Void) {
        conexion.register(email: email, pass: pass, completionBlock: completionBlock)
    }
    
    func logout() throws {
        try conexion.logout()
    }
    
    func getCurrentUser() -> User? {
        conexion.getCurrentUser()
    }

    
}
