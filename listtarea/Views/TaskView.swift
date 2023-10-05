//
//  TaskView.swift
//  listtarea
//
//  Created by Jean L2 on 2/10/23.
//

import SwiftUI

struct TaskView: View {
    
    @ObservedObject var conexion: DatabaseViewModel
    @ObservedObject var conexionAuth: AuthViewModel
    
    var lista: [Taskete] = []
    
    var body: some View {
        
        List(conexion.tasks.filter { $0.idMember == conexionAuth.activedUser?.email}) { lista in
            
            HStack {
                
                VStack {
                    
                    Text(lista.title)
                        .font(.title)
                        .bold()
                    
                    Text("\(lista.dateCreated) - \(lista.dateEnd ?? "Not ready")")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack {
                    if lista.isReady {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.bottom, 1)
                    }else {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.blue)
                            .padding(.bottom, 1)
                    }
                    if lista.isFavorited {
                        Image(systemName: "star.circle.fill")
                            .foregroundColor(.yellow)
                            .padding(.bottom, 1)
                    }else {
                        Image(systemName: "star.circle")
                            .foregroundColor(.yellow)
                            .padding(.bottom, 1)
                    }
                    if lista.isActived {
                        Image(systemName: "command.circle.fill")
                            .foregroundColor(.green)
                            .padding(.bottom, 1)
                    }else {
                        Image(systemName: "command.circle")
                            .foregroundColor(.green)
                            .padding(.bottom, 1)
                    }
                }
            }
            .swipeActions(edge: .trailing) {
                Button {
                    conexion.updateTask(newTask: lista, updateValue: .changeReady)
                    print("funciona")
                } label: {
                    Image(systemName: "checkmark")
                    
                }
                .tint(.blue)
                
                Button {
                    conexion.updateTask(newTask: lista, updateValue: .changeFavorite)
                } label: {
                    Image(systemName: "star")
                }
                .tint(.yellow)
                
                Button {
                    conexion.updateTask(newTask: lista, updateValue: .changeActive)
                } label: {
                    Image(systemName: "command")
                }
                .tint(.green)
                
            }
            .swipeActions(edge: .leading) {
                Button {
                    conexion.deleteTask(task: lista)
                } label: {
                    Image(systemName: "trash")
                }
                .tint(.red)
            }
        
        
        }
        .task {
            conexion.getAllLinks()
        }
        .refreshable {
            conexion.getAllLinks()
        }
        
        
    }
    
}

#Preview {
    TaskView(conexion: DatabaseViewModel(), conexionAuth: AuthViewModel())
        .preferredColorScheme(.dark)
}
