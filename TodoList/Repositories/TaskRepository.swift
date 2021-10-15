//
//  TaskRepository.swift
//  TodoList
//
//  Created by stefanini on 07/09/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class TaskRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
        db.collection("tasks")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId ?? "")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Task.self)
                }
            }
        }
    }
    
    func addTask(_ task: Task) {
        do {
            var taskToAdd = task
            taskToAdd.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("tasks").addDocument(from: taskToAdd)
        } catch {
            fatalError("Error \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task) {
        if let taskID = task.id {
            do {
                let _ = try db.collection("tasks").document(taskID).setData(from: task)
            } catch {
                fatalError("Error \(error.localizedDescription)")
            }
        }
    }
}
