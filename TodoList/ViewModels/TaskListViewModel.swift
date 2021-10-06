//
//  TaskListViewModel.swift
//  TodoList
//
//  Created by stefanini on 07/09/21.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    var taskRepository = TaskRepository()
    @Published var taskCellViewModel = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        taskRepository.$tasks.map { tasks in
            tasks.map { task in
                TaskCellViewModel(task: task)
            }
        }
        .assign(to: \.taskCellViewModel, on: self)
        .store(in: &cancellables)
    }
    
    func addTask(task: Task) {
        taskRepository.addTask(task)
    }
}
