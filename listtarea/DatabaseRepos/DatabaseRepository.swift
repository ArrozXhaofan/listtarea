//
//  DatabaseRepository.swift
//  listtarea
//
//  Created by Jean L2 on 2/10/23.
//

import Foundation

final class DatabaseRepository {
    
    private let conexion: DatabaseDatasource
    
    init(conexion: DatabaseDatasource = DatabaseDatasource()) {
        self.conexion = conexion
    }
    
    func getAllTask(completionBlock: @escaping (Result<[Taskete],Error>) -> Void) {
        conexion.getAllTasks(completionBlock: completionBlock)
    }
    
    func createNewTask(newTask: Taskete) {
        conexion.createNewTask(newTask: newTask)
    }
    
    func updateTask(newTask: Taskete) {
        conexion.updateTask(newTask: newTask)
    }
    
    func deleteTask(task: Taskete) {
        conexion.deleteTask(task: task)
    }
    
}
