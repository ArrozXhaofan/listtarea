//
//  listtareaApp.swift
//  listtarea
//
//  Created by Jean L2 on 30/09/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct listtareaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var conexionAuth: AuthViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            if conexionAuth.activedUser == nil {
                MainView(conexion: conexionAuth)
                
            } else {
                HomeView(conexionAuth: conexionAuth)
            }

        }
    }
}
