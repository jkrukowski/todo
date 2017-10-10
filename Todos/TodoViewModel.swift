//
//  TodoViewModel.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RxSwift

protocol TodoViewModelType {
    var todo: Todo { get set }
    func commit()
}

final class TodoViewModel: ViewModel {
    var todo: Todo
    fileprivate let repository: TodoRepositoryType
    
    init(todo: Todo = Todo(), repository: TodoRepositoryType = TodoRepository()) {
        self.todo = todo
        self.repository = repository
        super.init()
    }
}

extension TodoViewModel: TodoViewModelType {
    func commit() {
        repository.add(todo: todo)
    }
}
