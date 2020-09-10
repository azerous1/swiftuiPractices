//
//  ListAppViewModel .swift
//  ListApp
//
//  Created by Yichi Zhang  on 8/29/20.
//

import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id : String
    var toDoItem : String
    var priortiy : Double
}

class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}
