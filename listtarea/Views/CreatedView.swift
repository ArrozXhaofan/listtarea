//
//  CreatedView.swift
//  listtarea
//
//  Created by Jean L2 on 3/10/23.
//

import SwiftUI



struct CreatedView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @ObservedObject var conexion: DatabaseViewModel
    @ObservedObject var conexionAuth: AuthViewModel
    
    @State var txtTitle = ""
    @State var txtDescription = ""
    @State var txtDatePickerCreated: Date = Date.now
    @State var txtDatePickerEnd: Date = Date.now
    @State var isOnReady: Bool = false
    @State var isOnFavorited: Bool = false
    @State var isOnActived: Bool = false
    
    var body: some View {
        
        VStack {
            
            TextField("Title", text: $txtTitle)
                .font(.system(size: 40))
                .bold()
                .tint(.yellow)
                .padding(.bottom, 10)
            
            TextEditor(text: $txtDescription)
                .font(.system(size: 20))
                .fontWeight(.light)
                .tint(.yellow)
                .padding(.bottom, 10)
                .frame(height: 200)
            
            
            
            Form {
                
                Section {
                    DatePicker("Created date", selection: $txtDatePickerCreated)
                        .disabled(true)
                        .foregroundColor(.gray)
                    
                    DatePicker("End date", selection: $txtDatePickerEnd)
                }
                
                Section {
                    
                    Toggle("Ready", isOn: $isOnReady)
                    Toggle("Active", isOn: $isOnActived)
                    Toggle("Favorite", isOn: $isOnFavorited)
                }
            }
             
            Spacer()
        }
        .navigationTitle("New task")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button("Done", action: {
            
            conexion.createNewTask(newTask:
                 Taskete(
                    idMember: conexionAuth.activedUser?.email,
                    title: txtTitle,
                    description: txtDescription,
                    dateCreated: String(describing: txtDatePickerCreated),
                    dateEnd: String(describing: txtDatePickerEnd),
                    isReady: isOnReady,
                    isFavorited: isOnFavorited,
                    isActived: isOnActived))
            
            dismiss()
    
        }))
        .tint(.yellow)
        
        
    }
}

#Preview {
    CreatedView(conexion: DatabaseViewModel(), conexionAuth: AuthViewModel())
        .preferredColorScheme(.dark)
}
