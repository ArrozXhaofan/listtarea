//
//  HomeView.swift
//  listtarea
//
//  Created by Jean L2 on 3/10/23.
//

import SwiftUI

struct MainView: View {
    
    @State var txtUser = ""
    @State var txtPass = ""
    
    @State var sheetValue: Bool = false
    @State var isLoginLoading: Bool = false
    
    @ObservedObject var conexion: AuthViewModel
    
    var body: some View {
            
            VStack {
                
                Image(systemName: "books.vertical")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundColor(.pink)
                
                Text("Jean App")
                    .font(.system(size: 60))
                    .fontWeight(.light)
                
                VStack {
                    
                    HStack {
                        
                        VStack {
                            Text("Username")
                                .padding(.horizontal,10)
                        }
                        .frame(width: 100)
                        
                            .frame(height: 100)
                        TextField("Username", text: $txtUser)
                        
                    }
                    .frame(height: 45)
                    
                    HStack {
                        
                        VStack {
                            Text("Password")
                                .padding(.horizontal,10)
                        }
                        .frame(width: 100)
                        
                            .frame(height: 100)
                        SecureField("Password", text: $txtPass)
                        
                    }
                    .frame(height: 45)
                    
                }
                .frame(width: 350, height: 90)
                .cornerRadius(5)
                
                Button(action: {
                    isLoginLoading = !isLoginLoading
                    conexion.login(email: txtUser, pass: txtPass)
                    
                }, label: {
                    VStack {
                        if isLoginLoading {
                            ProgressView()
                        } else {
                            Text("Intro")
                                .foregroundStyle(.white)
                        }
                        
                    }
                    .frame(width: 60, height: 35)
                    .background(Color.pink)
                    .cornerRadius(5)
                    
                })
                .padding(.vertical,20)
                
                
                Spacer()
                
                Button(action: {
                    sheetValue = true
                    
                }, label: {
                    HStack {
                        Text("¿No tienes cuenta?")
                        Text("Create una cuenta")
                            .bold()
                            .underline()
                           
                    }
                    .foregroundStyle(.pink)
                })
                
            }
            .sheet(isPresented: $sheetValue, content: {
                
                RegisterView(conexion: conexion)
                    .presentationDetents([.medium])
                
            })
        }
}

#Preview {
    MainView(conexion: AuthViewModel())
        .preferredColorScheme(.dark)
}
