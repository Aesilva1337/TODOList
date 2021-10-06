//
//  ContentView.swift
//  TodoList
//
//  Created by stefanini on 07/09/21.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskList = TaskListViewModel()
    var test = testDataTask
    
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskList.taskCellViewModel) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                    }
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskList.addTask(task: task)
                            self.presentAddNewItem = false
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle()}, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Adicionar nova tarefa")
                    }
                })
                .padding()
            }
            .navigationBarTitle("Tarefas")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
            TextField("Titulo", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
        }
    }
}
