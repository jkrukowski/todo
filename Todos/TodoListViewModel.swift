//
//  TodoListViewModel.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RxSwift

protocol TodoListViewModelType {
    var todos: Observable<[Todo]> { get }
    var sort: SortType { get }
    func load()
    func load(sort: SortType)
    func filter(name: String)
    func add(todo: Todo)
    func remove(todo: Todo)
    func get(byIndex index: Int) -> Todo
}

final class TodoListViewModel: ViewModel {
    let todos: Observable<[Todo]>
    fileprivate(set) var sort: SortType = .defaultValue
    fileprivate let todosInput = PublishSubject<[Todo]>()
    fileprivate let repository: TodoRepositoryType
    fileprivate var loadedTodos = [Todo]()
    
    init(repository: TodoRepositoryType = TodoRepository()) {
        self.todos = todosInput
        self.repository = repository
        super.init()
    }
}

extension TodoListViewModel: TodoListViewModelType {
    func load() {
        load(sort: sort)
    }
    func load(sort: SortType) {
        self.sort = sort
        self.loadedTodos = repository.load(sort: sort)
        todosInput.onNext(loadedTodos)
    }
    func filter(name: String) {
        let predicate = NSPredicate(format: "name BEGINSWITH[c] %@", name)
        self.loadedTodos = repository.load(predicate: predicate, sort: self.sort)
        todosInput.onNext(loadedTodos)
    }
    func add(todo: Todo) {
        repository.add(todo: todo)
        load(sort: self.sort)
    }
    func remove(todo: Todo) {
        repository.remove(todo: todo)
        load(sort: self.sort)
    }
    func get(byIndex index: Int) -> Todo {
        return loadedTodos[index]
    }
}
