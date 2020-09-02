//
//  ContentView.swift
//  ListApp
//
//  Created by Yichi Zhang  on 8/29/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var taskStore = TaskStore()
    @State private var newToDo : String = ""
    @State private var newPriority : Double = 0
    
    var searchBar : some View {
        HStack {
            TextField("Enter in a new task", text: self.$newToDo)
                .padding(.leading, 20)
            Button(action: self.addNewToDo, label: {
                Text("Add new to do")
            }).padding(.trailing, 20).disabled(isDisabled())
        }.padding(.top, 20)
    }
    
    var slider : some View {
        VStack {
            Slider(value: $newPriority, in: 1...5, step: 1)
                .padding(.leading, 20).padding(.trailing, 20)
            Text(String(newPriority))
            Text("Slide to set priority")
        }
    }
    
    func addNewToDo() {
        taskStore.tasks.append(
            Task(id: String(taskStore.tasks.count + 1), toDoItem: newToDo, priortiy: newPriority)
        )
        self.newToDo = ""
    }
    
    func isDisabled() -> Bool {
        newToDo.count == 0
    }
    
    // MARK: this funtion re-sort the task array by each task's pirority after a new task is added.
   // func reOrderTasks() {
    //    taskStore.tasks.sort(by: taskStore.$t)
   // }
    
    var body: some View {
        NavigationView {
            VStack {
                searchBar
                //slider
                List {
                    ForEach(self.taskStore.tasks) { task in
                        Text(task.toDoItem)
                    }.onMove(perform: self.move)
                    .onDelete(perform: self.delete)
                }.navigationBarTitle("Priortized Tasks")
                .navigationBarItems(trailing: EditButton())
                
            }
        }
    }
    
    // function for moving each task item when clicked the edit button
    func move(from source : IndexSet, to destination : Int) {
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets : IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
