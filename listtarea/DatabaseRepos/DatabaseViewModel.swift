//
//  DatabaseViewModel.swift
//  listtarea
//
//  Created by Jean L2 on 2/10/23.
//

import Foundation

enum updatingOption {
    case changeFavorite
    case changeReady
    case changeActive
}

final class DatabaseViewModel: ObservableObject {
    
    private let conexion: DatabaseRepository
    
    @Published var tasks: [Taskete] = []
    
    init(conexion: DatabaseRepository = DatabaseRepository()) {
        self.conexion = conexion
    }
    
    func getAllLinks() {
        
        conexion.getAllTask { [weak self] result in
            switch result {
            case .success(let task):
                self?.tasks = task
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func createNewTask(newTask: Taskete) {
        
        conexion.createNewTask(newTask: Taskete(idMember: newTask.idMember, title: newTask.title, description: newTask.description, dateCreated: newTask.dateCreated, dateEnd: newTask.dateEnd, isReady: newTask.isReady, isFavorited: newTask.isFavorited, isActived: newTask.isActived))
    }
    
    func updateTask(newTask: Taskete, updateValue: updatingOption) {
        
        var currentTask =
        Taskete(id: newTask.id,
                idMember: newTask.idMember,
                title: newTask.title,
                description: newTask.description,
                dateCreated: newTask.dateCreated,
                dateEnd: newTask.dateEnd,
                isReady: newTask.isReady,
                isFavorited: newTask.isFavorited,
                isActived: newTask.isActived)
        
        if updateValue == .changeActive {
            
            currentTask.isActived = !currentTask.isActived
            
        } else if updateValue == .changeFavorite {
            
            currentTask.isFavorited = !currentTask.isFavorited
            
        } else if updateValue == .changeReady {
            
            currentTask.isReady = !currentTask.isReady
        }
        
        conexion.updateTask(newTask: currentTask)
    }
    
    func deleteTask(task: Taskete) {
        conexion.deleteTask(task: task)
    }
    
}
