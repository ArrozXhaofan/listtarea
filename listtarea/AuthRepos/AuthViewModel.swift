//
//  AuthViewModel.swift
//  listtarea
//
//  Created by Jean L2 on 3/10/23.
//

import Foundation

final class AuthViewModel: ObservableObject {
    
    private let conexion: AuthRepository
    @Published var activedUser: User?
    @Published var messageError: String?
    
    init(conexion: AuthRepository = AuthRepository(), activedUser: User? = nil, messageError: String? = nil) {
        self.conexion = conexion
        self.activedUser = activedUser
        self.messageError = messageError
        
        getCurrentUser()
    }
    
    func login(email: String, pass: String) {
        
        conexion.login(email: email, pass: pass) { [weak self] result in
            
            switch result {
            case .success(let user):
                self?.activedUser = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    func register(email: String, pass: String, pass2: String) {
        
        if pass == pass2 {
            
            conexion.register(email: email, pass: pass) { [weak self] result in
                
                switch result {
                case .success(let user):
                    self?.activedUser = user
                    self?.messageError = nil
                case .failure(let error):
                    self?.messageError = error.localizedDescription
                }
                
            }
        } else {
            self.messageError = "Las contraseñas no coinciden."
        }
    }
    
    func logout() {
        
        do {
            _ = try conexion.logout()
            self.activedUser = nil
        } catch {
            print("Error al intentar cerrar sesion")
        }
        
    }
    
    func getCurrentUser() {
        self.activedUser = conexion.getCurrentUser()
    }

    
    
}
