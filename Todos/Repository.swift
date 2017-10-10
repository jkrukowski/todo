//
//  Repository.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol TodoRepositoryType {
    func load(sort: SortType) -> [Todo]
    func load(predicate: NSPredicate, sort: SortType) -> [Todo]
    func add(todo: Todo)
    func remove(todo: Todo)
}

final class TodoRepository {
    let db: Realm
    init(db: Realm = try! Realm()) {
        self.db = db
    }
}

extension TodoRepository: TodoRepositoryType {
    func load(sort: SortType) -> [Todo] {
        return db.objects(TodoDbObject.self)
            .sorted(byKeyPath: sort.rawValue)
            .map(Todo.init)
    }
    func load(predicate: NSPredicate, sort: SortType) -> [Todo] {
        return db.objects(TodoDbObject.self)
            .filter(predicate)
            .sorted(byKeyPath: sort.rawValue)
            .map(Todo.init)
    }
    func add(todo: Todo) {
        try! db.write {
            let dbObject = TodoDbObject(model: todo)
            db.create(TodoDbObject.self, value: dbObject, update: true)
        }
    }
    func remove(todo: Todo) {
        guard let item = db.object(ofType: TodoDbObject.self, forPrimaryKey: todo.id) else {
            return
        }
        try! db.write {
            db.delete(item)
        }
    }
}
