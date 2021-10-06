//
//  Task.swift
//  TodoList
//
//  Created by stefanini on 07/09/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
}

#if DEBUG
let testDataTask = [
    Task(title: "Task1", completed: false),
    Task(title: "Task2", completed: true),
    Task(title: "Task3", completed: false),
    Task(title: "Task4", completed: true)
]
#endif
