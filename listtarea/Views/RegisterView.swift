//
//  RegisterView.swift
//  listtarea
//
//  Created by Jean L2 on 3/10/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State var txtUser = ""
    @State var txtPass = ""
    @State var txtPassReply = ""
    
    @State var isLoadingRegister: Bool = false
    @Environment (\.dismiss) var dismiss
     
    @ObservedObject var conexion: AuthViewModel
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                    Image(systemName: "person.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .padding(.top,10)
                        .foregroundColor(.gray)
                
                Form {
                    Section {
                        TextField("Username", text: $txtUser)
                    }
                    
                    Section {
                        SecureField("Password", text: $txtPass)
                        SecureField("Same password", text: $txtPassReply)
                    } footer: {
                        Text(conexion.messageError ?? "")
                            .foregroundStyle(.red)
                    }
                }
                
                Spacer()
        
            }
            .navigationTitle("Register User")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: 
                                    Button("Cancelar"){
                dismiss()
                isLoadingRegister = false
                
            }, trailing: Button(action: {
                
                if conexion.messageError != nil {
                    
                    isLoadingRegister = false
                    print("error1")
                    
                } else if conexion.messageError == nil{
                    
                    isLoadingRegister = true
                    print("error2")
                }
            
                conexion.register(email: txtUser, pass: txtPass, pass2: txtPassReply)
                
            }, label: {
                
                if isLoadingRegister {
                    ProgressView()
                }else {
                    Text("Hecho")
                }
                
            }))
        }
        
        
    }
}

#Preview {
    RegisterView(conexion: AuthViewModel())
        .preferredColorScheme(.dark)
}
