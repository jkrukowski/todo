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
    func load(sort: SortType)
    func filter(name: String)
    func add(todo: Todo)
    func remove(todo: Todo)
}

final class TodoListViewModel: ViewModel {
    let todos: Observable<[Todo]>
    fileprivate(set) var sort: SortType = .defaultValue
    fileprivate let todosInput = PublishSubject<[Todo]>()
    fileprivate let repository: TodoRepositoryType
    
    init(repository: TodoRepositoryType = TodoRepository()) {
        self.todos = todosInput
        self.repository = repository
        super.init()
    }
}

extension TodoListViewModel: TodoListViewModelType {
    func load(sort: SortType) {
        self.sort = sort
        todosInput.onNext(repository.load(sort: sort))
    }
    func filter(name: String) {
        let predicate = NSPredicate(format: "name BEGINSWITH[c] %@", name)
        todosInput.onNext(repository.load(predicate: predicate, sort: self.sort))
    }
    func add(todo: Todo) {
        repository.add(todo: todo)
        load(sort: self.sort)
    }
    func remove(todo: Todo) {
        repository.remove(todo: todo)
        load(sort: self.sort)
    }
}
