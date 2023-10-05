//
//  ContentView.swift
//  listtarea
//
//  Created by Jean L2 on 30/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var conexionAuth: AuthViewModel
    @StateObject var conexion: DatabaseViewModel = DatabaseViewModel()
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                TaskView(conexion: conexion, conexionAuth: conexionAuth)
                
            }
            .navigationTitle("My tasks - \(conexionAuth.activedUser?.email ?? "No valido")")
            .navigationBarItems(
                leading:
                    Button(action: {
                        conexionAuth.logout()
                    }, label: {
                        Image(systemName: "power")
                            .foregroundColor(.red)
                    })
                , trailing:
                    NavigationLink(destination: CreatedView(conexion: conexion, conexionAuth: conexionAuth)) {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                    }
            
            )
            
        }
        
    }
}

#Preview {
    HomeView(conexionAuth: AuthViewModel())
        .preferredColorScheme(.dark)
}
