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
    var todo: Observable<Todo?> { get }
    func load()
}

final class TodoViewModel: ViewModel {
    let todo: Observable<Todo?>
    fileprivate let todoInput = PublishSubject<Todo?>()
    fileprivate var loadedTodo: Todo?
    fileprivate let repository: TodoRepositoryType
    
    init(todo: Todo?, repository: TodoRepositoryType = TodoRepository()) {
        self.loadedTodo = todo
        self.todo = todoInput
        self.repository = repository
        super.init()
    }
}

extension TodoViewModel: TodoViewModelType {
    func load() {
        self.todoInput.onNext(loadedTodo)
    }
}
