//
//  DatabaseDatasource.swift
//  listtarea
//
//  Created by Jean L2 on 2/10/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Taskete: Identifiable, Decodable, Encodable {
    
    @DocumentID var id: String?
    let idMember: String?
    var title: String
    var description: String
    var dateCreated: String
    var dateEnd: String?
    var isReady: Bool
    var isFavorited: Bool
    var isActived: Bool
}

final class DatabaseDatasource {
    
    let database = Firestore.firestore()
    let collection = "mainlist"
    
    func getAllTasks(completionBlock: @escaping (Result<[Taskete],Error>) -> Void) {
        
        database.collection(collection).addSnapshotListener { query , error in
            
            if let realError = error {
                print("Error getting tasks: \(realError.localizedDescription)")
                completionBlock(.failure(realError))
                return
            }
            
            guard let documents = query?.documents.compactMap({ $0 }) else {
                completionBlock(.success([]))
                return
            }
            
            let allTask = documents.map { try? $0.data(as: Taskete.self) }
                .compactMap { $0 }
            
            completionBlock(.success(allTask))
        }
        
    }
    
    func createNewTask(newTask: Taskete) {
        try! database.collection(collection).addDocument(from: newTask)
    }
    
    func updateTask(newTask: Taskete) {
        
        guard let realId = newTask.id else {
            return
        }
        
        try! database.collection(collection).document(realId).setData(from: newTask)
    }
    
    func deleteTask(task: Taskete) {
        
        guard let realId = task.id else {
            return
        }
        
        database.collection(collection).document(realId).delete()
        
    }
    
}
